import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/theme/app_theme.dart';
import '../../../routes/app_routes.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        ),
        title: const Text('Profile'),
        elevation: 0,
        backgroundColor: AppTheme.white,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildStats(),
              _buildMenuSection('Account', [
                _MenuItem(Icons.person_outline, 'Personal Information', AppTheme.primary,
                    onTap: () => Get.toNamed(AppRoutes.editProfile)),
                _MenuItem(Icons.lock_outline, 'Change Password', AppTheme.primary,
                    onTap: () => Get.toNamed(AppRoutes.changePassword)),
                _MenuItem(Icons.notifications_outlined, 'Notifications', AppTheme.primary,
                    onTap: () => Get.toNamed(AppRoutes.notifications)),
                _MenuItem(Icons.account_balance_wallet_outlined, 'Wallet', AppTheme.primary,
                    onTap: () => Get.toNamed(AppRoutes.wallet)),    
                _MenuItem(Icons.payment, 'Payments', AppTheme.primary,
                    onTap: () => Get.toNamed(AppRoutes.payments)),    
                _MenuItem(Icons.settings_outlined, 'Settings', AppTheme.primary,
                    onTap: () => Get.toNamed(AppRoutes.settings)),
              ]),
              _buildMenuSection('Bookings', [
                _MenuItem(Icons.airplanemode_active, 'My Flights', Color(0xFF007BFF),
                    onTap: () => Get.toNamed(AppRoutes.myFlights)),
                _MenuItem(Icons.hotel, 'My Hotels', Color(0xFF00C896),
                    onTap: () => Get.toNamed(AppRoutes.myHotels)),
                _MenuItem(Icons.description, 'My Visas', Color(0xFF9C27B0),
                    onTap: () => Get.toNamed(AppRoutes.myVisas)),
              ]),
              _buildMenuSection('Support', [
                _MenuItem(Icons.help_outline, 'Help Center', AppTheme.grey,
                    onTap: () => Get.toNamed(AppRoutes.helpCenter)),
                _MenuItem(Icons.privacy_tip_outlined, 'Privacy Policy', AppTheme.grey,
                    onTap: () => Get.toNamed(AppRoutes.privacyPolicy)),
                _MenuItem(Icons.info_outline, 'About', AppTheme.grey,
                    onTap: () => Get.toNamed(AppRoutes.about)),
              ]),
              Padding(
                padding: const EdgeInsets.all(20),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => Get.offAllNamed(AppRoutes.login),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.error,
                    ),
                    child: const Text('Log Out'),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStats() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          _buildStatCard('12', 'Trips', Icons.airplanemode_active),
          const SizedBox(width: 12),
          _buildStatCard('5', 'Hotels', Icons.hotel),
          const SizedBox(width: 12),
          _buildStatCard('3', 'Visas', Icons.description),
        ],
      ),
    );
  }

  Widget _buildStatCard(String value, String label, IconData icon) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppTheme.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 3))],
        ),
        child: Column(
          children: [
            Icon(icon, color: AppTheme.primary, size: 24),
            const SizedBox(height: 8),
            Text(value, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppTheme.dark)),
            Text(label, style: const TextStyle(fontSize: 12, color: AppTheme.grey)),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuSection(String title, List<_MenuItem> items) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppTheme.dark)),
          const SizedBox(height: 12),
          Container(
            decoration: BoxDecoration(
              color: AppTheme.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 3))],
            ),
            child: Column(
              children: items.asMap().entries.map((entry) {
                final i = entry.key;
                final item = entry.value;
                return Column(
                  children: [
                    InkWell(
                      onTap: item.onTap,
                      borderRadius: BorderRadius.circular(16),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: item.color.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Icon(item.icon, color: item.color, size: 20),
                            ),
                            const SizedBox(width: 16),
                            Expanded(child: Text(item.label, style: const TextStyle(fontSize: 14, color: AppTheme.dark, fontWeight: FontWeight.w500))),
                            const Icon(Icons.arrow_forward_ios, size: 14, color: AppTheme.grey),
                          ],
                        ),
                      ),
                    ),
                    if (i < items.length - 1)
                      const Divider(height: 1, indent: 56),
                  ],
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

class _MenuItem {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback? onTap;
  const _MenuItem(this.icon, this.label, this.color, {this.onTap});
}