import 'package:flutter/material.dart';
import 'package:pocket_planner/core/constants.dart';
import 'package:pocket_planner/core/transaction_archive.dart';
import 'package:pocket_planner/core/transaction_data.dart';
import 'package:pocket_planner/dialogs/context_dialog.dart';
import 'package:pocket_planner/style.dart';
import 'package:provider/provider.dart';

class ExtendedListTile extends StatelessWidget {
  const ExtendedListTile({super.key, required this.data});
  final TransactionData data;

  void onLongPressCallback(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) => ChangeNotifierProvider<TransactionArchive>.value(
        value: Provider.of<TransactionArchive>(context, listen: false),
        child: ContextDialog(transactionData: data),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onLongPress: () => onLongPressCallback(context),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                color: data.primaryColor.withAlpha(65),
                borderRadius: BorderRadius.circular(6.0),
              ),
              margin: const EdgeInsets.fromLTRB(0.0, 4.0, 4.0, 4.0),
              padding: const EdgeInsets.all(6.0),
              child: Icon(
                data.transactionType == TransactionType.income
                  ? Icons.home_repair_service_rounded
                  : Icons.shopping_cart,
                color: data.primaryColor.withAlpha(205),
                size: 28.0,
                ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      data.name,
                      textAlign: TextAlign.left,
                      style: StyleData.listTileTextStyle.copyWith(
                        color: Theme.of(context).colorScheme.inverseSurface,
                        letterSpacing: -0.25,
                        fontVariations: [
                          const FontVariation("wght", 400),
                        ],
                      ),
                    ),
                    Text(
                      data.time.toString().substring(0, 10),
                      textAlign: TextAlign.left,
                      style: StyleData.listTileTextStyle.copyWith(
                        color: const Color.fromARGB(255, 124, 124, 124),
                        fontVariations: [
                          const FontVariation("wght", 400),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Text(
              (data.transactionType == TransactionType.income ? "+" : "-") + Constants.currencySymbol + data.amount.toStringAsFixed(2),
              style: StyleData.listTileTextStyle.copyWith(
                color: Theme.of(context).colorScheme.inverseSurface,
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