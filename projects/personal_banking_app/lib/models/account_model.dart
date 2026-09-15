class BankAccount {
  final String id;
  final String accountName;
  final String accountNumber;
  double balance;
  final String currency;
  final String cardType;
  final String cardHolder;
  final String expiry;
  final bool isPrimary;

  BankAccount({
    required this.id,
    required this.accountName,
    required this.accountNumber,
    required this.balance,
    this.currency = '₹',
    required this.cardType,
    required this.cardHolder,
    required this.expiry,
    this.isPrimary = false,
  });

  String get formattedBalance => '$currency${balance.toStringAsFixed(2)}';
}
