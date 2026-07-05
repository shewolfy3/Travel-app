import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/theme/app_theme.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  bool _pushEnabled = true;
  bool _emailEnabled = true;
  bool _smsEnabled = false;
  bool _bookingUpdates = true;
  bool _promotions = false;
  bool _reminders = true;

  final List<_NotificationItem> _recent = [
    _NotificationItem(
      icon: Icons.airplanemode_active,
      color: Color(0xFF007BFF),
      title: 'Flight Confirmed',
      subtitle: 'Your flight to Dubai has been confirmed.',
      time: '2 hours ago',
    ),
    _NotificationItem(
      icon: Icons.hotel,
      color: Color(0xFF00C896),
      title: 'Hotel Booking Approved',
      subtitle: 'Burj Al Arab reservation is confirmed.',
      time: 'Yesterday',
    ),
    _NotificationItem(
      icon: Icons.local_offer,
      color: Color(0xFFFF6B35),
      title: 'Special Offer',
      subtitle: '30% off on flights to Paris this weekend.',
      time: '3 days ago',
    ),
    _NotificationItem(
      icon: Icons.description,
      color: Color(0xFF9C27B0),
      title: 'Visa Update',
      subtitle: 'Your visa application is under review.',
      time: '1 week ago',
    ),
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
        title: const Text('Notifications'),
        elevation: 0,
        backgroundColor: AppTheme.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Preferences',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.dark)),
            const SizedBox(height: 12),
            _buildPreferenceCard([
              _buildToggle('Push Notifications', _pushEnabled,
                  (v) => setState(() => _pushEnabled = v)),
              _buildToggle('Email Notifications', _emailEnabled,
                  (v) => setState(() => _emailEnabled = v)),
              _buildToggle('SMS Notifications', _smsEnabled,
                  (v) => setState(() => _smsEnabled = v)),
            ]),
            const SizedBox(height: 24),
            const Text('Notify me about',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.dark)),
            const SizedBox(height: 12),
            _buildPreferenceCard([
              _buildToggle('Booking Updates', _bookingUpdates,
                  (v) => setState(() => _bookingUpdates = v)),
              _buildToggle('Promotions & Deals', _promotions,
                  (v) => setState(() => _promotions = v)),
              _buildToggle('Trip Reminders', _reminders,
                  (v) => setState(() => _reminders = v)),
            ]),
            const SizedBox(height: 24),
            const Text('Recent',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.dark)),
            const SizedBox(height: 12),
            ..._recent.map((item) => _buildNotificationCard(item)),
          ],
        ),
      ),
    );
  }

  Widget _buildPreferenceCard(List<Widget> children) {
    return Container(
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
      child: Column(children: children),
    );
  }

  Widget _buildToggle(String label, bool value, ValueChanged<bool> onChanged) {
    return SwitchListTile(
      title: Text(label,
          style: const TextStyle(fontSize: 14, color: AppTheme.dark)),
      value: value,
      onChanged: onChanged,
      activeColor: AppTheme.primary,
    );
  }

  Widget _buildNotificationCard(_NotificationItem item) {
    return Container(
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
              color: item.color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(item.icon, color: item.color, size: 22),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item.title,
                    style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.dark)),
                const SizedBox(height: 4),
                Text(item.subtitle,
                    style:
                        const TextStyle(fontSize: 12, color: AppTheme.grey)),
                const SizedBox(height: 4),
                Text(item.time,
                    style: const TextStyle(
                        fontSize: 11, color: AppTheme.grey)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _NotificationItem {
  final IconData icon;
  final Color color;
  final String title;
  final String subtitle;
  final String time;
  const _NotificationItem(
     {required this.icon,
      required this.color,
      required this.title,
      required this.subtitle,
      required this.time});
}