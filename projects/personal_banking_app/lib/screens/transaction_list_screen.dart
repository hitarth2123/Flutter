import 'package:flutter/material.dart';
import '../models/transaction_model.dart';
import '../widgets/transaction_tile.dart';
import 'transaction_detail_screen.dart';

class TransactionListScreen extends StatefulWidget {
  final List<TransactionModel> transactions;

  const TransactionListScreen({
    super.key,
    required this.transactions,
  });

  @override
  State<TransactionListScreen> createState() => _TransactionListScreenState();
}

class _TransactionListScreenState extends State<TransactionListScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedFilter = 'All';
  String _searchQuery = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<TransactionModel> get _filteredTransactions {
    return widget.transactions.where((txn) {
      final matchesFilter = _selectedFilter == 'All' ||
          (_selectedFilter == 'Credit' && txn.isCredit) ||
          (_selectedFilter == 'Debit' && !txn.isCredit);

      final query = _searchQuery.toLowerCase();
      final matchesSearch = txn.title.toLowerCase().contains(query) ||
          txn.category.toLowerCase().contains(query) ||
          txn.recipient.toLowerCase().contains(query);

      return matchesFilter && matchesSearch;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final filteredList = _filteredTransactions;

    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16.0),
          color: Theme.of(context).scaffoldBackgroundColor,
          child: Column(
            children: [
              TextField(
                controller: _searchController,
                onChanged: (val) {
                  setState(() {
                    _searchQuery = val;
                  });
                },
                decoration: InputDecoration(
                  hintText: 'Search transactions by name, category...',
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: _searchQuery.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: () {
                            _searchController.clear();
                            setState(() {
                              _searchQuery = '';
                            });
                          },
                        )
                      : null,
                  filled: true,
                  fillColor: Theme.of(context).cardColor,
                  contentPadding: const EdgeInsets.symmetric(vertical: 12),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),

              const SizedBox(height: 12),

              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                child: Row(
                  children: [
                    _buildFilterChip('All', Icons.density_medium),
                    const SizedBox(width: 8),
                    _buildFilterChip('Credit', Icons.arrow_downward, color: const Color(0xFF10B981)),
                    const SizedBox(width: 8),
                    _buildFilterChip('Debit', Icons.arrow_upward, color: const Color(0xFFEF4444)),
                  ],
                ),
              ),
            ],
          ),
        ),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Transactions (${filteredList.length})',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).hintColor,
                ),
              ),
              if (_searchQuery.isNotEmpty || _selectedFilter != 'All')
                TextButton(
                  onPressed: () {
                    _searchController.clear();
                    setState(() {
                      _searchQuery = '';
                      _selectedFilter = 'All';
                    });
                  },
                  child: const Text('Clear Filters', style: TextStyle(fontSize: 12)),
                ),
            ],
          ),
        ),

        Expanded(
          child: filteredList.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.search_off_rounded, size: 64, color: Theme.of(context).hintColor.withOpacity(0.5)),
                      const SizedBox(height: 12),
                      Text(
                        'No transactions found',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).hintColor,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Try adjusting your search query or filter criteria.',
                        style: TextStyle(fontSize: 12, color: Theme.of(context).hintColor),
                      ),
                    ],
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  physics: const BouncingScrollPhysics(),
                  itemCount: filteredList.length,
                  itemBuilder: (context, index) {
                    final txn = filteredList[index];
                    return TransactionTile(
                      transaction: txn,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => TransactionDetailScreen(transaction: txn),
                          ),
                        );
                      },
                    );
                  },
                ),
        ),
      ],
    );
  }

  Widget _buildFilterChip(String label, IconData icon, {Color? color}) {
    final isSelected = _selectedFilter == label;
    final activeColor = color ?? Theme.of(context).colorScheme.primary;

    return ChoiceChip(
      avatar: Icon(
        icon,
        size: 16,
        color: isSelected ? Colors.white : activeColor,
      ),
      label: Text(label),
      selected: isSelected,
      onSelected: (selected) {
        if (selected) {
          setState(() {
            _selectedFilter = label;
          });
        }
      },
      selectedColor: activeColor,
      labelStyle: TextStyle(
        color: isSelected ? Colors.white : null,
        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        fontSize: 12,
      ),
    );
  }
}
