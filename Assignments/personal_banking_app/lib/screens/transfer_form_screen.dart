import 'package:flutter/material.dart';
import '../models/account_model.dart';
import '../models/transaction_model.dart';
import 'transfer_summary_screen.dart';

class TransferFormScreen extends StatefulWidget {
  final List<BankAccount> accounts;
  final Function(String accountId, double amount, TransactionModel newTxn) onTransferCompleted;

  const TransferFormScreen({
    super.key,
    required this.accounts,
    required this.onTransferCompleted,
  });

  @override
  State<TransferFormScreen> createState() => _TransferFormScreenState();
}

class _TransferFormScreenState extends State<TransferFormScreen> {
  final _formKey = GlobalKey<FormState>();

  late BankAccount _selectedAccount;
  final TextEditingController _recipientNameController = TextEditingController();
  final TextEditingController _recipientAccountController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();

  String _transferCategory = 'Transfer';
  String _transferSpeed = 'Standard';
  bool _saveBeneficiary = false;
  bool _agreeTerms = false;

  final List<String> _categories = ['Transfer', 'Bills', 'Shopping', 'Dining', 'Others'];

  @override
  void initState() {
    super.initState();
    _selectedAccount = widget.accounts.first;
  }

  @override
  void dispose() {
    _recipientNameController.dispose();
    _recipientAccountController.dispose();
    _amountController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  double get _transferFee => _transferSpeed == 'Instant' ? 150.00 : 0.00;

  void _submitForm() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (!_agreeTerms) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please accept the transfer terms and conditions.'),
          backgroundColor: Colors.redAccent,
        ),
      );
      return;
    }

    final double amount = double.parse(_amountController.text.trim());
    final double totalDeduction = amount + _transferFee;

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Row(
          children: [
            Icon(Icons.verified_user_outlined, color: Color(0xFF4F46E5)),
            SizedBox(width: 8),
            Text('Confirm Transfer'),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Please review your transfer details carefully:',
              style: TextStyle(fontSize: 13),
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary.withOpacity(0.08),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  _dialogRow('Recipient:', _recipientNameController.text.trim()),
                  _dialogRow('Recipient Acc #:', _recipientAccountController.text.trim()),
                  _dialogRow('From Acc Number:', _selectedAccount.accountNumber),
                  _dialogRow('Account Type:', _selectedAccount.accountName),
                  _dialogRow('Transfer Amount:', '₹${amount.toStringAsFixed(2)}'),
                  _dialogRow('Service Fee:', '₹${_transferFee.toStringAsFixed(2)}'),
                  const Divider(),
                  _dialogRow(
                    'Total Deducted:',
                    '₹${totalDeduction.toStringAsFixed(2)}',
                    isBold: true,
                  ),
                ],
              ),
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
                id: 'TXN-${DateTime.now().millisecondsSinceEpoch.toString().substring(7)}',
                title: 'Transfer to ${_recipientNameController.text.trim()}',
                category: _transferCategory,
                amount: amount,
                type: TransactionType.debit,
                date: DateTime.now(),
                recipient: _recipientNameController.text.trim(),
                accountNumber: 'Acc # ${_recipientAccountController.text.trim()}',
                note: _noteController.text.trim(),
                status: 'Completed',
                transferSpeed: _transferSpeed,
              );

              widget.onTransferCompleted(_selectedAccount.id, totalDeduction, newTxn);

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TransferSummaryScreen(
                    transaction: newTxn,
                    sourceAccount: _selectedAccount,
                  ),
                ),
              );
            },
            child: const Text('Confirm & Pay'),
          ),
        ],
      ),
    );
  }

  Widget _dialogRow(String label, String value, {bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
          Text(
            value,
            style: TextStyle(
              fontSize: 12,
              fontWeight: isBold ? FontWeight.bold : FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Send Money Transfer'),
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
                      Row(
                        children: [
                          Icon(Icons.account_balance_outlined, color: Theme.of(context).colorScheme.primary),
                          const SizedBox(width: 8),
                          const Text(
                            'Select Source Account Number',
                            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      DropdownButtonFormField<BankAccount>(
                        isExpanded: true,
                        initialValue: _selectedAccount,
                        decoration: InputDecoration(
                          labelText: 'Source Bank Account ID / Number',
                          prefixIcon: const Icon(Icons.tag),
                          filled: true,
                          fillColor: Theme.of(context).scaffoldBackgroundColor,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                        ),
                        items: widget.accounts.map((acc) {
                          return DropdownMenuItem<BankAccount>(
                            value: acc,
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    'Acc #${acc.accountNumber} (${acc.accountName})',
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(fontSize: 13),
                                  ),
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  acc.formattedBalance,
                                  style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF10B981), fontSize: 13),
                                ),
                              ],
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
                      Row(
                        children: [
                          Icon(Icons.person_outline, color: Theme.of(context).colorScheme.primary),
                          const SizedBox(width: 8),
                          const Text(
                            'Recipient Information',
                            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),

                      TextFormField(
                        controller: _recipientNameController,
                        decoration: InputDecoration(
                          labelText: 'Recipient Full Name',
                          hintText: 'e.g. Sarah Jenkins',
                          prefixIcon: const Icon(Icons.badge_outlined),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Please enter recipient name';
                          }
                          return null;
                        },
                      ),

                      const SizedBox(height: 14),

                      TextFormField(
                        controller: _recipientAccountController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: 'Recipient Account Number',
                          hintText: 'e.g. 9812440192',
                          prefixIcon: const Icon(Icons.numbers_outlined),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Please enter account number';
                          }
                          if (value.trim().length < 8) {
                            return 'Account number must be at least 8 digits';
                          }
                          return null;
                        },
                      ),

                      const SizedBox(height: 14),

                      DropdownButtonFormField<String>(
                        isExpanded: true,
                        initialValue: _transferCategory,
                        decoration: InputDecoration(
                          labelText: 'Transfer Category',
                          prefixIcon: const Icon(Icons.category_outlined),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                        ),
                        items: _categories.map((cat) {
                          return DropdownMenuItem(value: cat, child: Text(cat));
                        }).toList(),
                        onChanged: (val) {
                          if (val != null) {
                            setState(() {
                              _transferCategory = val;
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
                      Row(
                        children: [
                          Icon(Icons.currency_rupee, color: Theme.of(context).colorScheme.primary),
                          const SizedBox(width: 8),
                          const Text(
                            'Amount & Notes',
                            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),

                      TextFormField(
                        controller: _amountController,
                        keyboardType: const TextInputType.numberWithOptions(decimal: true),
                        decoration: InputDecoration(
                          labelText: 'Transfer Amount (₹)',
                          hintText: '0.00',
                          prefixIcon: const Icon(Icons.currency_rupee),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Please enter transfer amount';
                          }
                          final parsed = double.tryParse(value.trim());
                          if (parsed == null || parsed <= 0) {
                            return 'Please enter a valid positive amount';
                          }
                          if (parsed + _transferFee > _selectedAccount.balance) {
                            return 'Insufficient funds in Acc #${_selectedAccount.accountNumber}';
                          }
                          return null;
                        },
                      ),

                      const SizedBox(height: 14),

                      TextFormField(
                        controller: _noteController,
                        decoration: InputDecoration(
                          labelText: 'Note / Purpose (Optional)',
                          hintText: 'e.g. Dinner split, Rent, Birthday gift',
                          prefixIcon: const Icon(Icons.note_alt_outlined),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                        ),
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
                      Row(
                        children: [
                          Icon(Icons.speed_outlined, color: Theme.of(context).colorScheme.primary),
                          const SizedBox(width: 8),
                          const Text(
                            'Transfer Speed Option',
                            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      ListTile(
                        leading: Radio<String>(
                          value: 'Standard',
                          groupValue: _transferSpeed,
                          onChanged: (val) {
                            if (val != null) {
                              setState(() {
                                _transferSpeed = val;
                              });
                            }
                          },
                        ),
                        title: const Text('Standard Delivery (Free)'),
                        subtitle: const Text('Takes 1-2 business days'),
                        onTap: () {
                          setState(() {
                            _transferSpeed = 'Standard';
                          });
                        },
                      ),
                      ListTile(
                        leading: Radio<String>(
                          value: 'Instant',
                          groupValue: _transferSpeed,
                          onChanged: (val) {
                            if (val != null) {
                              setState(() {
                                _transferSpeed = val;
                              });
                            }
                          },
                        ),
                        title: const Text('Instant Transfer (+₹150 fee)'),
                        subtitle: const Text('Processed immediately 24/7'),
                        onTap: () {
                          setState(() {
                            _transferSpeed = 'Instant';
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 16),

              Card(
                elevation: 2,
                child: Column(
                  children: [
                    CheckboxListTile(
                      title: const Text('Save recipient as beneficiary'),
                      subtitle: const Text('Quick transfer for future transactions'),
                      value: _saveBeneficiary,
                      onChanged: (val) {
                        setState(() {
                          _saveBeneficiary = val ?? false;
                        });
                      },
                    ),
                    const Divider(height: 1),
                    CheckboxListTile(
                      title: const Text('I agree to the transfer terms & conditions'),
                      subtitle: const Text('I confirm recipient details are correct'),
                      value: _agreeTerms,
                      onChanged: (val) {
                        setState(() {
                          _agreeTerms = val ?? false;
                        });
                      },
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton.icon(
                  onPressed: _submitForm,
                  icon: const Icon(Icons.send_rounded),
                  label: const Text(
                    'Continue to Transfer',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),

              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
