import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/theme/app_theme.dart';
import '../../../routes/app_routes.dart';
import '../../../controllers/booking_controller.dart';

class ActivitiesScreen extends StatefulWidget {
  const ActivitiesScreen({super.key});

  @override
  State<ActivitiesScreen> createState() => _ActivitiesScreenState();
}

class _ActivitiesScreenState extends State<ActivitiesScreen> {
  String _selectedFilter = 'All';
  final List<String> _filters = ['All', 'Tours', 'Adventure', 'Culture', 'Food'];
  final BookingController bookingController = Get.find<BookingController>();

  final List<Map<String, dynamic>> _activities = [
    {
      'name': 'Burj Khalifa Tour',
      'location': 'Dubai, UAE',
      'price': '\$45',
      'rating': 4.8,
      'duration': '2 hours',
      'category': 'Tours',
      'emoji': '🏙',
      'color': Color(0xFF007BFF),
    },
    {
      'name': 'Desert Safari',
      'location': 'Dubai, UAE',
      'price': '\$89',
      'rating': 4.9,
      'duration': '6 hours',
      'category': 'Adventure',
      'emoji': '🐪',
      'color': Color(0xFFFFB300),
    },
    {
      'name': 'Eiffel Tower Visit',
      'location': 'Paris, France',
      'price': '\$35',
      'rating': 4.7,
      'duration': '3 hours',
      'category': 'Culture',
      'emoji': '🗼',
      'color': Color(0xFF9C27B0),
    },
    {
      'name': 'Tokyo Food Tour',
      'location': 'Tokyo, Japan',
      'price': '\$65',
      'rating': 4.9,
      'duration': '4 hours',
      'category': 'Food',
      'emoji': '🍜',
      'color': Color(0xFFFF6B6B),
    },
    {
      'name': 'Snorkeling Maldives',
      'location': 'Maldives',
      'price': '\$120',
      'rating': 5.0,
      'duration': '3 hours',
      'category': 'Adventure',
      'emoji': '🤿',
      'color': Color(0xFF00C896),
    },
    {
      'name': 'Louvre Museum',
      'location': 'Paris, France',
      'price': '\$25',
      'rating': 4.6,
      'duration': '4 hours',
      'category': 'Culture',
      'emoji': '🎨',
      'color': Color(0xFF9C27B0),
    },
    {
      'name': 'Pyramids Tour',
      'location': 'Cairo, Egypt',
      'price': '\$30',
      'rating': 4.8,
      'duration': '5 hours',
      'category': 'Tours',
      'emoji': '🏛',
      'color': Color(0xFFFFB300),
    },
    {
      'name': 'Sushi Making Class',
      'location': 'Tokyo, Japan',
      'price': '\$75',
      'rating': 4.7,
      'duration': '2 hours',
      'category': 'Food',
      'emoji': '🍣',
      'color': Color(0xFFFF6B6B),
    },
  ];

  List<Map<String, dynamic>> get _filteredActivities {
    if (_selectedFilter == 'All') return _activities;
    return _activities.where((a) => a['category'] == _selectedFilter).toList();
  }

  void _handleBook(Map<String, dynamic> activity) {
    final success = bookingController.addBooking(
      type: 'Activity',
      title: activity['name'],
      date: 'To be scheduled',
      price: activity['price'],
      emoji: activity['emoji'],
      color: activity['color'],
    );
    if (success) {
      Get.toNamed(AppRoutes.activityDetails, arguments: activity);
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
        title: const Text('Activities'),
        elevation: 0,
        backgroundColor: AppTheme.white,
        actions: [
          TextButton(
            onPressed: () => Get.toNamed(AppRoutes.packages),
            child: const Text('Packages', style: TextStyle(color: AppTheme.primary)),
          ),
        ],
      ),
      body: Column(
        children: [
          _buildFilterChips(),
          Expanded(child: _buildActivitiesList()),
        ],
      ),
    );
  }

  Widget _buildFilterChips() {
    return SizedBox(
      height: 56,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
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
                padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
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

  Widget _buildActivitiesList() {
    final activities = _filteredActivities;
    return GridView.builder(
      padding: const EdgeInsets.all(20),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 0.85,
      ),
      itemCount: activities.length,
      itemBuilder: (context, index) {
        final activity = activities[index];
        return Container(
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 100,
                decoration: BoxDecoration(
                  color: (activity['color'] as Color).withOpacity(0.15),
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                ),
                child: Center(
                  child: Text(activity['emoji'], style: const TextStyle(fontSize: 48)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      activity['name'],
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                        color: AppTheme.dark,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(Icons.location_on, size: 11, color: AppTheme.grey),
                        const SizedBox(width: 2),
                        Expanded(
                          child: Text(
                            activity['location'],
                            style: const TextStyle(fontSize: 11, color: AppTheme.grey),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(Icons.star, size: 11, color: Colors.amber),
                        const SizedBox(width: 2),
                        Text(activity['rating'].toString(), style: const TextStyle(fontSize: 11, color: AppTheme.grey)),
                        const Spacer(),
                        const Icon(Icons.access_time, size: 11, color: AppTheme.grey),
                        const SizedBox(width: 2),
                        Text(activity['duration'], style: const TextStyle(fontSize: 11, color: AppTheme.grey)),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          activity['price'],
                          style: const TextStyle(
                            color: AppTheme.primary,
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                        InkWell(
                          onTap: () => _handleBook(activity),
                          borderRadius: BorderRadius.circular(8),
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: AppTheme.primary,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Text('Book', style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold)),
                          ),
                        ),
                      ],
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
}