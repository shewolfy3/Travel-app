import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/theme/app_theme.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        ),
        title: const Text('Privacy Policy'),
        elevation: 0,
        backgroundColor: AppTheme.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Last updated: July 1, 2026',
                style: TextStyle(fontSize: 12, color: AppTheme.grey)),
            const SizedBox(height: 24),
            _buildSection('1. Information We Collect',
                'We collect information you provide directly to us, such as your name, email address, phone number, and payment information when you register or make a booking through our app.'),
            _buildSection('2. How We Use Your Information',
                'We use the information we collect to process bookings, send booking confirmations and updates, provide customer support, and improve our services.'),
            _buildSection('3. Information Sharing',
                'We do not sell or share your personal information with third parties except as necessary to process your bookings (e.g. airlines, hotels) or as required by law.'),
            _buildSection('4. Data Security',
                'We implement appropriate security measures to protect your personal information. All payment data is encrypted and processed securely through Stripe.'),
            _buildSection('5. Your Rights',
                'You have the right to access, correct, or delete your personal information at any time. You can update your profile information directly in the app.'),
            _buildSection('6. Cookies',
                'We use cookies and similar technologies to improve your experience and analyze app usage. You can control cookie settings through your device settings.'),
            _buildSection('7. Contact Us',
                'If you have any questions about this Privacy Policy, please contact us at privacy@travelapp.com or through the Help Center.'),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title, String content) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.dark)),
          const SizedBox(height: 8),
          Text(content,
              style: const TextStyle(
                  fontSize: 13, color: AppTheme.grey, height: 1.6)),
        ],
      ),
    );
  }
}