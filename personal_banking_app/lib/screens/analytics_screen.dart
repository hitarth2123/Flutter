import 'package:flutter/material.dart';
import '../models/transaction_model.dart';

class AnalyticsScreen extends StatelessWidget {
  final List<TransactionModel> transactions;

  const AnalyticsScreen({
    super.key,
    required this.transactions,
  });

  @override
  Widget build(BuildContext context) {
    double totalIncome = 0;
    double totalExpenses = 0;
    Map<String, double> categoryMap = {};

    for (var txn in transactions) {
      if (txn.isCredit) {
        totalIncome += txn.amount;
      } else {
        totalExpenses += txn.amount;
        categoryMap[txn.category] = (categoryMap[txn.category] ?? 0) + txn.amount;
      }
    }

    final double netSavings = totalIncome - totalExpenses;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Spending Analytics'),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Card(
                    color: const Color(0xFF10B981).withOpacity(0.12),
                    elevation: 0,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Row(
                            children: [
                              Icon(Icons.arrow_downward, color: Color(0xFF10B981), size: 18),
                              SizedBox(width: 6),
                              Text('Total Income', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(
                            '₹${totalIncome.toStringAsFixed(2)}',
                            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF10B981)),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Card(
                    color: const Color(0xFFEF4444).withOpacity(0.12),
                    elevation: 0,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Row(
                            children: [
                              Icon(Icons.arrow_upward, color: Color(0xFFEF4444), size: 18),
                              SizedBox(width: 6),
                              Text('Total Expenses', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(
                            '₹${totalExpenses.toStringAsFixed(2)}',
                            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFFEF4444)),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            Card(
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'NET MONTHLY SAVINGS',
                          style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Theme.of(context).hintColor),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '₹${netSavings.toStringAsFixed(2)}',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: netSavings >= 0 ? const Color(0xFF10B981) : const Color(0xFFEF4444),
                          ),
                        ),
                      ],
                    ),
                    Icon(
                      netSavings >= 0 ? Icons.savings_outlined : Icons.warning_amber_rounded,
                      color: netSavings >= 0 ? const Color(0xFF10B981) : const Color(0xFFEF4444),
                      size: 36,
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              'Expenses by Category',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 12),

            if (categoryMap.isEmpty)
              const Center(child: Text('No expense transactions recorded yet.'))
            else
              ...categoryMap.entries.map((entry) {
                final double percent = totalExpenses > 0 ? (entry.value / totalExpenses) : 0.0;
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 6),
                  elevation: 1,
                  child: Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(entry.key, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                            Text(
                              '₹${entry.value.toStringAsFixed(2)} (${(percent * 100).toStringAsFixed(1)}%)',
                              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        LinearProgressIndicator(
                          value: percent,
                          backgroundColor: Colors.grey.withOpacity(0.15),
                          color: Theme.of(context).colorScheme.primary,
                          minHeight: 8,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ],
                    ),
                  ),
                );
              }),
          ],
        ),
      ),
    );
  }
}
