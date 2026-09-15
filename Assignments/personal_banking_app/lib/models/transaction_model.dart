enum TransactionType { credit, debit }

class TransactionModel {
  final String id;
  final String title;
  final String category;
  final double amount;
  final TransactionType type;
  final DateTime date;
  final String status;
  final String recipient;
  final String accountNumber;
  final String note;
  final String transferSpeed;

  TransactionModel({
    required this.id,
    required this.title,
    required this.category,
    required this.amount,
    required this.type,
    required this.date,
    this.status = 'Completed',
    required this.recipient,
    required this.accountNumber,
    this.note = '',
    this.transferSpeed = 'Standard',
  });

  bool get isCredit => type == TransactionType.credit;

  String get formattedAmount {
    final prefix = isCredit ? '+' : '-';
    return '$prefix₹${amount.toStringAsFixed(2)}';
  }

  String get formattedDate {
    return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
  }
}
