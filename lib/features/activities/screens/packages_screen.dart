import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/theme/app_theme.dart';
import '../../../routes/app_routes.dart';

class PackagesScreen extends StatefulWidget {
  const PackagesScreen({super.key});

  @override
  State<PackagesScreen> createState() => _PackagesScreenState();
}

class _PackagesScreenState extends State<PackagesScreen> {
  String _selectedFilter = 'All';
  final List<String> _filters = ['All', 'Beach', 'City', 'Adventure', 'Luxury'];

  final List<Map<String, dynamic>> _packages = [
    {
      'name': 'Dubai Dream Package',
      'description': '5 nights hotel + flights + desert safari + Burj Khalifa tour',
      'duration': '6 days / 5 nights',
      'price': '\$1,299',
      'rating': 4.9,
      'category': 'Luxury',
      'emoji': '🏙',
      'color': Color(0xFF007BFF),
      'includes': ['Flight', 'Hotel', 'Tours', 'Safari'],
    },
    {
      'name': 'Paris Getaway',
      'description': '4 nights in Paris with Eiffel Tower visit, Louvre Museum & Seine cruise',
      'duration': '5 days / 4 nights',
      'price': '\$899',
      'rating': 4.8,
      'category': 'City',
      'emoji': '🗼',
      'color': Color(0xFF9C27B0),
      'includes': ['Flight', 'Hotel', 'Tours'],
    },
    {
      'name': 'Maldives Paradise',
      'description': '7 nights overwater bungalow + snorkeling + sunset cruise',
      'duration': '8 days / 7 nights',
      'price': '\$2,499',
      'rating': 5.0,
      'category': 'Beach',
      'emoji': '🏝',
      'color': Color(0xFF00C896),
      'includes': ['Flight', 'Resort', 'Diving', 'Cruise'],
    },
    {
      'name': 'Tokyo Explorer',
      'description': '6 nights in Tokyo with food tour, temple visits & Mt. Fuji day trip',
      'duration': '7 days / 6 nights',
      'price': '\$1,599',
      'rating': 4.7,
      'category': 'City',
      'emoji': '⛩️',
      'color': Color(0xFFFF6B6B),
      'includes': ['Flight', 'Hotel', 'Tours', 'Food Tour'],
    },
    {
      'name': 'Sahara Adventure',
      'description': '3 nights desert camp + camel trek + quad biking + stargazing',
      'duration': '4 days / 3 nights',
      'price': '\$599',
      'rating': 4.8,
      'category': 'Adventure',
      'emoji': '🐪',
      'color': Color(0xFFFFB300),
      'includes': ['Transport', 'Camp', 'Activities'],
    },
    {
      'name': 'Greek Islands Cruise',
      'description': '7 nights cruise across Santorini, Mykonos & Rhodes with all meals',
      'duration': '8 days / 7 nights',
      'price': '\$1,899',
      'rating': 4.9,
      'category': 'Beach',
      'emoji': '🚢',
      'color': Color(0xFF007BFF),
      'includes': ['Flight', 'Cruise', 'Meals', 'Tours'],
    },
  ];

  List<Map<String, dynamic>> get _filteredPackages {
    if (_selectedFilter == 'All') return _packages;
    return _packages.where((p) => p['category'] == _selectedFilter).toList();
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
        title: const Text('Packages'),
        elevation: 0,
        backgroundColor: AppTheme.white,
      ),
      body: Column(
        children: [
          _buildFilterChips(),
          Expanded(child: _buildPackagesList()),
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
            child: GestureDetector(
              onTap: () => setState(() => _selectedFilter = filter),
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

  Widget _buildPackagesList() {
    final packages = _filteredPackages;
    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
      itemCount: packages.length,
      itemBuilder: (context, index) {
        final package = packages[index];
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 130,
                decoration: BoxDecoration(
                  color: (package['color'] as Color).withOpacity(0.15),
                  borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(20)),
                ),
                child: Stack(
                  children: [
                    Center(
                      child: Text(package['emoji'],
                          style: const TextStyle(fontSize: 64)),
                    ),
                    Positioned(
                      top: 12,
                      right: 12,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: (package['color'] as Color).withOpacity(0.9),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          package['category'],
                          style: const TextStyle(
                              fontSize: 11,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
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
                        Expanded(
                          child: Text(package['name'],
                              style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: AppTheme.dark)),
                        ),
                        Text(package['price'],
                            style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: AppTheme.primary)),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Text(package['description'],
                        style: const TextStyle(
                            fontSize: 12,
                            color: AppTheme.grey,
                            height: 1.4)),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        const Icon(Icons.access_time,
                            size: 13, color: AppTheme.grey),
                        const SizedBox(width: 4),
                        Text(package['duration'],
                            style: const TextStyle(
                                fontSize: 12, color: AppTheme.grey)),
                        const SizedBox(width: 12),
                        const Icon(Icons.star,
                            size: 13, color: Colors.amber),
                        const SizedBox(width: 4),
                        Text(package['rating'].toString(),
                            style: const TextStyle(
                                fontSize: 12, color: AppTheme.grey)),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Wrap(
                      spacing: 8,
                      runSpacing: 6,
                      children: (package['includes'] as List<String>)
                          .map((item) => Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 4),
                                decoration: BoxDecoration(
                                  color: AppTheme.background,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(item,
                                    style: const TextStyle(
                                        fontSize: 11,
                                        color: AppTheme.dark)),
                              ))
                          .toList(),
                    ),
                    const SizedBox(height: 14),
                    ElevatedButton(
                      onPressed: () => Get.toNamed(
                          AppRoutes.bookingConfirmation,
                          arguments: package),
                      child: const Text('Book Package',
                          style: TextStyle(fontWeight: FontWeight.bold)),
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