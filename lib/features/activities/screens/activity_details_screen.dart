import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/theme/app_theme.dart';
import '../../../routes/app_routes.dart';

class ActivityDetailsScreen extends StatefulWidget {
  const ActivityDetailsScreen({super.key});

  @override
  State<ActivityDetailsScreen> createState() => _ActivityDetailsScreenState();
}

class _ActivityDetailsScreenState extends State<ActivityDetailsScreen> {
  int _guests = 1;
  String _selectedDate = 'July 10, 2026';

  final List<String> _dates = [
    'July 10, 2026',
    'July 11, 2026',
    'July 12, 2026',
    'July 15, 2026',
    'July 16, 2026',
  ];

  @override
  Widget build(BuildContext context) {
    final activity = Get.arguments as Map<String, dynamic>;

    return Scaffold(
      backgroundColor: AppTheme.background,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200,
            pinned: true,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Get.back(),
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                color: (activity['color'] as Color).withOpacity(0.2),
                child: Center(
                  child: Text(activity['emoji'],
                      style: const TextStyle(fontSize: 80)),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(activity['name'],
                            style: const TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: AppTheme.dark)),
                      ),
                      Text(activity['price'],
                          style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: AppTheme.primary)),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.location_on,
                          size: 14, color: AppTheme.grey),
                      const SizedBox(width: 4),
                      Text(activity['location'],
                          style: const TextStyle(
                              fontSize: 13, color: AppTheme.grey)),
                      const SizedBox(width: 12),
                      const Icon(Icons.star, size: 14, color: Colors.amber),
                      const SizedBox(width: 4),
                      Text(activity['rating'].toString(),
                          style: const TextStyle(
                              fontSize: 13, color: AppTheme.grey)),
                      const SizedBox(width: 12),
                      const Icon(Icons.access_time,
                          size: 14, color: AppTheme.grey),
                      const SizedBox(width: 4),
                      Text(activity['duration'],
                          style: const TextStyle(
                              fontSize: 13, color: AppTheme.grey)),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const Text('About',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.dark)),
                  const SizedBox(height: 8),
                  Text(
                    'Discover the best of ${activity['location']} with this amazing ${activity['name']} experience. A perfect activity for travelers looking to explore the culture and highlights of the destination.',
                    style: const TextStyle(
                        fontSize: 13, color: AppTheme.grey, height: 1.6),
                  ),
                  const SizedBox(height: 24),
                  const Text('Select Date',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.dark)),
                  const SizedBox(height: 12),
                  SizedBox(
                    height: 44,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: _dates.length,
                      itemBuilder: (context, index) {
                        final date = _dates[index];
                        final isSelected = _selectedDate == date;
                        return GestureDetector(
                          onTap: () =>
                              setState(() => _selectedDate = date),
                          child: Container(
                            margin: const EdgeInsets.only(right: 10),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 10),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? AppTheme.primary
                                  : AppTheme.white,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: isSelected
                                    ? AppTheme.primary
                                    : AppTheme.lightGrey,
                              ),
                            ),
                            child: Text(date,
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: isSelected
                                        ? Colors.white
                                        : AppTheme.dark)),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 24),
                  const Text('Guests',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.dark)),
                  const SizedBox(height: 12),
                  Container(
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Number of Guests',
                            style: TextStyle(
                                fontSize: 14, color: AppTheme.dark)),
                        Row(
                          children: [
                            IconButton(
                              onPressed: _guests > 1
                                  ? () =>
                                      setState(() => _guests--)
                                  : null,
                              icon: const Icon(Icons.remove_circle_outline),
                              color: AppTheme.primary,
                            ),
                            Text('$_guests',
                                style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: AppTheme.dark)),
                            IconButton(
                              onPressed: () =>
                                  setState(() => _guests++),
                              icon: const Icon(Icons.add_circle_outline),
                              color: AppTheme.primary,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),
                  ElevatedButton(
                    onPressed: () =>
                        Get.toNamed(AppRoutes.bookingConfirmation,
                            arguments: {
                          ...activity,
                          'date': _selectedDate,
                          'guests': _guests,
                        }),
                    child: const Text('Book Now',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}