import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import '../../../routes/app_routes.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String _selectedFilter = 'All';
  final TextEditingController _searchController = TextEditingController();

  double _minPrice = 0;
  double _maxPrice = 1000;
  double _minRating = 0;

  final List<String> _filters = ['All', 'Flights', 'Hotels', 'Activities', 'Visa'];

  final List<Map<String, dynamic>> _results = [
    {
      'type': 'Flight',
      'title': 'Cairo → Paris',
      'subtitle': 'EgyptAir · Direct · 5h 20m',
      'price': '\$299',
      'rating': 4.5,
      'emoji': '✈️',
      'color': Color(0xFF007BFF),
    },
    {
      'type': 'Hotel',
      'title': 'Le Méridien Paris',
      'subtitle': '5-star · Free cancellation',
      'price': '\$120/night',
      'rating': 4.7,
      'emoji': '🏨',
      'color': Color(0xFF00C896),
    },
    {
      'type': 'Flight',
      'title': 'Cairo → Dubai',
      'subtitle': 'Emirates · Direct · 3h 10m',
      'price': '\$199',
      'rating': 4.6,
      'emoji': '✈️',
      'color': Color(0xFF007BFF),
    },
    {
      'type': 'Activity',
      'title': 'Burj Khalifa Tickets',
      'subtitle': 'Skip the line · 2 hours',
      'price': '\$45',
      'rating': 4.8,
      'emoji': '🗼',
      'color': Color(0xFFFF6B6B),
    },
    {
      'type': 'Hotel',
      'title': 'Atlantis The Palm',
      'subtitle': '5-star · Beachfront',
      'price': '\$280/night',
      'rating': 4.9,
      'emoji': '🏨',
      'color': Color(0xFF00C896),
    },
    {
      'type': 'Visa',
      'title': 'Japan Tourist Visa',
      'subtitle': 'Processing time: 5-7 days',
      'price': '\$60',
      'rating': 4.3,
      'emoji': '📄',
      'color': Color(0xFF9C27B0),
    },
  ];

  List<Map<String, dynamic>> get _filteredResults {
    var list = _results;

    final query = _searchController.text.trim().toLowerCase();
    if (query.isNotEmpty) {
      list = list.where((r) {
        final title = (r['title'] as String).toLowerCase();
        final subtitle = (r['subtitle'] as String).toLowerCase();
        return title.contains(query) || subtitle.contains(query);
      }).toList();
    }

    if (_selectedFilter != 'All') {
      final filterMap = {
        'Flights': 'Flight',
        'Hotels': 'Hotel',
        'Activities': 'Activity',
        'Visa': 'Visa',
      };
      list = list.where((r) => r['type'] == filterMap[_selectedFilter]).toList();
    }

    list = list.where((r) {
      final price = _extractPrice(r['price'] as String);
      final rating = r['rating'] as double;
      return price >= _minPrice && price <= _maxPrice && rating >= _minRating;
    }).toList();

    return list;
  }

  double _extractPrice(String price) {
    final match = RegExp(r'[\d.]+').firstMatch(price);
    return match != null ? double.parse(match.group(0)!) : 0;
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
        title: const Text('Search'),
        elevation: 0,
        backgroundColor: AppTheme.white,
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSearchBar(),
            _buildFilterChips(),
            Expanded(child: _buildResultsList()),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Container(
        decoration: BoxDecoration(
          color: AppTheme.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: TextField(
          controller: _searchController,
          onChanged: (_) => setState(() {}),
          decoration: InputDecoration(
            hintText: 'Search flights, hotels, activities...',
            hintStyle: const TextStyle(color: AppTheme.grey),
            prefixIcon: const Icon(Icons.search, color: AppTheme.primary),
            suffixIcon: IconButton(
              icon: const Icon(Icons.tune, color: AppTheme.primary),
              onPressed: _showFilterSheet,
            ),
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(vertical: 16),
          ),
        ),
      ),
    );
  }

  void _showFilterSheet() {
    double tempMinPrice = _minPrice;
    double tempMaxPrice = _maxPrice;
    double tempMinRating = _minRating;

    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setSheetState) {
            return Padding(
              padding: EdgeInsets.only(
                left: 20,
                right: 20,
                top: 20,
                bottom: MediaQuery.of(context).viewInsets.bottom + 20,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Filters',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppTheme.dark),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Price range: \$${tempMinPrice.toInt()} - \$${tempMaxPrice.toInt()}',
                    style: const TextStyle(fontWeight: FontWeight.w600, color: AppTheme.dark),
                  ),
                  RangeSlider(
                    values: RangeValues(tempMinPrice, tempMaxPrice),
                    min: 0,
                    max: 1000,
                    divisions: 20,
                    activeColor: AppTheme.primary,
                    labels: RangeLabels(
                      '\$${tempMinPrice.toInt()}',
                      '\$${tempMaxPrice.toInt()}',
                    ),
                    onChanged: (values) {
                      setSheetState(() {
                        tempMinPrice = values.start;
                        tempMaxPrice = values.end;
                      });
                    },
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Minimum rating: ${tempMinRating.toStringAsFixed(1)}+',
                    style: const TextStyle(fontWeight: FontWeight.w600, color: AppTheme.dark),
                  ),
                  Slider(
                    value: tempMinRating,
                    min: 0,
                    max: 5,
                    divisions: 10,
                    activeColor: AppTheme.primary,
                    label: tempMinRating.toStringAsFixed(1),
                    onChanged: (value) {
                      setSheetState(() => tempMinRating = value);
                    },
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {
                            setSheetState(() {
                              tempMinPrice = 0;
                              tempMaxPrice = 1000;
                              tempMinRating = 0;
                            });
                          },
                          child: const Text('Reset'),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              _minPrice = tempMinPrice;
                              _maxPrice = tempMaxPrice;
                              _minRating = tempMinRating;
                            });
                            Navigator.pop(context);
                          },
                          child: const Text('Apply'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
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

  void _onResultTap(Map<String, dynamic> item) {
    switch (item['type']) {
      case 'Flight':
        Get.toNamed(AppRoutes.flights, arguments: item);
        break;
      case 'Hotel':
        Get.toNamed(AppRoutes.hotels, arguments: item);
        break;
      case 'Activity':
        Get.toNamed(AppRoutes.activities, arguments: item);
        break;
      case 'Visa':
        Get.toNamed(AppRoutes.visa, arguments: item);
        break;
    }
  }

  Widget _buildResultsList() {
    final results = _filteredResults;

    if (results.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.search_off, size: 64, color: AppTheme.grey),
            const SizedBox(height: 16),
            const Text(
              'No results found',
              style: TextStyle(color: AppTheme.grey, fontSize: 16),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(20, 4, 20, 20),
      itemCount: results.length,
      itemBuilder: (context, index) {
        final item = results[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 14),
          decoration: BoxDecoration(
            color: AppTheme.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: InkWell(
            borderRadius: BorderRadius.circular(16),
            onTap: () => _onResultTap(item),
            child: ListTile(
              contentPadding: const EdgeInsets.all(14),
              leading: Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  color: (item['color'] as Color).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Text(item['emoji'], style: const TextStyle(fontSize: 24)),
                ),
              ),
              title: Text(
                item['title'],
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: AppTheme.dark,
                ),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 4),
                  Text(
                    item['subtitle'],
                    style: const TextStyle(color: AppTheme.grey, fontSize: 12),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.star, size: 14, color: Colors.amber),
                      const SizedBox(width: 4),
                      Text(
                        item['rating'].toString(),
                        style: const TextStyle(fontSize: 12, color: AppTheme.grey),
                      ),
                    ],
                  ),
                ],
              ),
              trailing: Text(
                item['price'],
                style: const TextStyle(
                  color: AppTheme.primary,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
