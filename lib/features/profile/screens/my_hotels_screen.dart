import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/theme/app_theme.dart';
import '../../../controllers/booking_controller.dart';

class MyHotelsScreen extends StatelessWidget {
  MyHotelsScreen({super.key});

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
        title: const Text('My Hotels'),
        elevation: 0,
        backgroundColor: AppTheme.white,
      ),
      body: Obx(() {
        final hotels = controller.bookings.where((b) => b['type'] == 'Hotel').toList();

        if (hotels.isEmpty) {
          return const Center(
            child: Padding(
              padding: EdgeInsets.all(24),
              child: Text(
                'No hotels booked yet.\nBook one from the Hotels tab!',
                textAlign: TextAlign.center,
                style: TextStyle(color: AppTheme.grey, fontSize: 14),
              ),
            ),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.all(20),
          itemCount: hotels.length,
          itemBuilder: (context, index) {
            final hotel = hotels[index];
            final status = hotel['status'] as String;
            final isConfirmed = status == 'Upcoming';
            final color = status == 'Upcoming'
                ? Colors.green
                : status == 'Completed'
                    ? Colors.blue
                    : Colors.grey;

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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(hotel['emoji'], style: const TextStyle(fontSize: 20)),
                          const SizedBox(width: 8),
                          Text(hotel['title'],
                              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppTheme.dark)),
                        ],
                      ),
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
                  const SizedBox(height: 12),
                  const Divider(),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Booking Date', style: TextStyle(fontSize: 11, color: AppTheme.grey)),
                          const SizedBox(height: 2),
                          Text(hotel['date'],
                              style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: AppTheme.dark)),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                        decoration: BoxDecoration(
                          color: const Color(0xFF00C896).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(hotel['price'],
                            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xFF00C896))),
                      ),
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