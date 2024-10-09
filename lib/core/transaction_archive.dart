import 'package:flutter/material.dart';
import 'package:pocket_planner/core/transaction_data.dart';
import 'package:pocket_planner/core/data.dart';

class TransactionArchive extends ChangeNotifier {
  final List<TransactionData> _transactions = Data.transactionList;
  final List<TransactionData> _trash = [];
  final List<TransactionData> _favorites = [];

  List<TransactionData> getAllTransactions() => List.unmodifiable(_transactions);

  List<TransactionData> getMarkedTransactions() => _favorites;
  List<TransactionData> getTransactionsFromTrash() => _trash;

  List<TransactionData> getTransactionsOn(DateTime date) {
    List<TransactionData> transactionList = [];

    for (TransactionData data in _transactions) {
      if (data.time.day == date.day &&
          data.time.month == date.month &&
          data.time.year == date.year) {
        transactionList.add(data);
      }
    }

    return transactionList;
  }

  List<TransactionData> getTransactionsBetween(
      DateTime startTime, DateTime endTime) {
    _transactions.sort((a, b) => b.time.compareTo(a.time));
    return _transactions
        .where((transactionData) =>
            transactionData.time.isAfter(startTime) &&
            transactionData.time.isBefore(endTime))
        .toList();
  }

  List<TransactionData> getTransactionsOfType(
      TransactionType selectedTransactionData) {
    _transactions.sort((a, b) => b.time.compareTo(a.time));
    return _transactions
        .where((transactionData) =>
            transactionData.transactionType == selectedTransactionData)
        .toList();
  }

  void addTransactionData(TransactionData transactionData) {
    _transactions.add(transactionData);
    notifyListeners();
  }

  void deleteTransactionData(TransactionData transactionData) {
    _favorites.remove(transactionData);
    _transactions.remove(transactionData);
    _trash.remove(transactionData);
    notifyListeners();
  }

  void moveToTrash(TransactionData transactionData) {
    _favorites.remove(transactionData);
    _transactions.remove(transactionData);
    _trash.add(transactionData);
    transactionData.moveToTrash();
    notifyListeners();
  }

  void restoreTransactionData(TransactionData transactionData) {
    _trash.remove(transactionData);
    _transactions.add(transactionData);
    transactionData.restoreFromTrash();
    notifyListeners();
  }

  void insertTransactionData(TransactionData transactionData, int index) {
    _transactions.insert(index, transactionData);
    notifyListeners();
  }

  void toggleMarkState(TransactionData transactionData) {
    if (transactionData.isMarked) {
      _favorites.remove(transactionData);
    } else {
      _favorites.add(transactionData);
    }
    transactionData.toggleMarkState();
    notifyListeners();
  }

  void clearTransactionData() {
    _transactions.clear();
    notifyListeners();
  }

  double getMaximumAmount(List<TransactionData> transactionsToCompare) {
    if (transactionsToCompare.isEmpty) {
      return 0;
    }

    double maxAmount = transactionsToCompare[0].amount;

    for (var transaction in transactionsToCompare) {
      if (transaction.amount > maxAmount) {
        maxAmount = transaction.amount;
      }
    }
    return maxAmount;
  }

  double getTotal(List<TransactionData> transactions) {
    double sum = 0;

    for (TransactionData transactionData in transactions) {
      sum += transactionData.amount;
    }

    return sum;
  }
}
