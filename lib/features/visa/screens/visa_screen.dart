import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import '../../../routes/app_routes.dart';
import '../../../controllers/booking_controller.dart';

class VisaScreen extends StatefulWidget {
  const VisaScreen({super.key});

  @override
  State<VisaScreen> createState() => _VisaScreenState();
}

class _VisaScreenState extends State<VisaScreen> {
  String _selectedFilter = 'All';
  final List<String> _filters = ['All', 'Tourist', 'Business', 'Student', 'Transit'];
  final BookingController bookingController = Get.find<BookingController>();

  final List<Map<String, dynamic>> _visas = [
    {
      'country': 'Japan',
      'type': 'Tourist',
      'duration': '90 days',
      'processing': '5-7 days',
      'price': '\$60',
      'emoji': '🇯🇵',
      'color': Color(0xFFFF6B6B),
      'requirements': ['Passport', 'Bank Statement', 'Hotel Booking'],
    },
    {
      'country': 'USA',
      'type': 'Tourist',
      'duration': '180 days',
      'processing': '10-15 days',
      'price': '\$160',
      'emoji': '🇺🇸',
      'color': Color(0xFF007BFF),
      'requirements': ['Passport', 'Bank Statement', 'Interview'],
    },
    {
      'country': 'UK',
      'type': 'Tourist',
      'duration': '180 days',
      'processing': '15 days',
      'price': '\$115',
      'emoji': '🇬🇧',
      'color': Color(0xFF9C27B0),
      'requirements': ['Passport', 'Bank Statement', 'Accommodation'],
    },
    {
      'country': 'UAE',
      'type': 'Tourist',
      'duration': '30 days',
      'processing': '3-5 days',
      'price': '\$90',
      'emoji': '🇦🇪',
      'color': Color(0xFF00C896),
      'requirements': ['Passport', 'Photo', 'Return Ticket'],
    },
    {
      'country': 'Germany',
      'type': 'Business',
      'duration': '90 days',
      'processing': '10 days',
      'price': '\$80',
      'emoji': '🇩🇪',
      'color': Color(0xFFFFB300),
      'requirements': ['Passport', 'Invitation Letter', 'Bank Statement'],
    },
    {
      'country': 'Canada',
      'type': 'Student',
      'duration': '1 year',
      'processing': '8 weeks',
      'price': '\$150',
      'emoji': '🇨🇦',
      'color': Color(0xFFFF6B6B),
      'requirements': ['Passport', 'Acceptance Letter', 'Proof of Funds'],
    },
  ];

  List<Map<String, dynamic>> get _filteredVisas {
    if (_selectedFilter == 'All') return _visas;
    return _visas.where((v) => v['type'] == _selectedFilter).toList();
  }

  void _handleApply(Map<String, dynamic> visa) {
    final success = bookingController.addBooking(
      type: 'Visa',
      title: '${visa['country']} ${visa['type']} Visa',
      date: 'To be scheduled',
      price: visa['price'],
      emoji: visa['emoji'],
      color: visa['color'],
    );
    if (success) {
      Get.toNamed(AppRoutes.visaDetails, arguments: visa);
    }
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
        title: const Text('Visa'),
        elevation: 0,
        backgroundColor: AppTheme.white,
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildFilterChips(),
            Expanded(child: _buildVisaList()),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterChips() {
    return SizedBox(
      height: 44,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        itemCount: _filters.length,
        itemBuilder: (context, index) {
          final filter = _filters[index];
          final isSelected = _selectedFilter == filter;
          return Padding(
            padding: const EdgeInsets.only(right: 10),
            child: InkWell(
              onTap: () => setState(() => _selectedFilter = filter),
              borderRadius: BorderRadius.circular(24),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                decoration: BoxDecoration(
                  color: isSelected ? AppTheme.primary : AppTheme.white,
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(
                    color: isSelected ? AppTheme.primary : AppTheme.lightGrey,
                  ),
                ),
                child: Text(
                  filter,
                  style: TextStyle(
                    color: isSelected ? Colors.white : AppTheme.dark,
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildVisaList() {
    final visas = _filteredVisas;
    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
      itemCount: visas.length,
      itemBuilder: (context, index) {
        final visa = visas[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 16),
          decoration: BoxDecoration(
            color: AppTheme.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.06),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: (visa['color'] as Color).withOpacity(0.1),
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                ),
                child: Row(
                  children: [
                    Text(visa['emoji'], style: const TextStyle(fontSize: 40)),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            visa['country'],
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: AppTheme.dark,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                            decoration: BoxDecoration(
                              color: (visa['color'] as Color).withOpacity(0.2),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              visa['type'],
                              style: TextStyle(
                                fontSize: 11,
                                color: visa['color'] as Color,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      visa['price'],
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.primary,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Row(
                      children: [
                        _buildInfoChip(Icons.access_time, 'Processing: ${visa['processing']}'),
                        const SizedBox(width: 12),
                        _buildInfoChip(Icons.calendar_month, 'Stay: ${visa['duration']}'),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(Icons.checklist, size: 16, color: AppTheme.grey),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            (visa['requirements'] as List<String>).join(' · '),
                            style: const TextStyle(fontSize: 12, color: AppTheme.grey),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () => _handleApply(visa),
                        child: const Text('Apply Now'),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildInfoChip(IconData icon, String text) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        decoration: BoxDecoration(
          color: AppTheme.background,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Icon(icon, size: 14, color: AppTheme.primary),
            const SizedBox(width: 6),
            Expanded(
              child: Text(text, style: const TextStyle(fontSize: 11, color: AppTheme.dark)),
            ),
          ],
        ),
      ),
    );
  }
}