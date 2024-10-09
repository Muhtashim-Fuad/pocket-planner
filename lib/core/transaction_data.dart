import 'package:pocket_planner/style.dart';

class TransactionData {
  final String name;
  final String description;
  final TransactionType transactionType;
  final double amount;
  final DateTime time;
  late final primaryColor;

  bool _isMarked = false;
  bool _isInTrash = false;

  get isInTrash => _isInTrash;
  get isMarked => _isMarked;

  TransactionData({
    required this.name,
    required this.description,
    required this.transactionType,
    required this.amount,
    required this.time,
  }) {
    primaryColor = transactionType == TransactionType.income
        ? StyleData.primaryCreditColor
        : StyleData.primaryDebitColor;
  }

  void toggleMarkState() => _isMarked = !_isMarked;
  void moveToTrash() => _isInTrash = true;
  void restoreFromTrash() => _isInTrash = false;
}

enum TransactionType {
  income,
  expense,
}