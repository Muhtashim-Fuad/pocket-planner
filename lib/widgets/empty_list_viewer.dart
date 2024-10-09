import 'package:flutter/material.dart';

class EmptyListViewer extends StatelessWidget {
  const EmptyListViewer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 18.0),
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Icon(
            Icons.paste_rounded,
            size: 28.0,
            color: Color.fromARGB(255, 150, 150, 150),
          ),
          SizedBox(height: 4.0),
          Text(
            "No Transactions",
            textAlign: TextAlign.center,
            style: TextStyle(color: Color.fromARGB(255, 150, 150, 150),),
          ),
        ],
      ),
    );
  }
}
