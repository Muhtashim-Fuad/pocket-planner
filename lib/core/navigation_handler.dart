import 'package:flutter/material.dart';

class NavigationHandler {
  static void goTo(BuildContext context, Widget pageWidget){
    Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => pageWidget,
            ),
    );
  }
}