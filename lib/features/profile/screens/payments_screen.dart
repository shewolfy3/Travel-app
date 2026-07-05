import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/theme/app_theme.dart';

class PaymentsScreen extends StatefulWidget {
  const PaymentsScreen({super.key});

  @override
  State<PaymentsScreen> createState() => _PaymentsScreenState();
}

class _PaymentsScreenState extends State<PaymentsScreen> {
  int _selectedCard = 0;

  final List<Map<String, dynamic>> _cards = [
    {
      'type': 'Visa',
      'number': '**** **** **** 4242',
      'holder': 'John Doe',
      'expiry': '12/27',
      'color': [Color(0xFF007BFF), Color(0xFF0056CC)],
    },
    {
      'type': 'Mastercard',
      'number': '**** **** **** 8888',
      'holder': 'John Doe',
      'expiry': '08/26',
      'color': [Color(0xFFFF6B35), Color(0xFFCC4400)],
    },
  ];

  final List<Map<String, dynamic>> _history = [
    {
      'title': 'Flight to Dubai',
      'date': 'July 1, 2026',
      'amount': '\$199',
      'status': 'Paid',
      'icon': Icons.airplanemode_active,
      'color': Color(0xFF007BFF),
    },
    {
      'title': 'Burj Al Arab Hotel',
      'date': 'June 25, 2026',
      'amount': '\$500',
      'status': 'Paid',
      'icon': Icons.hotel,
      'color': Color(0xFF00C896),
    },
    {
      'title': 'Desert Safari',
      'date': 'June 15, 2026',
      'amount': '\$89',
      'status': 'Paid',
      'icon': Icons.terrain,
      'color': Color(0xFFFFB300),
    },
    {
      'title': 'UAE Visa',
      'date': 'June 10, 2026',
      'amount': '\$90',
      'status': 'Refunded',
      'icon': Icons.description,
      'color': Color(0xFF9C27B0),
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        ),
        title: const Text('Payments'),
        elevation: 0,
        backgroundColor: AppTheme.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Saved Cards',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.dark)),
            const SizedBox(height: 12),
            SizedBox(
              height: 180,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _cards.length + 1,
                itemBuilder: (context, index) {
                  if (index == _cards.length) {
                    return GestureDetector(
                      onTap: () => Get.snackbar(
                          'Coming Soon', 'Add card not yet implemented'),
                      child: Container(
                        width: 280,
                        margin: const EdgeInsets.only(right: 16),
                        decoration: BoxDecoration(
                          color: AppTheme.white,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                              color: AppTheme.lightGrey, width: 2),
                        ),
                        child: const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.add_circle_outline,
                                size: 36, color: AppTheme.grey),
                            SizedBox(height: 8),
                            Text('Add New Card',
                                style: TextStyle(
                                    fontSize: 14, color: AppTheme.grey)),
                          ],
                        ),
                      ),
                    );
                  }
                  final card = _cards[index];
                  final isSelected = _selectedCard == index;
                  return GestureDetector(
                    onTap: () => setState(() => _selectedCard = index),
                    child: Container(
                      width: 280,
                      margin: const EdgeInsets.only(right: 16),
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: card['color'] as List<Color>,
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(20),
                        border: isSelected
                            ? Border.all(color: Colors.white, width: 3)
                            : null,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                            children: [
                              Text(card['type'],
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white)),
                              if (isSelected)
                                const Icon(Icons.check_circle,
                                    color: Colors.white, size: 22),
                            ],
                          ),
                          Text(card['number'],
                              style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.white70,
                                  letterSpacing: 2)),
                          Row(
                            mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                children: [
                                  const Text('Card Holder',
                                      style: TextStyle(
                                          fontSize: 10,
                                          color: Colors.white60)),
                                  Text(card['holder'],
                                      style: const TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white)),
                                ],
                              ),
                              Column(
                                crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                children: [
                                  const Text('Expires',
                                      style: TextStyle(
                                          fontSize: 10,
                                          color: Colors.white60)),
                                  Text(card['expiry'],
                                      style: const TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white)),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 24),
            const Text('Payment History',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.dark)),
            const SizedBox(height: 12),
            ..._history.map((tx) => Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppTheme.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 3))
                    ],
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: (tx['color'] as Color).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(tx['icon'] as IconData,
                            color: tx['color'] as Color, size: 22),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(tx['title'],
                                style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: AppTheme.dark)),
                            const SizedBox(height: 4),
                            Text(tx['date'],
                                style: const TextStyle(
                                    fontSize: 12, color: AppTheme.grey)),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(tx['amount'],
                              style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: AppTheme.dark)),
                          const SizedBox(height: 4),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 2),
                            decoration: BoxDecoration(
                              color: tx['status'] == 'Paid'
                                  ? Colors.green.withOpacity(0.1)
                                  : Colors.orange.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(tx['status'],
                                style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.bold,
                                    color: tx['status'] == 'Paid'
                                        ? Colors.green
                                        : Colors.orange)),
                          ),
                        ],
                      ),
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }
}