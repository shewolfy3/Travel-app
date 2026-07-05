import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import '../../../routes/app_routes.dart';
import '../../../controllers/booking_controller.dart';

class FlightsScreen extends StatefulWidget {
  const FlightsScreen({super.key});

  @override
  State<FlightsScreen> createState() => _FlightsScreenState();
}

class _FlightsScreenState extends State<FlightsScreen> {
  String _tripType = 'One Way';
  final List<String> _tripTypes = ['One Way', 'Round Trip', 'Multi-City'];
  final BookingController bookingController = Get.find<BookingController>();

  final List<Map<String, dynamic>> _flights = [
    {
      'airline': 'EgyptAir',
      'from': 'CAI',
      'to': 'CDG',
      'fromCity': 'Cairo',
      'toCity': 'Paris',
      'departure': '08:00',
      'arrival': '13:20',
      'duration': '5h 20m',
      'price': '\$299',
      'type': 'Direct',
      'color': Color(0xFF007BFF),
    },
    {
      'airline': 'Emirates',
      'from': 'CAI',
      'to': 'DXB',
      'fromCity': 'Cairo',
      'toCity': 'Dubai',
      'departure': '14:30',
      'arrival': '17:40',
      'duration': '3h 10m',
      'price': '\$199',
      'type': 'Direct',
      'color': Color(0xFFFF6B6B),
    },
    {
      'airline': 'Qatar Airways',
      'from': 'CAI',
      'to': 'NRT',
      'fromCity': 'Cairo',
      'toCity': 'Tokyo',
      'departure': '22:00',
      'arrival': '18:30',
      'duration': '14h 30m',
      'price': '\$499',
      'type': '1 Stop',
      'color': Color(0xFF9C27B0),
    },
    {
      'airline': 'Turkish Airlines',
      'from': 'CAI',
      'to': 'JFK',
      'fromCity': 'Cairo',
      'toCity': 'New York',
      'departure': '06:15',
      'arrival': '14:45',
      'duration': '16h 30m',
      'price': '\$650',
      'type': '1 Stop',
      'color': Color(0xFF00C896),
    },
    {
      'airline': 'Air Arabia',
      'from': 'CAI',
      'to': 'DXB',
      'fromCity': 'Cairo',
      'toCity': 'Dubai',
      'departure': '09:45',
      'arrival': '13:00',
      'duration': '3h 15m',
      'price': '\$149',
      'type': 'Direct',
      'color': Color(0xFFFFB300),
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
        title: const Text('Flights'),
        elevation: 0,
        backgroundColor: AppTheme.white,
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTripTypeSelector(),
            _buildSearchCard(),
            const Padding(
              padding: EdgeInsets.fromLTRB(20, 16, 20, 8),
              child: Text(
                'Available Flights',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.dark,
                ),
              ),
            ),
            Expanded(child: _buildFlightsList()),
          ],
        ),
      ),
    );
  }

  Widget _buildTripTypeSelector() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
      child: Row(
        children: _tripTypes.map((type) {
          final isSelected = _tripType == type;
          return Padding(
            padding: const EdgeInsets.only(right: 10),
            child: GestureDetector(
              onTap: () => setState(() => _tripType = type),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: isSelected ? AppTheme.primary : AppTheme.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: isSelected ? AppTheme.primary : AppTheme.lightGrey,
                  ),
                ),
                child: Text(
                  type,
                  style: TextStyle(
                    color: isSelected ? Colors.white : AppTheme.dark,
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

  Widget _buildSearchCard() {
    return Container(
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(16),
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
          Row(
            children: [
              Expanded(
                child: _buildLocationField('From', 'Cairo (CAI)', Icons.flight_takeoff),
              ),
              const SizedBox(width: 12),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppTheme.primary.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.swap_horiz, color: AppTheme.primary),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildLocationField('To', 'Select city', Icons.flight_land),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _buildDateField('Departure', 'Select date', Icons.calendar_today),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildDateField('Passengers', '1 Adult', Icons.person_outline),
              ),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {},
              child: const Text('Search Flights'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLocationField(String label, String hint, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppTheme.background,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontSize: 11, color: AppTheme.grey)),
          const SizedBox(height: 4),
          Row(
            children: [
              Icon(icon, size: 16, color: AppTheme.primary),
              const SizedBox(width: 6),
              Text(hint, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: AppTheme.dark)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDateField(String label, String value, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppTheme.background,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontSize: 11, color: AppTheme.grey)),
          const SizedBox(height: 4),
          Row(
            children: [
              Icon(icon, size: 16, color: AppTheme.primary),
              const SizedBox(width: 6),
              Text(value, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: AppTheme.dark)),
            ],
          ),
        ],
      ),
    );
  }

  void _handleBook(Map<String, dynamic> flight) {
    final success = bookingController.addBooking(
      type: 'Flight',
      title: '${flight['fromCity']} → ${flight['toCity']}',
      date: 'To be scheduled',
      price: flight['price'],
      emoji: '✈️',
      color: flight['color'],
    );
    if (success) {
      Get.toNamed(AppRoutes.flightDetails, arguments: flight);
    }
  }

  Widget _buildFlightsList() {
    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
      itemCount: _flights.length,
      itemBuilder: (context, index) {
        final flight = _flights[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 14),
          padding: const EdgeInsets.all(16),
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
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    flight['airline'],
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: flight['color'] as Color,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: (flight['color'] as Color).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      flight['type'],
                      style: TextStyle(
                        fontSize: 11,
                        color: flight['color'] as Color,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(flight['departure'], style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppTheme.dark)),
                      Text(flight['from'], style: const TextStyle(fontSize: 12, color: AppTheme.grey)),
                    ],
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Text(flight['duration'], style: const TextStyle(fontSize: 11, color: AppTheme.grey)),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Container(width: 6, height: 6, decoration: const BoxDecoration(color: AppTheme.primary, shape: BoxShape.circle)),
                            Expanded(child: Container(height: 1, color: AppTheme.lightGrey)),
                            const Icon(Icons.airplanemode_active, size: 16, color: AppTheme.primary),
                            Expanded(child: Container(height: 1, color: AppTheme.lightGrey)),
                            Container(width: 6, height: 6, decoration: const BoxDecoration(color: AppTheme.primary, shape: BoxShape.circle)),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(flight['arrival'], style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppTheme.dark)),
                      Text(flight['to'], style: const TextStyle(fontSize: 12, color: AppTheme.grey)),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    flight['price'],
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppTheme.primary),
                  ),
                  ElevatedButton(
                    onPressed: () => _handleBook(flight),
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(100, 36),
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                    ),
                    child: const Text('Book'),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}