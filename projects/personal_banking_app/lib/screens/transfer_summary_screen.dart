import 'package:flutter/material.dart';
import '../models/account_model.dart';
import '../models/transaction_model.dart';

class TransferSummaryScreen extends StatelessWidget {
  final TransactionModel transaction;
  final BankAccount sourceAccount;

  const TransferSummaryScreen({
    super.key,
    required this.transaction,
    required this.sourceAccount,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transfer Receipt'),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            const SizedBox(height: 20),

            Container(
              padding: const EdgeInsets.all(24),
              decoration: const BoxDecoration(
                color: Color(0xFF10B981),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.check_rounded,
                color: Colors.white,
                size: 54,
              ),
            ),

            const SizedBox(height: 16),

            const Text(
              'Transfer Successful!',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 6),

            Text(
              'Your money is on its way to ${transaction.recipient}.',
              style: TextStyle(fontSize: 14, color: Theme.of(context).hintColor),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 24),

            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Text(
                      'TOTAL TRANSFERRED',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).hintColor,
                        letterSpacing: 1,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      '₹${transaction.amount.toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF10B981),
                      ),
                    ),
                    const Divider(height: 30),

                    _summaryItem(context, 'Transaction Ref:', transaction.id),
                    _summaryItem(context, 'Date & Time:', transaction.formattedDate),
                    _summaryItem(context, 'From Account:', '${sourceAccount.accountName} (${sourceAccount.accountNumber})'),
                    _summaryItem(context, 'Recipient:', transaction.recipient),
                    _summaryItem(context, 'Recipient Account:', transaction.accountNumber),
                    _summaryItem(context, 'Speed Mode:', transaction.transferSpeed),
                    if (transaction.note.isNotEmpty) _summaryItem(context, 'Note:', transaction.note),

                    const Divider(height: 30),

                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary.withOpacity(0.08),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Updated Account Balance:',
                            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
                          ),
                          Text(
                            sourceAccount.formattedBalance,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.popUntil(context, (route) => route.isFirst);
                },
                child: const Text('Back to Home Dashboard'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _summaryItem(BuildContext context, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(fontSize: 12, color: Theme.of(context).hintColor),
          ),
          Flexible(
            child: Text(
              value,
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
              textAlign: TextAlign.end,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
