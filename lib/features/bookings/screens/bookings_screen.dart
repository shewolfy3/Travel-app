import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/theme/app_theme.dart';

class BookingsScreen extends StatefulWidget {
  const BookingsScreen({super.key});

  @override
  State<BookingsScreen> createState() => _BookingsScreenState();
}

class _BookingsScreenState extends State<BookingsScreen> {
  String _selectedTab = 'Upcoming';
  final List<String> _tabs = ['Upcoming', 'Completed', 'Cancelled'];

  final List<Map<String, dynamic>> _bookings = [
    {
      'type': 'Flight',
      'title': 'Cairo → Paris',
      'date': 'July 15, 2026',
      'status': 'Upcoming',
      'price': '\$299',
      'emoji': '✈️',
      'color': Color(0xFF007BFF),
    },
    {
      'type': 'Hotel',
      'title': 'Le Méridien Paris',
      'date': 'July 15-20, 2026',
      'status': 'Upcoming',
      'price': '\$600',
      'emoji': '🏨',
      'color': Color(0xFF00C896),
    },
    {
      'type': 'Activity',
      'title': 'Eiffel Tower Visit',
      'date': 'July 16, 2026',
      'status': 'Upcoming',
      'price': '\$35',
      'emoji': '🗼',
      'color': Color(0xFFFF6B6B),
    },
    {
      'type': 'Flight',
      'title': 'Cairo → Dubai',
      'date': 'March 10, 2026',
      'status': 'Completed',
      'price': '\$199',
      'emoji': '✈️',
      'color': Color(0xFF007BFF),
    },
    {
      'type': 'Visa',
      'title': 'Japan Tourist Visa',
      'date': 'January 5, 2026',
      'status': 'Cancelled',
      'price': '\$60',
      'emoji': '📄',
      'color': Color(0xFF9C27B0),
    },
  ];

  List<Map<String, dynamic>> get _filteredBookings {
    return _bookings.where((b) => b['status'] == _selectedTab).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        ),
        title: const Text('My Bookings'),
        elevation: 0,
        backgroundColor: AppTheme.white,
      ),
      body: Column(
        children: [
          _buildTabs(),
          Expanded(child: _buildBookingsList()),
        ],
      ),
    );
  }

  Widget _buildTabs() {
    return Container(
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: AppTheme.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 3)),
        ],
      ),
      child: Row(
        children: _tabs.map((tab) {
          final isSelected = _selectedTab == tab;
          return Expanded(
            child: InkWell(
              onTap: () => setState(() => _selectedTab = tab),
              borderRadius: BorderRadius.circular(10),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: isSelected ? AppTheme.primary : Colors.transparent,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  tab,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: isSelected ? Colors.white : AppTheme.grey,
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildBookingsList() {
    final bookings = _filteredBookings;

    if (bookings.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.inbox_outlined, size: 64, color: AppTheme.grey),
            const SizedBox(height: 16),
            Text('No $_selectedTab bookings', style: const TextStyle(color: AppTheme.grey, fontSize: 16)),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
      itemCount: bookings.length,
      itemBuilder: (context, index) {
        final booking = bookings[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 14),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppTheme.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 3)),
            ],
          ),
          child: Row(
            children: [
              Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  color: (booking['color'] as Color).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(child: Text(booking['emoji'], style: const TextStyle(fontSize: 24))),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      booking['title'],
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: AppTheme.dark),
                    ),
                    const SizedBox(height: 4),
                    Text(booking['date'], style: const TextStyle(fontSize: 12, color: AppTheme.grey)),
                  ],
                ),
              ),
              Text(
                booking['price'],
                style: const TextStyle(color: AppTheme.primary, fontWeight: FontWeight.bold, fontSize: 15),
              ),
            ],
          ),
        );
      },
    );
  }
}