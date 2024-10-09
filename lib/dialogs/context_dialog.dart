import 'package:flutter/material.dart';
import 'package:pocket_planner/core/transaction_archive.dart';
import 'package:pocket_planner/core/transaction_data.dart';
import 'package:pocket_planner/dialogs/confirm_dialog.dart';
import 'package:pocket_planner/dialogs/input_dialog.dart';
import 'package:provider/provider.dart';

class ContextDialog extends StatelessWidget {
  ContextDialog({super.key, required this.transactionData});
  final TransactionData transactionData;

  void onViewTransaction(BuildContext context) {
    
  }

  void onMarkTransaction(BuildContext context) {
    Navigator.pop(context);
    Provider.of<TransactionArchive>(context, listen: false)
        .toggleMarkState(transactionData);
  }

  void onDuplicateTransaction(BuildContext context) {
    Navigator.pop(context);
    Provider.of<TransactionArchive>(context, listen: false).addTransactionData(
      TransactionData(
        name: transactionData.name,
        description: transactionData.description,
        transactionType: transactionData.transactionType,
        amount: transactionData.amount,
        time: DateTime.now(),
      ),
    );
  }

  void onEditTransaction(BuildContext context) {
    Navigator.pop(context);
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) => ChangeNotifierProvider.value(
        value: Provider.of<TransactionArchive>(_, listen: false),
        child: Container(
          padding: MediaQuery.of(_).viewInsets,
          child: BottomInputField(
            titleController: TextEditingController(text: transactionData.name),
            amountController:
                TextEditingController(text: transactionData.amount.toString()),
            descriptionController:
                TextEditingController(text: transactionData.description),
            selectedTransactionType: transactionData.transactionType,
            headerLabel: "Edit Transaction",
            buttonLabel: "Update Information",
            transactionInstance: transactionData,
          ),
        ),
      ),
    );
  }

  void onRestoreTransaction(BuildContext context) {
    Navigator.pop(context);
    Provider.of<TransactionArchive>(context, listen: false)
        .restoreTransactionData(transactionData);
  }

  void onDeleteTransaction(BuildContext context) {
    Navigator.pop(context);
    showDialog(
        context: context,
        builder: (context) => ConfirmDialog(
              contentText: "Are you sure you want to remove all transactions?",
              onConfirmCallback: () =>
                  Provider.of<TransactionArchive>(context, listen: false)
                      .moveToTrash(transactionData),
            ));
  }

  late final List<TransactionAction> actions = [
    TransactionAction(
        icon: Icons.crop_free, label: "View", onPressed: onViewTransaction),
    TransactionAction(
        icon: Icons.create, label: "Edit", onPressed: onEditTransaction),
    TransactionAction(
        icon: Icons.content_copy,
        label: "Copy",
        onPressed: onDuplicateTransaction),
    transactionData.isMarked
        ? TransactionAction(
            icon: Icons.star_border,
            label: "Unmark",
            onPressed: onMarkTransaction)
        : TransactionAction(
            icon: Icons.star, label: "Mark", onPressed: onMarkTransaction),
    transactionData.isInTrash
        ? TransactionAction(
            icon: Icons.delete_outline,
            label: "Restore",
            onPressed: onRestoreTransaction)
        : TransactionAction(
            icon: Icons.delete,
            label: "Delete",
            onPressed: onDeleteTransaction),
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: IntrinsicHeight(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            for (TransactionAction action in actions)
              Expanded(
                child: TextButton(
                  onPressed: () => action.onPressed(context),
                  child: Column(
                    children: [
                      Icon(
                        action.icon,
                        size: 20.0,
                      ),
                      const SizedBox(height: 4.0),
                      Text(
                        action.label,
                        style: const TextStyle(
                            letterSpacing: -0.1,
                            fontSize: 11.0,
                            fontVariations: [
                              FontVariation("wght", 300),
                            ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class TransactionAction {
  final IconData icon;
  final String label;
  final void Function(BuildContext) onPressed;

  TransactionAction(
      {required this.icon, required this.label, required this.onPressed});
}
