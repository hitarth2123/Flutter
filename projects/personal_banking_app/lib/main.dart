import 'package:flutter/material.dart';
import 'data/dummy_data.dart';
import 'models/account_model.dart';
import 'models/notification_model.dart';
import 'models/transaction_model.dart';
import 'screens/main_layout_screen.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(const PersonalBankingApp());
}

class PersonalBankingApp extends StatefulWidget {
  const PersonalBankingApp({super.key});

  @override
  State<PersonalBankingApp> createState() => _PersonalBankingAppState();
}

class _PersonalBankingAppState extends State<PersonalBankingApp> {
  final List<BankAccount> _accounts = List.from(DummyData.initialAccounts);
  final List<TransactionModel> _transactions = List.from(DummyData.initialTransactions);
  final List<BankNotification> _notifications = [
    BankNotification(
      id: 'N-101',
      title: 'Salary Credited',
      description: 'TechCorp credited ₹1,75,000.00 to your Primary Checking Account.',
      time: '4 hours ago',
      icon: Icons.account_balance_wallet,
      color: const Color(0xFF10B981),
    ),
    BankNotification(
      id: 'N-102',
      title: 'Security Alert',
      description: 'Successful login detected from macOS browser (macOS 15.1).',
      time: '1 day ago',
      icon: Icons.security,
      color: const Color(0xFFF59E0B),
    ),
    BankNotification(
      id: 'N-103',
      title: 'Bill Payment Completed',
      description: 'City Power Utility bill payment of ₹4,250.00 was processed.',
      time: '5 days ago',
      icon: Icons.receipt_long,
      color: const Color(0xFF4F46E5),
    ),
  ];

  bool _isDarkMode = false;

  void _handleTransferCompleted(String accountId, double totalAmount, TransactionModel newTxn) {
    setState(() {
      final accountIndex = _accounts.indexWhere((acc) => acc.id == accountId);
      if (accountIndex != -1) {
        _accounts[accountIndex].balance -= totalAmount;
      }

      _transactions.insert(0, newTxn);

      _notifications.insert(
        0,
        BankNotification(
          id: 'N-${DateTime.now().millisecondsSinceEpoch}',
          title: 'Payment Sent Successfully',
          description: '${newTxn.title} (${newTxn.formattedAmount}) processed.',
          time: 'Just now',
          icon: Icons.check_circle_outline,
          color: const Color(0xFF10B981),
          isRead: false,
        ),
      );
    });
  }

  void _toggleTheme(bool isDark) {
    setState(() {
      _isDarkMode = isDark;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Banking App',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: _isDarkMode ? ThemeMode.dark : ThemeMode.light,
      home: MainLayoutScreen(
        accounts: _accounts,
        transactions: _transactions,
        notifications: _notifications,
        onTransferCompleted: _handleTransferCompleted,
        isDarkMode: _isDarkMode,
        onThemeChanged: _toggleTheme,
      ),
    );
  }
}
