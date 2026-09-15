import 'package:flutter/material.dart';
import '../models/account_model.dart';
import '../models/transaction_model.dart';

class PayBillsScreen extends StatefulWidget {
  final List<BankAccount> accounts;
  final Function(String accountId, double amount, TransactionModel newTxn) onPaymentCompleted;

  const PayBillsScreen({
    super.key,
    required this.accounts,
    required this.onPaymentCompleted,
  });

  @override
  State<PayBillsScreen> createState() => _PayBillsScreenState();
}

class _PayBillsScreenState extends State<PayBillsScreen> {
  final _formKey = GlobalKey<FormState>();
  late BankAccount _selectedAccount;
  String _selectedBiller = 'City Power & Electricity';
  final TextEditingController _consumerIdController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();

  final List<Map<String, String>> _billers = [
    {'name': 'City Power & Electricity', 'category': 'Bills', 'icon': 'electric_bolt'},
    {'name': 'Metropolitan Water Board', 'category': 'Bills', 'icon': 'water_drop'},
    {'name': 'FiberNet Broadband', 'category': 'Bills', 'icon': 'wifi'},
    {'name': 'Telecom Mobile Recharge', 'category': 'Bills', 'icon': 'phone_android'},
    {'name': 'National Credit Card', 'category': 'Bills', 'icon': 'credit_card'},
  ];

  @override
  void initState() {
    super.initState();
    _selectedAccount = widget.accounts.first;
  }

  @override
  void dispose() {
    _consumerIdController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  void _processBillPayment() {
    if (!_formKey.currentState!.validate()) return;

    final double amount = double.parse(_amountController.text.trim());

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Row(
          children: [
            Icon(Icons.payment, color: Color(0xFF10B981)),
            SizedBox(width: 8),
            Text('Confirm Bill Payment'),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Biller: $_selectedBiller', style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            Text('Consumer ID: ${_consumerIdController.text.trim()}'),
            const SizedBox(height: 4),
            Text('From Acc #: ${_selectedAccount.accountNumber}'),
            const SizedBox(height: 4),
            Text(
              'Amount: ₹${amount.toStringAsFixed(2)}',
              style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF10B981)),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(ctx);

              final newTxn = TransactionModel(
                id: 'BILL-${DateTime.now().millisecondsSinceEpoch.toString().substring(7)}',
                title: 'Paid $_selectedBiller',
                category: 'Bills',
                amount: amount,
                type: TransactionType.debit,
                date: DateTime.now(),
                recipient: _selectedBiller,
                accountNumber: 'Acc # ${_consumerIdController.text.trim()}',
                note: 'Utility bill payment for Consumer #${_consumerIdController.text.trim()}',
                status: 'Completed',
              );

              widget.onPaymentCompleted(_selectedAccount.id, amount, newTxn);

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Paid ₹${amount.toStringAsFixed(2)} to $_selectedBiller successfully!'),
                  backgroundColor: const Color(0xFF10B981),
                ),
              );

              Navigator.pop(context);
            },
            child: const Text('Confirm & Pay'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pay Utility Bills'),
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
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Select Payment Account Number',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                      ),
                      const SizedBox(height: 10),
                      DropdownButtonFormField<BankAccount>(
                        isExpanded: true,
                        initialValue: _selectedAccount,
                        decoration: InputDecoration(
                          labelText: 'Account Number',
                          prefixIcon: const Icon(Icons.tag),
                          filled: true,
                          fillColor: Theme.of(context).scaffoldBackgroundColor,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          ),
                        ),
                        items: widget.accounts.map((acc) {
                          return DropdownMenuItem(
                            value: acc,
                            child: Text(
                              'Acc #${acc.accountNumber} (${acc.accountName})',
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(fontSize: 13),
                            ),
                          );
                        }).toList(),
                        onChanged: (val) {
                          if (val != null) {
                            setState(() {
                              _selectedAccount = val;
                            });
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 16),

              Card(
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Select Service Provider',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                      ),
                      const SizedBox(height: 10),
                      DropdownButtonFormField<String>(
                        isExpanded: true,
                        initialValue: _selectedBiller,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.receipt_long),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                        ),
                        items: _billers.map((biller) {
                          return DropdownMenuItem(
                            value: biller['name'],
                            child: Text(
                              biller['name']!,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(fontSize: 13),
                            ),
                          );
                        }).toList(),
                        onChanged: (val) {
                          if (val != null) {
                            setState(() {
                              _selectedBiller = val;
                            });
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 16),

              Card(
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Billing Details',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                      ),
                      const SizedBox(height: 14),

                      TextFormField(
                        controller: _consumerIdController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: 'Consumer / Meter ID Number',
                          hintText: 'e.g. 88392019',
                          prefixIcon: const Icon(Icons.numbers),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Please enter consumer ID';
                          }
                          return null;
                        },
                      ),

                      const SizedBox(height: 14),

                      TextFormField(
                        controller: _amountController,
                        keyboardType: const TextInputType.numberWithOptions(decimal: true),
                        decoration: InputDecoration(
                          labelText: 'Bill Amount (₹)',
                          hintText: '0.00',
                          prefixIcon: const Icon(Icons.currency_rupee),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Please enter bill amount';
                          }
                          final parsed = double.tryParse(value.trim());
                          if (parsed == null || parsed <= 0) {
                            return 'Please enter a valid positive amount';
                          }
                          if (parsed > _selectedAccount.balance) {
                            return 'Insufficient balance in Acc #${_selectedAccount.accountNumber}';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 24),

              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton.icon(
                  onPressed: _processBillPayment,
                  icon: const Icon(Icons.payment_rounded),
                  label: const Text('Pay Bill Now', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
