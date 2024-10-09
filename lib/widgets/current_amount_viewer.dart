import 'package:flutter/material.dart';
import 'package:pocket_planner/core/constants.dart';
import 'package:pocket_planner/core/transaction_data.dart';

class CurrentAmountWidget extends StatelessWidget {
  final TransactionType transactiontype;
  final String value;
  final primaryColor;

  late final String text;

  CurrentAmountWidget(
      {super.key,
      required this.transactiontype,
      required this.value,
      required this.primaryColor}) {
    text = transactiontype == TransactionType.income
        ? "Total Earning"
        : "Total Expenses";
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 12.0),
        decoration: BoxDecoration(
          color: primaryColor.withAlpha(65),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              text,
              style: Theme.of(context).textTheme.displayMedium?.copyWith(
                color: primaryColor[500],
                letterSpacing: -0.5,
                fontSize: 14.0,
                fontVariations: [
                  const FontVariation("wght", 400),
                ],
              ),
            ),
            const SizedBox(height: 4.0),
            Text(
              "${Constants.currencySymbol} $value",
              textAlign: TextAlign.left,
              style: Theme.of(context).textTheme.displayMedium?.copyWith(
                color: primaryColor[500],
                fontSize: 20.0,
                fontVariations: [
                  const FontVariation("wght", 300),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
