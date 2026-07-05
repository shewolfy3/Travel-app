import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/theme/app_theme.dart';

class HelpCenterScreen extends StatefulWidget {
  const HelpCenterScreen({super.key});

  @override
  State<HelpCenterScreen> createState() => _HelpCenterScreenState();
}

class _HelpCenterScreenState extends State<HelpCenterScreen> {
  final List<_FaqItem> _faqs = [
    _FaqItem('How do I book a flight?',
        'Go to the Flights section, enter your origin, destination and dates, then select your preferred flight and complete the booking.'),
    _FaqItem('Can I cancel my booking?',
        'Yes, you can cancel bookings from the My Bookings section. Cancellation policies vary depending on the airline or hotel.'),
    _FaqItem('How do I apply for a visa?',
        'Navigate to the Visa section, select your destination country, fill in the required details and submit your application.'),
    _FaqItem('How long does visa processing take?',
        'Processing times vary by country, typically between 3–15 business days. You will be notified once your application is reviewed.'),
    _FaqItem('Is my payment information secure?',
        'Yes, all payments are processed through Stripe with end-to-end encryption. We never store your card details.'),
    _FaqItem('How do I contact support?',
        'You can reach our support team via the contact options below, available 24/7.'),
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
        title: const Text('Help Center'),
        elevation: 0,
        backgroundColor: AppTheme.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppTheme.primary,
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Hi, how can we help?',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white)),
                  SizedBox(height: 4),
                  Text('Browse FAQs or contact our support team',
                      style: TextStyle(fontSize: 13, color: Colors.white70)),
                ],
              ),
            ),
            const SizedBox(height: 24),
            const Text('Frequently Asked Questions',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.dark)),
            const SizedBox(height: 12),
            Container(
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
              child: Column(
                children: _faqs.asMap().entries.map((entry) {
                  final i = entry.key;
                  final faq = entry.value;
                  return Column(
                    children: [
                      ExpansionTile(
                        title: Text(faq.question,
                            style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: AppTheme.dark)),
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                            child: Text(faq.answer,
                                style: const TextStyle(
                                    fontSize: 13, color: AppTheme.grey)),
                          ),
                        ],
                      ),
                      if (i < _faqs.length - 1)
                        const Divider(height: 1, indent: 16),
                    ],
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 24),
            const Text('Contact Us',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.dark)),
            const SizedBox(height: 12),
            _buildContactCard(Icons.email_outlined, 'Email Support',
                'support@travelapp.com', const Color(0xFF007BFF)),
            const SizedBox(height: 12),
            _buildContactCard(Icons.phone_outlined, 'Phone Support',
                '+20 100 000 0000', const Color(0xFF00C896)),
            const SizedBox(height: 12),
            _buildContactCard(Icons.chat_outlined, 'Live Chat',
                'Available 24/7', const Color(0xFF9C27B0)),
          ],
        ),
      ),
    );
  }

  Widget _buildContactCard(
      IconData icon, String title, String subtitle, Color color) {
    return Container(
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
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: color, size: 22),
          ),
          const SizedBox(width: 14),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.dark)),
              Text(subtitle,
                  style:
                      const TextStyle(fontSize: 12, color: AppTheme.grey)),
            ],
          ),
        ],
      ),
    );
  }
}

class _FaqItem {
  final String question;
  final String answer;
  const _FaqItem(this.question, this.answer);
}