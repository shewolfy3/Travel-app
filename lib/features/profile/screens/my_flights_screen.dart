import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/theme/app_theme.dart';
import '../../../controllers/booking_controller.dart';

class MyFlightsScreen extends StatelessWidget {
  MyFlightsScreen({super.key});

  final BookingController controller = Get.find<BookingController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        ),
        title: const Text('My Flights'),
        elevation: 0,
        backgroundColor: AppTheme.white,
      ),
      body: Obx(() {
        final flights = controller.bookings.where((b) => b['type'] == 'Flight').toList();

        if (flights.isEmpty) {
          return const Center(
            child: Padding(
              padding: EdgeInsets.all(24),
              child: Text(
                'No flights booked yet.\nBook one from the Flights tab!',
                textAlign: TextAlign.center,
                style: TextStyle(color: AppTheme.grey, fontSize: 14),
              ),
            ),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.all(20),
          itemCount: flights.length,
          itemBuilder: (context, index) {
            final flight = flights[index];
            final status = flight['status'] as String;
            final color = status == 'Upcoming'
                ? Colors.blue
                : status == 'Completed'
                    ? Colors.green
                    : Colors.grey;

            // title is stored as "FromCity → ToCity"
            final parts = (flight['title'] as String).split(' → ');
            final fromCity = parts.isNotEmpty ? parts[0] : '';
            final toCity = parts.length > 1 ? parts[1] : '';

            return Container(
              margin: const EdgeInsets.only(bottom: 16),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppTheme.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 3))
                ],
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(flight['price'], style: const TextStyle(fontSize: 13, color: AppTheme.primary, fontWeight: FontWeight.bold)),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: color.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(status,
                            style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: color)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(fromCity,
                            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppTheme.dark)),
                      ),
                      const Icon(Icons.airplanemode_active, color: Color(0xFF007BFF), size: 24),
                      Expanded(
                        child: Text(toCity,
                            textAlign: TextAlign.end,
                            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppTheme.dark)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  const Divider(),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.calendar_today, size: 14, color: AppTheme.grey),
                      const SizedBox(width: 6),
                      Text(flight['date'], style: const TextStyle(fontSize: 13, color: AppTheme.grey)),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      }),
    );
  }
}