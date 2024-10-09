import 'package:pocket_planner/core/transaction_archive.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:pocket_planner/screens/home_screen.dart';
import 'package:pocket_planner/style.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<TransactionArchive>(
      create: (_) => TransactionArchive(),
      builder: (context, child) => 
        MaterialApp(
          theme: StyleData.lightThemeData,
          darkTheme: StyleData.darkThemeData,
          themeMode: ThemeMode.system,
          home: const HomeScreen(),
        ),
    );
  }
}
