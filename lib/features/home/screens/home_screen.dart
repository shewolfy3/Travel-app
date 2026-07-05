import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/theme/app_theme.dart';
import '../../../routes/app_routes.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final List<Map<String, dynamic>> _categories = [
    {'icon': Icons.airplanemode_active, 'label': 'Flights', 'color': Color(0xFF007BFF), 'route': '/flights'},
    {'icon': Icons.hotel, 'label': 'Hotels', 'color': Color(0xFF00C896), 'route': '/hotels'},
    {'icon': Icons.explore, 'label': 'Activities', 'color': Color(0xFFFF6B6B), 'route': '/activities'},
    {'icon': Icons.card_travel, 'label': 'Packages', 'color': Color(0xFFFFB300), 'route': '/packages'},
    {'icon': Icons.description, 'label': 'Visa', 'color': Color(0xFF9C27B0), 'route': '/visa'},
  ];

  final List<Map<String, String>> _destinations = [
    {'name': 'Paris', 'country': 'France', 'price': '\$299', 'emoji': '🗼', 'route': '/flights'},
    {'name': 'Dubai', 'country': 'UAE', 'price': '\$199', 'emoji': '🏙', 'route': '/flights'},
    {'name': 'Tokyo', 'country': 'Japan', 'price': '\$499', 'emoji': '⛩️', 'route': '/flights'},
    {'name': 'Maldives', 'country': 'Maldives', 'price': '\$699', 'emoji': '🏝', 'route': '/hotels'},
  ];

  final List<Map<String, String>> _offers = [
    {'title': '30% OFF Flights', 'subtitle': 'Book before July 30', 'emoji': '✈️', 'color': '0xFF007BFF', 'route': '/flights'},
    {'title': 'Free Hotel Night', 'subtitle': 'Stay 3 nights get 1 free', 'emoji': '🏨', 'color': '0xFF00C896', 'route': '/hotels'},
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
    title: const Text('Hotels'),
    elevation: 0,
    backgroundColor: AppTheme.white,
  ),
  body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSearchBar(),
              _buildOffersBanner(),
              _buildCategories(),
              _buildPopularDestinations(),
              const SizedBox(height: 80),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomNav(),
    );
  }

 

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: InkWell(
        onTap: () => Get.toNamed(AppRoutes.search),
        child: Container(
          decoration: BoxDecoration(
            color: AppTheme.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 12, offset: const Offset(0, 4)),
            ],
          ),
          child: TextField(
            enabled: false,
            decoration: InputDecoration(
              hintText: 'Search destinations...',
              hintStyle: const TextStyle(color: AppTheme.grey),
              prefixIcon: const Icon(Icons.search, color: AppTheme.primary),
              suffixIcon: Container(
                margin: const EdgeInsets.all(8),
                decoration: BoxDecoration(color: AppTheme.primary, borderRadius: BorderRadius.circular(10)),
                child: const Icon(Icons.tune, color: Colors.white, size: 20),
              ),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(vertical: 16),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildOffersBanner() {
    return SizedBox(
      height: 140,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        itemCount: _offers.length,
        itemBuilder: (context, index) {
          final offer = _offers[index];
          final color = Color(int.parse(offer['color']!));
          return InkWell(
            onTap: () => Get.toNamed(offer['route']!),
            child: Container(
              width: 280,
              margin: const EdgeInsets.only(right: 16, bottom: 8),
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [BoxShadow(color: color.withOpacity(0.3), blurRadius: 12, offset: const Offset(0, 6))],
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(offer['title']!, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                          const SizedBox(height: 6),
                          Text(offer['subtitle']!, style: const TextStyle(color: Colors.white70, fontSize: 13)),
                          const SizedBox(height: 12),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
                            child: Text('Book Now', style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 12)),
                          ),
                        ],
                      ),
                    ),
                    Text(offer['emoji']!, style: const TextStyle(fontSize: 48)),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildCategories() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.fromLTRB(20, 24, 20, 16),
          child: Text('Explore', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppTheme.dark)),
        ),
        SizedBox(
          height: 90,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            itemCount: _categories.length,
            itemBuilder: (context, index) {
              final cat = _categories[index];
              return InkWell(
                onTap: () {
  final route = cat['route'] as String;
  if (route == '/flights') Get.toNamed(AppRoutes.flights);
  else if (route == '/hotels') Get.toNamed(AppRoutes.hotels);
  else if (route == '/activities') Get.toNamed(AppRoutes.activities);
  else if (route == '/visa') Get.toNamed(AppRoutes.visa);
  else if (route == '/search') Get.toNamed(AppRoutes.search);
},
                child: Container(
                  margin: const EdgeInsets.only(right: 16),
                  child: Column(
                    children: [
                      Container(
                        width: 56,
                        height: 56,
                        decoration: BoxDecoration(
                          color: (cat['color'] as Color).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Icon(cat['icon'] as IconData, color: cat['color'] as Color, size: 28),
                      ),
                      const SizedBox(height: 8),
                      Text(cat['label'] as String, style: const TextStyle(fontSize: 12, color: AppTheme.dark, fontWeight: FontWeight.w500)),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildPopularDestinations() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 24, 20, 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Popular Destinations', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppTheme.dark)),
              TextButton(
  onPressed: () => Get.toNamed(AppRoutes.destination),
  child: const Text('See all'),
),
            ],
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 20),
          itemCount: _destinations.length,
          itemBuilder: (context, index) {
            final dest = _destinations[index];
            return InkWell(
              onTap: () => Get.toNamed(dest['route']!),
              child: Container(
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: AppTheme.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 12, offset: const Offset(0, 4))],
                ),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(16),
                  leading: Container(
                    width: 56,
                    height: 56,
                    decoration: BoxDecoration(color: AppTheme.background, borderRadius: BorderRadius.circular(12)),
                    child: Center(child: Text(dest['emoji']!, style: const TextStyle(fontSize: 28))),
                  ),
                  title: Text(dest['name']!, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: AppTheme.dark)),
                  subtitle: Text(dest['country']!, style: const TextStyle(color: AppTheme.grey, fontSize: 13)),
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(dest['price']!, style: const TextStyle(color: AppTheme.primary, fontWeight: FontWeight.bold, fontSize: 16)),
                      const Text('per person', style: TextStyle(color: AppTheme.grey, fontSize: 11)),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildBottomNav() {
    return BottomNavigationBar(
      currentIndex: _currentIndex,
      onTap: (i) {
        setState(() => _currentIndex = i);
        if (i == 1) Get.toNamed(AppRoutes.search);
        if (i == 2) Navigator.pushNamed(context, '/bookings');
        if (i == 3) Get.toNamed(AppRoutes.profile);
      },
      type: BottomNavigationBarType.fixed,
      selectedItemColor: AppTheme.primary,
      unselectedItemColor: AppTheme.grey,
      backgroundColor: AppTheme.white,
      elevation: 12,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
        BottomNavigationBarItem(icon: Icon(Icons.bookmark_outline), label: 'Bookings'),
        BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'Profile'),
      ],
    );
  }
}