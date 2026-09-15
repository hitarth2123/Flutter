import 'package:flutter/material.dart';

class CustomDrawer extends StatefulWidget {
  final bool isDarkMode;
  final ValueChanged<bool> onThemeChanged;
  final VoidCallback onNavigateToTransfer;
  final VoidCallback onNavigateToTransactions;
  final VoidCallback? onNavigateToPayBills;
  final VoidCallback? onNavigateToAnalytics;

  const CustomDrawer({
    super.key,
    required this.isDarkMode,
    required this.onThemeChanged,
    required this.onNavigateToTransfer,
    required this.onNavigateToTransactions,
    this.onNavigateToPayBills,
    this.onNavigateToAnalytics,
  });

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  bool _smsAlertsEnabled = true;
  bool _biometricLoginEnabled = true;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF0F172A), Color(0xFF4F46E5)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.white,
              child: ClipOval(
                child: Image.network(
                  'https://images.unsplash.com/photo-1534528741775-53994a69daeb?auto=format&fit=crop&q=80&w=200',
                  fit: BoxFit.cover,
                  width: 72,
                  height: 72,
                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(Icons.person, size: 40, color: Color(0xFF4F46E5));
                  },
                ),
              ),
            ),
            accountName: const Text(
              'Alex Morgan',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            accountEmail: const Text('alex.morgan@fintech.bank'),
          ),

          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                ListTile(
                  leading: const Icon(Icons.dashboard_outlined),
                  title: const Text('Dashboard Summary'),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.receipt_long_outlined),
                  title: const Text('Transaction History'),
                  onTap: () {
                    Navigator.pop(context);
                    widget.onNavigateToTransactions();
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.send_outlined),
                  title: const Text('Transfer Funds'),
                  onTap: () {
                    Navigator.pop(context);
                    widget.onNavigateToTransfer();
                  },
                ),
                if (widget.onNavigateToPayBills != null)
                  ListTile(
                    leading: const Icon(Icons.payment_outlined),
                    title: const Text('Pay Utility Bills'),
                    onTap: () {
                      Navigator.pop(context);
                      widget.onNavigateToPayBills!();
                    },
                  ),
                if (widget.onNavigateToAnalytics != null)
                  ListTile(
                    leading: const Icon(Icons.pie_chart_outline),
                    title: const Text('Spending Analytics'),
                    onTap: () {
                      Navigator.pop(context);
                      widget.onNavigateToAnalytics!();
                    },
                  ),

                const Divider(),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Text(
                    'Preferences & Security',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),

                SwitchListTile(
                  secondary: const Icon(Icons.dark_mode_outlined),
                  title: const Text('Dark Mode'),
                  subtitle: const Text('Switch visual theme'),
                  value: widget.isDarkMode,
                  onChanged: (val) {
                    widget.onThemeChanged(val);
                  },
                ),

                SwitchListTile(
                  secondary: const Icon(Icons.notifications_active_outlined),
                  title: const Text('Instant SMS Alerts'),
                  subtitle: Text(_smsAlertsEnabled ? 'SMS notifications active' : 'SMS notifications disabled'),
                  value: _smsAlertsEnabled,
                  onChanged: (val) {
                    setState(() {
                      _smsAlertsEnabled = val;
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Instant SMS Alerts ${val ? "enabled" : "disabled"}.'),
                        duration: const Duration(seconds: 2),
                      ),
                    );
                  },
                ),

                SwitchListTile(
                  secondary: const Icon(Icons.fingerprint_outlined),
                  title: const Text('Biometric Security'),
                  subtitle: Text(_biometricLoginEnabled ? 'FaceID / TouchID enabled' : 'Biometric disabled'),
                  value: _biometricLoginEnabled,
                  onChanged: (val) {
                    setState(() {
                      _biometricLoginEnabled = val;
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Biometric authentication ${val ? "enabled" : "disabled"}.'),
                        duration: const Duration(seconds: 2),
                      ),
                    );
                  },
                ),

                const Divider(),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Card(
                    color: Theme.of(context).colorScheme.primary.withOpacity(0.08),
                    elevation: 0,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Row(
                            children: [
                              Icon(Icons.shield_outlined, size: 18, color: Color(0xFF10B981)),
                              SizedBox(width: 8),
                              Text(
                                'Daily Transfer Limit',
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                              ),
                            ],
                          ),
                          const SizedBox(height: 6),
                          const LinearProgressIndicator(
                            value: 0.35,
                            backgroundColor: Colors.white,
                            color: Color(0xFF10B981),
                          ),
                          const SizedBox(height: 6),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '₹35,000 used',
                                style: TextStyle(fontSize: 11, color: Theme.of(context).hintColor),
                              ),
                              Text(
                                '₹1,00,000 max',
                                style: TextStyle(fontSize: 11, color: Theme.of(context).hintColor),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
        ],
      ),
    );
  }
}
