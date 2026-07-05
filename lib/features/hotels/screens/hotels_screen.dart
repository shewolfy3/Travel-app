import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import '../../../routes/app_routes.dart';
import '../../../controllers/booking_controller.dart';

class HotelsScreen extends StatefulWidget {
  const HotelsScreen({super.key});

  @override
  State<HotelsScreen> createState() => _HotelsScreenState();
}

class _HotelsScreenState extends State<HotelsScreen> {
  String _selectedFilter = 'All';
  final List<String> _filters = ['All', '5-star', '4-star', 'Budget', 'Resort'];
  final BookingController bookingController = Get.find<BookingController>();

  Map<String, dynamic>? _destination;

  @override
  void initState() {
    super.initState();
    final args = Get.arguments;
    if (args is Map<String, dynamic>) {
      _destination = args;
    }
  }

  final List<Map<String, dynamic>> _hotels = [
    {
      'name': 'Burj Al Arab',
      'location': 'Dubai, UAE',
      'price': '\$500/night',
      'rating': 5.0,
      'stars': '5-star',
      'emoji': '🏨',
      'color': Color(0xFF007BFF),
      'amenities': ['WiFi', 'Pool', 'Spa'],
    },
    {
      'name': 'Le Méridien Paris',
      'location': 'Paris, France',
      'price': '\$120/night',
      'rating': 4.7,
      'stars': '5-star',
      'emoji': '🗼',
      'color': Color(0xFF00C896),
      'amenities': ['WiFi', 'Breakfast', 'Gym'],
    },
    {
      'name': 'Atlantis The Palm',
      'location': 'Dubai, UAE',
      'price': '\$280/night',
      'rating': 4.9,
      'stars': '5-star',
      'emoji': '🌴',
      'color': Color(0xFFFF6B6B),
      'amenities': ['Pool', 'Beach', 'Spa'],
    },
    {
      'name': 'Park Hyatt Tokyo',
      'location': 'Tokyo, Japan',
      'price': '\$350/night',
      'rating': 4.8,
      'stars': '5-star',
      'emoji': '⛩️',
      'color': Color(0xFF9C27B0),
      'amenities': ['WiFi', 'Pool', 'Restaurant'],
    },
    {
      'name': 'Ibis Cairo',
      'location': 'Cairo, Egypt',
      'price': '\$45/night',
      'rating': 4.1,
      'stars': 'Budget',
      'emoji': '🏢',
      'color': Color(0xFFFFB300),
      'amenities': ['WiFi', 'Breakfast'],
    },
    {
      'name': 'Four Seasons Maldives',
      'location': 'Maldives',
      'price': '\$800/night',
      'rating': 5.0,
      'stars': 'Resort',
      'emoji': '🏝',
      'color': Color(0xFF00C896),
      'amenities': ['Beach', 'Pool', 'Diving'],
    },
    {
      'name': 'Novotel Tokyo',
      'location': 'Tokyo, Japan',
      'price': '\$150/night',
      'rating': 4.3,
      'stars': '4-star',
      'emoji': '🏯',
      'color': Color(0xFFFF6B6B),
      'amenities': ['WiFi', 'Breakfast', 'Gym'],
    },
    {
      'name': 'Ibis Paris',
      'location': 'Paris, France',
      'price': '\$60/night',
      'rating': 4.0,
      'stars': 'Budget',
      'emoji': '🥐',
      'color': Color(0xFF9C27B0),
      'amenities': ['WiFi', 'Breakfast'],
    },
    {
      'name': 'Club Med Dubai',
      'location': 'Dubai, UAE',
      'price': '\$220/night',
      'rating': 4.5,
      'stars': 'Resort',
      'emoji': '🌴',
      'color': Color(0xFF007BFF),
      'amenities': ['Pool', 'Beach', 'Spa'],
    },
    {
      'name': 'Capsule Inn Tokyo',
      'location': 'Tokyo, Japan',
      'price': '\$40/night',
      'rating': 4.2,
      'stars': 'Budget',
      'emoji': '🛏️',
      'color': Color(0xFFFF6B6B),
      'amenities': ['WiFi'],
    },
    {
      'name': 'Nile Ritz-Carlton',
      'location': 'Cairo, Egypt',
      'price': '\$180/night',
      'rating': 4.1,
      'stars': '4-star',
      'emoji': '🏛',
      'color': Color(0xFFFFB300),
      'amenities': ['WiFi', 'Pool', 'Spa'],
    },
    {
      'name': 'Cairo Budget Inn',
      'location': 'Cairo, Egypt',
      'price': '\$25/night',
      'rating': 3.9,
      'stars': 'Budget',
      'emoji': '🏨',
      'color': Color(0xFFFFB300),
      'amenities': ['WiFi'],
    },
    {
      'name': 'Pod Hotel NYC',
      'location': 'New York, USA',
      'price': '\$90/night',
      'rating': 4.0,
      'stars': 'Budget',
      'emoji': '🗽',
      'color': Color(0xFF607D8B),
      'amenities': ['WiFi', 'Gym'],
    },
    {
      'name': 'Soneva Fushi',
      'location': 'Maldives',
      'price': '\$950/night',
      'rating': 4.2,
      'stars': '4-star',
      'emoji': '🏝',
      'color': Color(0xFF00C896),
      'amenities': ['Beach', 'Pool', 'Diving', 'Spa'],
    },
    {
      'name': 'Maldives Budget Bungalow',
      'location': 'Maldives',
      'price': '\$150/night',
      'rating': 4.0,
      'stars': 'Budget',
      'emoji': '🏝',
      'color': Color(0xFF00C896),
      'amenities': ['WiFi', 'Beach'],
    },
    {
      'name': 'The Plaza',
      'location': 'New York, USA',
      'price': '\$400/night',
      'rating': 4.6,
      'stars': '4-star',
      'emoji': '🗽',
      'color': Color(0xFF607D8B),
      'amenities': ['WiFi', 'Gym', 'Restaurant'],
    },
    {
      'name': 'The Plaza',
      'location': 'New York, USA',
      'price': '\$400/night',
      'rating': 4.7,
      'stars': '5-star',
      'emoji': '🗽',
      'color': Color(0xFF607D8B),
      'amenities': ['WiFi', 'Gym', 'Restaurant'],
    },
  ];

  List<Map<String, dynamic>> get _filteredHotels {
    var list = _hotels;
    if (_destination != null) {
      final destName = _destination!['name'] as String?;
      if (destName != null) {
        list = list.where((h) => (h['location'] as String).contains(destName)).toList();
      }
    }
    if (_selectedFilter != 'All') {
      list = list.where((h) => h['stars'] == _selectedFilter).toList();
    }
    return list;
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
        title: Text(_destination != null ? 'Hotels in ${_destination!['name']}' : 'Hotels'),
        elevation: 0,
        backgroundColor: AppTheme.white,
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildFilterChips(),
            Expanded(child: _buildHotelsList()),
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
            child: GestureDetector(
              onTap: () => setState(() => _selectedFilter = filter),
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

  void _handleBookNow(Map<String, dynamic> hotel) {
    final success = bookingController.addBooking(
      type: 'Hotel',
      title: hotel['name'],
      date: 'To be scheduled',
      price: hotel['price'],
      emoji: hotel['emoji'],
      color: hotel['color'],
    );
    if (success) {
      Get.toNamed(AppRoutes.hotelDetails, arguments: hotel);
    }
  }

  Widget _buildHotelsList() {
    final hotels = _filteredHotels;
    if (hotels.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Text(
            _destination != null
                ? 'No hotels found in ${_destination!['name']} yet.'
                : 'No hotels found.',
            style: const TextStyle(color: AppTheme.grey, fontSize: 14),
            textAlign: TextAlign.center,
          ),
        ),
      );
    }
    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
      itemCount: hotels.length,
      itemBuilder: (context, index) {
        final hotel = hotels[index];
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
                height: 120,
                decoration: BoxDecoration(
                  color: (hotel['color'] as Color).withOpacity(0.15),
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                ),
                child: Center(
                  child: Text(hotel['emoji'], style: const TextStyle(fontSize: 56)),
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
                        Text(
                          hotel['name'],
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: AppTheme.dark,
                          ),
                        ),
                        Text(
                          hotel['price'],
                          style: const TextStyle(
                            color: AppTheme.primary,
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(Icons.location_on, size: 14, color: AppTheme.grey),
                        const SizedBox(width: 4),
                        Text(
                          hotel['location'],
                          style: const TextStyle(color: AppTheme.grey, fontSize: 13),
                        ),
                        const Spacer(),
                        const Icon(Icons.star, size: 14, color: Colors.amber),
                        const SizedBox(width: 4),
                        Text(
                          hotel['rating'].toString(),
                          style: const TextStyle(fontSize: 13, color: AppTheme.grey),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 8,
                      children: (hotel['amenities'] as List<String>).map((a) {
                        return Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: AppTheme.background,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(a, style: const TextStyle(fontSize: 11, color: AppTheme.dark)),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () => _handleBookNow(hotel),
                        child: const Text('Book Now'),
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
}