import 'package:flutter/material.dart';
import 'package:pocket_planner/style.dart';

class ConfirmDialog extends StatelessWidget {
  const ConfirmDialog({super.key, required this.onConfirmCallback, required this.contentText});

  final String contentText;
  final VoidCallback onConfirmCallback;

  void onConfirm(BuildContext context) {
    Navigator.pop(context);
    onConfirmCallback();
  }

  void onCancel(BuildContext context) {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      titlePadding: const EdgeInsets.only(left: 24.0, top: 20.0, bottom: 14.0),
      contentPadding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 0),
      title: const Text(
        "Confirm Action",
        style: TextStyle(
          fontSize: 16.0,
          fontVariations: [FontVariation("wght", 500)],
        ),
      ),
      content: Text(
        contentText,
        style: const TextStyle(
          letterSpacing: -0.1,
          wordSpacing: 1.0,
          fontSize: 14.0,
          fontVariations: [FontVariation("wght", 300)],
        ),
      ),
      actions: [
        TextButton(
            child: Text(
              "Confirm",
              style: StyleData.inputTextStyle,
              ),
              onPressed: () => onConfirm(context)),
        TextButton(
            child: Text(
              "Cancel",
              style: StyleData.inputTextStyle,
            ),
            onPressed: () => onCancel(context)),
      ],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
    );
  }
}
