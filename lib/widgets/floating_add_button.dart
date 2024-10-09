import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:pocket_planner/core/transaction_archive.dart';
import 'package:pocket_planner/dialogs/input_dialog.dart';

class FloatingAddButton extends StatelessWidget {
  const FloatingAddButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        final TransactionArchive archive = Provider.of<TransactionArchive>(context, listen: false);
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          builder: (_) => ChangeNotifierProvider.value(
            value: archive,
            child: Container(
              padding: MediaQuery.of(context).viewInsets,
              child: BottomInputField(
                titleController: TextEditingController(text: ""),
                amountController: TextEditingController(text: ""),
                descriptionController: TextEditingController(text: ""),
              ),
            ),
          ),
        );
      },
      child: const Icon(Icons.add),
    );
  }
}
