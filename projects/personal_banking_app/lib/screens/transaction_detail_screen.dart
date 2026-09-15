import 'package:flutter/material.dart';
import '../models/transaction_model.dart';

class TransactionDetailScreen extends StatelessWidget {
  final TransactionModel transaction;

  const TransactionDetailScreen({
    super.key,
    required this.transaction,
  });

  @override
  Widget build(BuildContext context) {
    final isCredit = transaction.isCredit;
    final themeColor = isCredit ? const Color(0xFF10B981) : const Color(0xFFEF4444);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Transaction Details'),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: themeColor.withOpacity(0.12),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        isCredit ? Icons.arrow_downward_rounded : Icons.arrow_upward_rounded,
                        color: themeColor,
                        size: 36,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      transaction.title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      transaction.formattedAmount,
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: themeColor,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                      decoration: BoxDecoration(
                        color: const Color(0xFF10B981).withOpacity(0.15),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.check_circle, color: Color(0xFF10B981), size: 14),
                          const SizedBox(width: 4),
                          Text(
                            transaction.status.toUpperCase(),
                            style: const TextStyle(
                              color: Color(0xFF10B981),
                              fontWeight: FontWeight.bold,
                              fontSize: 11,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            Card(
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    _buildDetailRow(
                      context,
                      label: 'Reference ID',
                      value: transaction.id,
                      trailingAction: IconButton(
                        icon: const Icon(Icons.copy, size: 18),
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Copied ID ${transaction.id} to clipboard!'),
                            ),
                          );
                        },
                      ),
                    ),
                    const Divider(),
                    _buildDetailRow(context, label: 'Category', value: transaction.category),
                    const Divider(),
                    _buildDetailRow(
                      context,
                      label: isCredit ? 'Sender' : 'Recipient',
                      value: transaction.recipient,
                    ),
                    const Divider(),
                    _buildDetailRow(context, label: 'Account Number', value: transaction.accountNumber),
                    const Divider(),
                    _buildDetailRow(context, label: 'Date', value: transaction.formattedDate),
                    const Divider(),
                    _buildDetailRow(context, label: 'Transfer Speed', value: transaction.transferSpeed),
                    if (transaction.note.isNotEmpty) ...[
                      const Divider(),
                      _buildDetailRow(context, label: 'Note / Description', value: transaction.note),
                    ],
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton.icon(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Repeating transfer of ${transaction.formattedAmount} to ${transaction.recipient}'),
                    ),
                  );
                },
                icon: const Icon(Icons.replay_rounded),
                label: const Text('Repeat Transfer'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(
    BuildContext context, {
    required String label,
    required String value,
    Widget? trailingAction,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 13,
              color: Theme.of(context).hintColor,
            ),
          ),
          Row(
            children: [
              Text(
                value,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (trailingAction != null) trailingAction,
            ],
          ),
        ],
      ),
    );
  }
}
