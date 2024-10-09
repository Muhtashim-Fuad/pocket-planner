import 'package:pocket_planner/dialogs/confirm_dialog.dart';
import 'package:pocket_planner/widgets/empty_list_viewer.dart';
import 'package:pocket_planner/widgets/extended_appbar.dart';
import 'package:pocket_planner/widgets/extended_list_tile.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:pocket_planner/core/transaction_archive.dart';
import 'package:pocket_planner/core/transaction_data.dart';
import 'package:pocket_planner/widgets/floating_add_button.dart';

class TransactionsScreen extends StatefulWidget {
  const TransactionsScreen({super.key});
  @override
  State<StatefulWidget> createState() => TransactionsScreenState();
}

class TransactionsScreenState extends State<TransactionsScreen> {
  int _selectedIndex = 0;

  void onTap(int selectedIndex) {
    setState(() {
      _selectedIndex = selectedIndex;
    });
  }

  void onClearTransactions() {
    showDialog(
      context: context,
      builder:(context) => ConfirmDialog(
        contentText: "Are you sure you want to remove all transactions?",
        onConfirmCallback: () => Provider.of<TransactionArchive>(context, listen: false).clearTransactionData(),
      )
    );
  }

  List<TransactionData> getList(TransactionArchive archive) {
    return [
      archive.getAllTransactions(),
      archive.getTransactionsOfType(TransactionType.income),
      archive.getTransactionsOfType(TransactionType.expense),
      archive.getMarkedTransactions(),
      archive.getTransactionsFromTrash(),
    ][_selectedIndex];
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TransactionArchive>(
      builder: (BuildContext context, value, Widget? child) => Scaffold(
        appBar: ExtendedAppBar.basicAppbar,
        floatingActionButton: const FloatingAddButton(),
        bottomNavigationBar: dafaultNavbar(),
        body: value.getAllTransactions().isEmpty
            ? const EmptyListViewer()
            : ListView.builder(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                itemCount: getList(value).length,
                itemBuilder: (context, index) =>
                    ExtendedListTile(data: getList(value)[index]),
              ),
      ),
    );
  }

  BottomNavigationBar dafaultNavbar() {
    return BottomNavigationBar(
      currentIndex: _selectedIndex,
      onTap: onTap,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.account_balance_wallet_rounded),
          label: "All",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.home_repair_service_rounded),
          label: "Earnings",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.shopping_bag),
          label: "Expenses",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.bookmark),
          label: "Favorites",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.delete),
          label: "Trash",
        ),
      ],
    );
  }
}
