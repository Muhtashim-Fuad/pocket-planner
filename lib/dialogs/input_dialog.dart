import 'package:flutter/foundation.dart';
import 'package:pocket_planner/style.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:pocket_planner/core/transaction_archive.dart';
import 'package:pocket_planner/core/transaction_data.dart';

class BottomInputField extends StatefulWidget {
  const BottomInputField({
    super.key,
    required this.titleController,
    required this.amountController,
    required this.descriptionController,
    this.selectedTransactionType = TransactionType.expense,
    this.headerLabel = "New Transaction",
    this.buttonLabel = "Add To List",
    this.transactionInstance,
  });

  final TextEditingController titleController;
  final TextEditingController amountController;
  final TextEditingController descriptionController;
  final TransactionType selectedTransactionType;
  final String headerLabel;
  final String buttonLabel;
  final TransactionData? transactionInstance;

  @override
  State<StatefulWidget> createState() => BottomInputFieldState();
}

class BottomInputFieldState extends State<BottomInputField> {
  late TransactionType? _transactionType = widget.selectedTransactionType;
  VoidCallback? onAddToListCallback;

  void onTextChange(String newText) {
    setState(() {
      onAddToListCallback = widget.titleController.text.isEmpty ||
              widget.amountController.text.isEmpty
          ? null
          : () {
              Navigator.pop(context);
              TransactionArchive archive =
                  Provider.of<TransactionArchive>(context, listen: false);

              if (widget.transactionInstance == null) {
                archive.addTransactionData(
                  TransactionData(
                    name: widget.titleController.text,
                    description: widget.descriptionController.text,
                    transactionType: _transactionType!,
                    amount: double.parse(widget.amountController.text),
                    time: DateTime.now(),
                  ),
                );
              } else {
                int index = archive
                    .getAllTransactions()
                    .indexOf(widget.transactionInstance!);
                archive.deleteTransactionData(widget.transactionInstance!);
                archive.insertTransactionData(
                  TransactionData(
                    name: widget.titleController.text,
                    description: widget.descriptionController.text,
                    transactionType: _transactionType!,
                    amount: double.parse(widget.amountController.text),
                    time: widget.transactionInstance!.time,
                  ),
                  index,
                );
              }
            };
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 18.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          for (Widget widget in [
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text(
                widget.headerLabel,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.displayMedium?.copyWith(
                      letterSpacing: 0.1,
                      fontSize: 18.0,
                      fontVariations: [
                        const FontVariation("wght", 600),
                      ],
                    ),
              ),
            ),
            TextField(
              keyboardType: TextInputType.name,
              decoration: const InputDecoration(hintText: "Transaction Title"),
              controller: widget.titleController,
              onChanged: onTextChange,
              style: StyleData.inputTextStyle,
            ),
            TextField(
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(hintText: "Transaction Amount"),
              controller: widget.amountController,
              onChanged: onTextChange,
              style: StyleData.inputTextStyle,
            ),
            TextField(
              keyboardType: TextInputType.name,
              decoration:
                  const InputDecoration(hintText: "Transaction Description"),
              controller: widget.descriptionController,
              onChanged: onTextChange,
              style: StyleData.inputTextStyle,
            ),
            Row(
              children: [
                Flexible(
                  child: ListTile(
                    title: Text(
                      "Income",
                      style: StyleData.radioTextStyle.copyWith(
                        color: Theme.of(context).colorScheme.inverseSurface,
                      ),
                    ),
                    leading: Radio<TransactionType>(
                      value: TransactionType.income,
                      groupValue: _transactionType,
                      onChanged: (TransactionType? newValue) {
                        setState(() {
                          _transactionType = newValue;
                        });
                      },
                    ),
                  ),
                ),
                Flexible(
                  child: ListTile(
                    title: Text(
                      "Expense",
                      style: StyleData.radioTextStyle.copyWith(
                        color: Theme.of(context).colorScheme.inverseSurface,
                      ),
                    ),
                    leading: Radio<TransactionType>(
                      value: TransactionType.expense,
                      groupValue: _transactionType,
                      onChanged: (TransactionType? newValue) {
                        setState(() {
                          _transactionType = newValue;
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: ElevatedButton(
                onPressed: onAddToListCallback,
                child: Text(widget.buttonLabel),
              ),
            ),
          ])
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 2.0),
              child: widget,
            ),
        ],
      ),
    );
  }
}
