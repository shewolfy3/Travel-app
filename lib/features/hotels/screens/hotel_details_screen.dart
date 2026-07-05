import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/theme/app_theme.dart';
import '../../../routes/app_routes.dart';

class HotelDetailsScreen extends StatefulWidget {
  const HotelDetailsScreen({super.key});

  @override
  State<HotelDetailsScreen> createState() => _HotelDetailsScreenState();
}

class _HotelDetailsScreenState extends State<HotelDetailsScreen> {
  int _selectedRoom = 0;

  final List<Map<String, dynamic>> _rooms = [
    {
      'type': 'Standard Room',
      'beds': '1 King Bed',
      'size': '32 m²',
      'price': '\$200/night',
    },
    {
      'type': 'Deluxe Room',
      'beds': '1 King Bed + Sofa',
      'size': '45 m²',
      'price': '\$320/night',
    },
    {
      'type': 'Suite',
      'beds': '2 King Beds',
      'size': '80 m²',
      'price': '\$500/night',
    },
  ];

  final List<Map<String, String>> _reviews = [
    {
      'name': 'Ahmed K.',
      'rating': '5',
      'comment': 'Absolutely stunning hotel, service was top notch.',
      'date': 'June 2026',
    },
    {
      'name': 'Sarah M.',
      'rating': '4',
      'comment': 'Great location and very clean rooms. Would visit again.',
      'date': 'May 2026',
    },
    {
      'name': 'James L.',
      'rating': '5',
      'comment': 'Best hotel experience of my life. The pool is incredible.',
      'date': 'April 2026',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final hotel = Get.arguments as Map<String, dynamic>;

    return Scaffold(
      backgroundColor: AppTheme.background,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 220,
            pinned: true,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Get.back(),
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                color: (hotel['color'] as Color).withOpacity(0.2),
                child: Center(
                  child: Text(hotel['emoji'],
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
                        child: Text(hotel['name'],
                            style: const TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: AppTheme.dark)),
                      ),
                      Text(hotel['price'],
                          style: const TextStyle(
                              fontSize: 16,
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
                      Text(hotel['location'],
                          style: const TextStyle(
                              fontSize: 13, color: AppTheme.grey)),
                      const SizedBox(width: 12),
                      const Icon(Icons.star, size: 14, color: Colors.amber),
                      const SizedBox(width: 4),
                      Text(hotel['rating'].toString(),
                          style: const TextStyle(
                              fontSize: 13, color: AppTheme.grey)),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Wrap(
                    spacing: 8,
                    children:
                        (hotel['amenities'] as List<String>).map((a) {
                      return Chip(
                        label: Text(a,
                            style: const TextStyle(fontSize: 12)),
                        backgroundColor: AppTheme.background,
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 24),
                  const Text('About',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.dark)),
                  const SizedBox(height: 8),
                  Text(
                    'Experience world-class hospitality at ${hotel['name']}. Located in the heart of ${hotel['location']}, this hotel offers breathtaking views, exceptional dining, and unmatched service. Perfect for both leisure and business travelers.',
                    style: const TextStyle(
                        fontSize: 13, color: AppTheme.grey, height: 1.6),
                  ),
                  const SizedBox(height: 24),
                  const Text('Select Room',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.dark)),
                  const SizedBox(height: 12),
                  ...List.generate(_rooms.length, (index) {
                    final room = _rooms[index];
                    final isSelected = _selectedRoom == index;
                    return GestureDetector(
                      onTap: () => setState(() => _selectedRoom = index),
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: AppTheme.white,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: isSelected
                                ? AppTheme.primary
                                : Colors.transparent,
                            width: 2,
                          ),
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
                                color: AppTheme.primary.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Icon(Icons.bed,
                                  color: AppTheme.primary, size: 22),
                            ),
                            const SizedBox(width: 14),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(room['type'],
                                      style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: AppTheme.dark)),
                                  const SizedBox(height: 4),
                                  Text(
                                      '${room['beds']} · ${room['size']}',
                                      style: const TextStyle(
                                          fontSize: 12,
                                          color: AppTheme.grey)),
                                ],
                              ),
                            ),
                            Text(room['price'],
                                style: const TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                    color: AppTheme.primary)),
                            if (isSelected) ...[
                              const SizedBox(width: 8),
                              const Icon(Icons.check_circle,
                                  color: AppTheme.primary, size: 20),
                            ]
                          ],
                        ),
                      ),
                    );
                  }),
                  const SizedBox(height: 24),
                  const Text('Guest Reviews',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.dark)),
                  const SizedBox(height: 12),
                  ..._reviews.map((review) => Container(
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
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                              children: [
                                Text(review['name']!,
                                    style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: AppTheme.dark)),
                                Row(
                                  children: [
                                    const Icon(Icons.star,
                                        size: 14, color: Colors.amber),
                                    const SizedBox(width: 4),
                                    Text(review['rating']!,
                                        style: const TextStyle(
                                            fontSize: 13,
                                            color: AppTheme.grey)),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(height: 6),
                            Text(review['comment']!,
                                style: const TextStyle(
                                    fontSize: 13,
                                    color: AppTheme.grey,
                                    height: 1.5)),
                            const SizedBox(height: 4),
                            Text(review['date']!,
                                style: const TextStyle(
                                    fontSize: 11, color: AppTheme.grey)),
                          ],
                        ),
                      )),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () => Get.toNamed(
                        AppRoutes.bookingConfirmation,
                        arguments: {
                          ...hotel,
                          'room': _rooms[_selectedRoom]['type'],
                          'roomPrice': _rooms[_selectedRoom]['price'],
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