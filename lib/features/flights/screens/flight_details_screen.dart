import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/theme/app_theme.dart';
import '../../../routes/app_routes.dart';

class FlightDetailsScreen extends StatefulWidget {
  const FlightDetailsScreen({super.key});

  @override
  State<FlightDetailsScreen> createState() => _FlightDetailsScreenState();
}

class _FlightDetailsScreenState extends State<FlightDetailsScreen> {
  int _selectedSeat = -1;
  String _selectedBag = 'No Bag';

  final List<String> _bagOptions = [
    'No Bag',
    'Cabin Bag (7kg) — \$20',
    'Checked Bag (23kg) — \$45',
    'Checked Bag (32kg) — \$70',
  ];

  final _nameController = TextEditingController();
  final _passportController = TextEditingController();
  final _nationalityController = TextEditingController();

  final List<bool> _seats = List.generate(30, (i) => i % 7 == 0 || i % 5 == 0);

  @override
  void dispose() {
    _nameController.dispose();
    _passportController.dispose();
    _nationalityController.dispose();
    super.dispose();
  }

  void _bookFlight(Map<String, dynamic> flight) {
    if (_nameController.text.isEmpty || _passportController.text.isEmpty) {
      Get.snackbar('Missing Info', 'Please fill in passenger details');
      return;
    }
    if (_selectedSeat == -1) {
      Get.snackbar('No Seat', 'Please select a seat');
      return;
    }
    Get.toNamed(AppRoutes.bookingConfirmation, arguments: {
      ...flight,
      'passenger': _nameController.text,
      'passport': _passportController.text,
      'seat': 'Seat ${_selectedSeat + 1}',
      'bag': _selectedBag,
    });
  }

  @override
  Widget build(BuildContext context) {
    final flight = Get.arguments as Map<String, dynamic>;

    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        ),
        title: Text('${flight['from']} → ${flight['to']}'),
        elevation: 0,
        backgroundColor: AppTheme.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Flight summary card
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: (flight['color'] as Color).withOpacity(0.1),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(flight['airline'],
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: flight['color'] as Color)),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: (flight['color'] as Color).withOpacity(0.2),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(flight['type'],
                            style: TextStyle(
                                fontSize: 11,
                                color: flight['color'] as Color,
                                fontWeight: FontWeight.w600)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(flight['departure'],
                              style: const TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                  color: AppTheme.dark)),
                          Text(flight['from'],
                              style: const TextStyle(
                                  fontSize: 13, color: AppTheme.grey)),
                          Text(flight['fromCity'],
                              style: const TextStyle(
                                  fontSize: 12, color: AppTheme.grey)),
                        ],
                      ),
                      Column(
                        children: [
                          Text(flight['duration'],
                              style: const TextStyle(
                                  fontSize: 12, color: AppTheme.grey)),
                          const Icon(Icons.airplanemode_active,
                              color: AppTheme.primary, size: 28),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(flight['arrival'],
                              style: const TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                  color: AppTheme.dark)),
                          Text(flight['to'],
                              style: const TextStyle(
                                  fontSize: 13, color: AppTheme.grey)),
                          Text(flight['toCity'],
                              style: const TextStyle(
                                  fontSize: 12, color: AppTheme.grey)),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(flight['price'],
                      style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.primary)),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Passenger details
            const Text('Passenger Details',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.dark)),
            const SizedBox(height: 12),
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Full Name',
                prefixIcon: const Icon(Icons.person_outline),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12)),
                filled: true,
                fillColor: AppTheme.white,
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _passportController,
              decoration: InputDecoration(
                labelText: 'Passport Number',
                prefixIcon: const Icon(Icons.credit_card),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12)),
                filled: true,
                fillColor: AppTheme.white,
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _nationalityController,
              decoration: InputDecoration(
                labelText: 'Nationality',
                prefixIcon: const Icon(Icons.flag_outlined),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12)),
                filled: true,
                fillColor: AppTheme.white,
              ),
            ),
            const SizedBox(height: 24),

            // Seat selection
            const Text('Select Seat',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.dark)),
            const SizedBox(height: 8),
            Row(
              children: [
                _buildSeatLegend(AppTheme.primary, 'Selected'),
                const SizedBox(width: 16),
                _buildSeatLegend(AppTheme.lightGrey, 'Available'),
                const SizedBox(width: 16),
                _buildSeatLegend(Colors.grey.shade400, 'Taken'),
              ],
            ),
            const SizedBox(height: 12),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 6,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
                childAspectRatio: 1,
              ),
              itemCount: 30,
              itemBuilder: (context, index) {
                final isTaken = _seats[index];
                final isSelected = _selectedSeat == index;
                return GestureDetector(
                  onTap: isTaken
                      ? null
                      : () => setState(() => _selectedSeat = index),
                  child: Container(
                    decoration: BoxDecoration(
                      color: isSelected
                          ? AppTheme.primary
                          : isTaken
                              ? Colors.grey.shade400
                              : AppTheme.lightGrey,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: Text('${index + 1}',
                          style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              color: isSelected
                                  ? Colors.white
                                  : AppTheme.dark)),
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 24),

            // Baggage
            const Text('Baggage',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.dark)),
            const SizedBox(height: 12),
            ..._bagOptions.map((bag) {
              final isSelected = _selectedBag == bag;
              return GestureDetector(
                onTap: () => setState(() => _selectedBag = bag),
                child: Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: AppTheme.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: isSelected
                          ? AppTheme.primary
                          : Colors.transparent,
                      width: 2,
                    ),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.04),
                          blurRadius: 8,
                          offset: const Offset(0, 2))
                    ],
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.luggage, color: AppTheme.primary),
                      const SizedBox(width: 12),
                      Expanded(
                          child: Text(bag,
                              style: const TextStyle(
                                  fontSize: 13, color: AppTheme.dark))),
                      if (isSelected)
                        const Icon(Icons.check_circle,
                            color: AppTheme.primary, size: 20),
                    ],
                  ),
                ),
              );
            }),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => _bookFlight(flight),
              child: const Text('Confirm Booking',
                  style: TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold)),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildSeatLegend(Color color, String label) {
    return Row(
      children: [
        Container(
          width: 16,
          height: 16,
          decoration:
              BoxDecoration(color: color, borderRadius: BorderRadius.circular(4)),
        ),
        const SizedBox(width: 4),
        Text(label,
            style: const TextStyle(fontSize: 11, color: AppTheme.grey)),
      ],
    );
  }
}