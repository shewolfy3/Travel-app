import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/theme/app_theme.dart';
import '../../../controllers/booking_controller.dart';

class WalletScreen extends StatelessWidget {
  WalletScreen({super.key});

  final BookingController controller = Get.find<BookingController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        ),
        title: const Text('Wallet'),
        elevation: 0,
        backgroundColor: AppTheme.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Balance card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(28),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF007BFF), Color(0xFF0056CC)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(24),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Total Balance',
                      style: TextStyle(fontSize: 14, color: Colors.white70)),
                  const SizedBox(height: 8),
                  Obx(() => Text(
                        '\$${controller.balance.value.toStringAsFixed(2)}',
                        style: const TextStyle(
                            fontSize: 36,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      )),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      _buildBalanceAction(Icons.add, 'Top Up', () => _showTopUpDialog(context)),
                      const SizedBox(width: 16),
                      _buildBalanceAction(Icons.send, 'Transfer', () {
                        Get.snackbar('Coming Soon', 'Transfer feature not yet implemented');
                      }),
                      const SizedBox(width: 16),
                      _buildBalanceAction(Icons.history, 'History', () {}),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Quick stats
            Obx(() => Row(
                  children: [
                    _buildStatCard('Total Spent', '\$${controller.totalSpent.toStringAsFixed(0)}',
                        Icons.arrow_upward, const Color(0xFFFF6B6B)),
                    const SizedBox(width: 12),
                    _buildStatCard('Total Added', '\$${controller.totalAdded.toStringAsFixed(0)}',
                        Icons.arrow_downward, const Color(0xFF00C896)),
                  ],
                )),
            const SizedBox(height: 24),

            const Text('Recent Transactions',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppTheme.dark)),
            const SizedBox(height: 12),
            Obx(() {
              if (controller.walletTransactions.isEmpty) {
                return const Padding(
                  padding: EdgeInsets.symmetric(vertical: 24),
                  child: Center(
                    child: Text('No transactions yet', style: TextStyle(color: AppTheme.grey)),
                  ),
                );
              }
              return Column(
                children: controller.walletTransactions.map((tx) => Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppTheme.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 3))
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
                            child: Icon(tx['icon'] as IconData, color: tx['color'] as Color, size: 22),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(tx['title'],
                                    style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: AppTheme.dark)),
                                const SizedBox(height: 4),
                                Text(tx['date'], style: const TextStyle(fontSize: 12, color: AppTheme.grey)),
                              ],
                            ),
                          ),
                          Text(
                            tx['amount'],
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: tx['type'] == 'credit' ? const Color(0xFF00C896) : const Color(0xFFFF6B6B),
                            ),
                          ),
                        ],
                      ),
                    )).toList(),
              );
            }),
          ],
        ),
      ),
    );
  }

  void _showTopUpDialog(BuildContext context) {
    final controllerText = TextEditingController();
    Get.dialog(
      AlertDialog(
        title: const Text('Top Up Wallet'),
        content: TextField(
          controller: controllerText,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(prefixText: '\$ ', hintText: 'Enter amount'),
        ),
        actions: [
          TextButton(onPressed: () => Get.back(), child: const Text('Cancel')),
          TextButton(
            onPressed: () {
              final amount = double.tryParse(controllerText.text);
              if (amount != null && amount > 0) {
                controller.topUp(amount);
                Get.back();
                Get.snackbar('Success', '\$${amount.toStringAsFixed(0)} added to your wallet');
              }
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  Widget _buildBalanceAction(IconData icon, String label, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(icon, color: Colors.white, size: 20),
          ),
          const SizedBox(height: 6),
          Text(label, style: const TextStyle(fontSize: 12, color: Colors.white70)),
        ],
      ),
    );
  }

  Widget _buildStatCard(String label, String value, IconData icon, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppTheme.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 3))
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(10)),
              child: Icon(icon, color: color, size: 18),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: const TextStyle(fontSize: 11, color: AppTheme.grey)),
                Text(value, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppTheme.dark)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}