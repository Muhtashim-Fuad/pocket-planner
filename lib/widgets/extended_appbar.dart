import 'package:flutter/material.dart';

class ExtendedAppBar {
  static AppBar basicAppbar = AppBar(
    title: const Padding(
      padding: EdgeInsets.only(left: 4.0),
      child: Text(
        "Pocket Planner",
        style: TextStyle(
          fontFamily: "Montserrat",
          fontVariations: [
            FontVariation(
              "wght",
              700,
            ),
          ],
          letterSpacing: -0.5,
        ),
      ),
    ),
  );
}
