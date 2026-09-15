import 'package:flutter/material.dart';
import '../models/account_model.dart';
import '../models/notification_model.dart';
import '../models/transaction_model.dart';
import '../widgets/custom_drawer.dart';
import 'analytics_screen.dart';
import 'home_screen.dart';
import 'pay_bills_screen.dart';
import 'transaction_list_screen.dart';
import 'transfer_form_screen.dart';

class MainLayoutScreen extends StatefulWidget {
  final List<BankAccount> accounts;
  final List<TransactionModel> transactions;
  final List<BankNotification> notifications;
  final Function(String accountId, double amount, TransactionModel newTxn) onTransferCompleted;
  final bool isDarkMode;
  final ValueChanged<bool> onThemeChanged;

  const MainLayoutScreen({
    super.key,
    required this.accounts,
    required this.transactions,
    required this.notifications,
    required this.onTransferCompleted,
    required this.isDarkMode,
    required this.onThemeChanged,
  });

  @override
  State<MainLayoutScreen> createState() => _MainLayoutScreenState();
}

class _MainLayoutScreenState extends State<MainLayoutScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final List<Widget> screens = [
      HomeScreen(
        accounts: widget.accounts,
        transactions: widget.transactions,
        notifications: widget.notifications,
        onNavigateToTransfer: () {
          setState(() {
            _currentIndex = 2;
          });
        },
        onNavigateToTransactions: () {
          setState(() {
            _currentIndex = 1;
          });
        },
        onPaymentCompleted: widget.onTransferCompleted,
      ),
      TransactionListScreen(
        transactions: widget.transactions,
      ),
      TransferFormScreen(
        accounts: widget.accounts,
        onTransferCompleted: widget.onTransferCompleted,
      ),
    ];

    final List<String> titles = [
      'Personal Banking',
      'Transaction Activity',
      'Send Money Transfer',
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          titles[_currentIndex],
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        actions: [
          if (_currentIndex != 2)
            IconButton(
              icon: const Icon(Icons.send_rounded),
              tooltip: 'Send Money',
              onPressed: () {
                setState(() {
                  _currentIndex = 2;
                });
              },
            ),
        ],
      ),
      drawer: CustomDrawer(
        isDarkMode: widget.isDarkMode,
        onThemeChanged: widget.onThemeChanged,
        onNavigateToTransfer: () {
          setState(() {
            _currentIndex = 2;
          });
        },
        onNavigateToTransactions: () {
          setState(() {
            _currentIndex = 1;
          });
        },
        onNavigateToPayBills: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PayBillsScreen(
                accounts: widget.accounts,
                onPaymentCompleted: widget.onTransferCompleted,
              ),
            ),
          );
        },
        onNavigateToAnalytics: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AnalyticsScreen(transactions: widget.transactions),
            ),
          );
        },
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        selectedItemColor: Theme.of(context).colorScheme.primary,
        unselectedItemColor: Theme.of(context).hintColor,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_rounded),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt_long_rounded),
            label: 'Activity',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.send_rounded),
            label: 'Transfer',
          ),
        ],
      ),
    );
  }
}
