import 'package:intl/intl.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:pocket_planner/core/constants.dart';
import 'package:pocket_planner/core/transaction_archive.dart';
import 'package:pocket_planner/core/transaction_data.dart';
import 'package:provider/provider.dart';

class ExtendedBarGraph extends StatelessWidget {
  const ExtendedBarGraph({super.key, required this.transactions});
  final List<TransactionData> transactions;

  static const BorderRadius _borderData = BorderRadius.only(
    topLeft: Radius.circular(2.0),
    topRight: Radius.circular(2.0),
    bottomLeft: Radius.zero,
    bottomRight: Radius.zero,
  );

  @override
  Widget build(BuildContext context) {
    //TODO: Modify to avoid unnecessary iteration
    TransactionArchive archive = Provider.of<TransactionArchive>(context);

    final DateTime currentTime = DateTime.now();

    List<double> recentIncomeSums = [];
    List<double> recentExpenseSums = [];

    for (int i = 0; i < Constants.graphRecordsCount; i++) {
      double recentIncomeSum = 0;
      double recentExpenseSum = 0;
      List<TransactionData> recentTransations =
          archive.getTransactionsOn(currentTime.subtract(Duration(days: i)));
      for (var transaction in recentTransations) {
        if (transaction.transactionType == TransactionType.income) {
          recentIncomeSum += transaction.amount;
        } else {
          recentExpenseSum += transaction.amount;
        }
      }
      recentExpenseSums.add(recentExpenseSum);
      recentIncomeSums.add(recentIncomeSum);
    }

    double maxValue = archive.getMaximumAmount(archive.getAllTransactions());

    return Card(
      color: Theme.of(context).brightness == Brightness.dark ? const Color.fromARGB(255, 31, 31, 31) : const Color.fromARGB(255, 252, 252, 252),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
        child: AspectRatio(
          aspectRatio: 4 / 3,
          child: BarChart(
            BarChartData(
              maxY: maxValue,
              titlesData: FlTitlesData(
                topTitles:
                    const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                leftTitles:
                    const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                rightTitles:
                    const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    reservedSize: 32.0,
                    showTitles: true,
                    getTitlesWidget: (value, meta) => SideTitleWidget(
                      axisSide: meta.axisSide,
                      child: Text(
                        DateFormat('EEE').format(currentTime
                            .subtract(Duration(days: (value - 1).toInt(),),),),
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.inverseSurface,
                          letterSpacing: -0.5,
                          fontFamily: "Montserrat",
                          fontSize: 14.0,
                          fontVariations: const [FontVariation("wght", 300)],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              gridData: const FlGridData(
                show: true,
                drawVerticalLine: false,
              ),
              borderData: FlBorderData(show: false),
              barGroups: [
                for (int i = 0; i < Constants.graphRecordsCount; i++)
                  BarChartGroupData(
                    x: i + 1,
                    barsSpace: 0,
                    barRods: [
                      BarChartRodData(
                        toY: recentIncomeSums[i],
                        borderRadius: _borderData,
                        color: Colors.blue,
                        width: 18.0,
                      ),
                      BarChartRodData(
                        toY: recentExpenseSums[i],
                        borderRadius: _borderData,
                        color: Colors.red,
                        width: 18.0,
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
