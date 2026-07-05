import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/theme/app_theme.dart';
import '../../../routes/app_routes.dart';

class DestinationScreen extends StatelessWidget {
  const DestinationScreen({super.key});

  final List<Map<String, dynamic>> _destinations = const [
    {
      'name': 'Dubai',
      'country': 'UAE',
      'description': 'City of luxury, desert adventures and iconic skyscrapers.',
      'emoji': '🏙',
      'color': Color(0xFF007BFF),
      'temp': '38°C',
      'rating': 4.9,
      'tags': ['Luxury', 'Shopping', 'Desert'],
    },
    {
      'name': 'Paris',
      'country': 'France',
      'description': 'The city of love, art, fashion and world-class cuisine.',
      'emoji': '🗼',
      'color': Color(0xFF9C27B0),
      'temp': '22°C',
      'rating': 4.8,
      'tags': ['Romance', 'Culture', 'Food'],
    },
    {
      'name': 'Tokyo',
      'country': 'Japan',
      'description': 'A blend of ultra-modern technology and ancient tradition.',
      'emoji': '⛩️',
      'color': Color(0xFFFF6B6B),
      'temp': '28°C',
      'rating': 4.9,
      'tags': ['Culture', 'Food', 'Tech'],
    },
    {
      'name': 'Maldives',
      'country': 'Maldives',
      'description': 'Paradise islands with crystal waters and overwater bungalows.',
      'emoji': '🏝',
      'color': Color(0xFF00C896),
      'temp': '30°C',
      'rating': 5.0,
      'tags': ['Beach', 'Luxury', 'Diving'],
    },
    {
      'name': 'New York',
      'country': 'USA',
      'description': 'The city that never sleeps — iconic skyline and endless energy.',
      'emoji': '🗽',
      'color': Color(0xFF607D8B),
      'temp': '18°C',
      'rating': 4.7,
      'tags': ['City', 'Culture', 'Shopping'],
    },
    {
      'name': 'Cairo',
      'country': 'Egypt',
      'description': 'Home of the ancient pyramids and rich pharaonic history.',
      'emoji': '🏛',
      'color': Color(0xFFFFB300),
      'temp': '35°C',
      'rating': 4.6,
      'tags': ['History', 'Culture', 'Tours'],
    },
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
        title: const Text('Destinations'),
        elevation: 0,
        backgroundColor: AppTheme.white,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: _destinations.length,
        itemBuilder: (context, index) {
          final dest = _destinations[index];
          return GestureDetector(
            onTap: () => Get.toNamed(AppRoutes.hotels, arguments: dest),
            child: Container(
              margin: const EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                color: AppTheme.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withOpacity(0.06),
                      blurRadius: 12,
                      offset: const Offset(0, 4))
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 140,
                    decoration: BoxDecoration(
                      color: (dest['color'] as Color).withOpacity(0.15),
                      borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(20)),
                    ),
                    child: Stack(
                      children: [
                        Center(
                          child: Text(dest['emoji'],
                              style: const TextStyle(fontSize: 72)),
                        ),
                        Positioned(
                          top: 12,
                          right: 12,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.4),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Row(
                              children: [
                                const Icon(Icons.thermostat,
                                    size: 12, color: Colors.white),
                                const SizedBox(width: 4),
                                Text(dest['temp'],
                                    style: const TextStyle(
                                        fontSize: 12,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold)),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('${dest['name']}, ${dest['country']}',
                                style: const TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                    color: AppTheme.dark)),
                            Row(
                              children: [
                                const Icon(Icons.star,
                                    size: 14, color: Colors.amber),
                                const SizedBox(width: 4),
                                Text(dest['rating'].toString(),
                                    style: const TextStyle(
                                        fontSize: 13,
                                        color: AppTheme.grey)),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Text(dest['description'],
                            style: const TextStyle(
                                fontSize: 13,
                                color: AppTheme.grey,
                                height: 1.4)),
                        const SizedBox(height: 10),
                        Wrap(
                          spacing: 8,
                          children: (dest['tags'] as List<String>)
                              .map((tag) => Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 4),
                                    decoration: BoxDecoration(
                                      color: (dest['color'] as Color)
                                          .withOpacity(0.1),
                                      borderRadius:
                                          BorderRadius.circular(20),
                                    ),
                                    child: Text(tag,
                                        style: TextStyle(
                                            fontSize: 11,
                                            color: dest['color'] as Color,
                                            fontWeight: FontWeight.w600)),
                                  ))
                              .toList(),
                        ),
                        const SizedBox(height: 12),
                        ElevatedButton(
                          onPressed: () => Get.toNamed(AppRoutes.hotels, arguments: dest),
                          child: const Text('Explore',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}