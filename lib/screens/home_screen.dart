import 'dart:math';

import 'package:pocket_planner/core/constants.dart';
import 'package:pocket_planner/screens/transactions_screen.dart';
import 'package:pocket_planner/widgets/empty_list_viewer.dart';
import 'package:pocket_planner/widgets/extended_list_tile.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:pocket_planner/core/navigation_handler.dart';
import 'package:pocket_planner/core/transaction_archive.dart';
import 'package:pocket_planner/core/transaction_data.dart';
import 'package:pocket_planner/style.dart';
import 'package:pocket_planner/widgets/current_amount_viewer.dart';
import 'package:pocket_planner/widgets/extended_appbar.dart';
import 'package:pocket_planner/widgets/extended_bar_graph.dart';
import 'package:pocket_planner/widgets/floating_add_button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<TransactionArchive>(
      builder: (context, value, child) => Scaffold(
        appBar: ExtendedAppBar.basicAppbar,
        floatingActionButton: const FloatingAddButton(),
        body: ListView(
          children: [
            const SizedBox(height: 14.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: Row(
                children: [
                  CurrentAmountWidget(
                    transactiontype: TransactionType.income,
                    primaryColor: StyleData.primaryCreditColor,
                    value: value
                        .getTotal(
                            value.getTransactionsOfType(TransactionType.income))
                        .toStringAsFixed(2),
                  ),
                  const SizedBox(width: 12.0),
                  CurrentAmountWidget(
                    transactiontype: TransactionType.expense,
                    primaryColor: StyleData.primaryDebitColor,
                    value: value
                        .getTotal(value.getTransactionsOfType(TransactionType.expense))
                        .toStringAsFixed(2),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 14.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 2.0),
              child: ExtendedBarGraph(
                transactions: value.getAllTransactions().sublist(
                  0,
                  min<int>(Constants.graphRecordsCount, value.getAllTransactions().length),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Recently Added",
                    style: Theme.of(context).textTheme.displayMedium?.copyWith(
                      letterSpacing: -0.1,
                      fontSize: 16.0,
                      fontVariations: [
                        const FontVariation("wght", 700),
                      ],
                    ),
                  ),
                  TextButton(
                    onPressed: () => NavigationHandler.goTo(context, const TransactionsScreen()),
                    child: Text(
                      "View All",
                      style: Theme.of(context).textTheme.displayMedium?.copyWith(
                        color: Theme.of(context).primaryColor.withAlpha(185),
                        letterSpacing: -0.1,
                        fontSize: 14.0,
                        fontVariations: [
                          const FontVariation("wght", 400),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              child: value.getAllTransactions().isEmpty
              ? const EmptyListViewer()
              : Column(
                children: [
                  for (TransactionData data in value.getAllTransactions().sublist(
                    0,
                    min<int>(Constants.maxRendentlyAddedCount, value.getAllTransactions().length)
                  ))
                    ExtendedListTile(data: data),
                ],
              ),
            ),
            const SizedBox(height: 14.0),
          ],
        ),
      ),
    );
  }
}
