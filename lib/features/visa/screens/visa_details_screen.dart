import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/theme/app_theme.dart';
import '../../../routes/app_routes.dart';

class VisaDetailsScreen extends StatefulWidget {
  const VisaDetailsScreen({super.key});

  @override
  State<VisaDetailsScreen> createState() => _VisaDetailsScreenState();
}

class _VisaDetailsScreenState extends State<VisaDetailsScreen> {
  final _nameController = TextEditingController();
  final _passportController = TextEditingController();
  final _dobController = TextEditingController();
  bool _returnTicket = false;
  bool _hotelBooked = false;
  bool _bankStatement = false;

  @override
  void dispose() {
    _nameController.dispose();
    _passportController.dispose();
    _dobController.dispose();
    super.dispose();
  }

  void _applyNow(Map<String, dynamic> visa) {
    if (_nameController.text.isEmpty || _passportController.text.isEmpty) {
      Get.snackbar('Missing Info', 'Please fill in all required fields');
      return;
    }
    Get.toNamed(AppRoutes.bookingConfirmation, arguments: {
      ...visa,
      'applicant': _nameController.text,
      'passport': _passportController.text,
    });
  }

  @override
  Widget build(BuildContext context) {
    final visa = Get.arguments as Map<String, dynamic>;

    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        ),
        title: Text('${visa['country']} Visa'),
        elevation: 0,
        backgroundColor: AppTheme.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Visa summary
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: (visa['color'] as Color).withOpacity(0.1),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  Text(visa['emoji'],
                      style: const TextStyle(fontSize: 48)),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(visa['country'],
                            style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: AppTheme.dark)),
                        const SizedBox(height: 4),
                        Text('${visa['type']} · ${visa['duration']}',
                            style: const TextStyle(
                                fontSize: 13, color: AppTheme.grey)),
                        const SizedBox(height: 4),
                        Text('Processing: ${visa['processing']}',
                            style: const TextStyle(
                                fontSize: 13, color: AppTheme.grey)),
                      ],
                    ),
                  ),
                  Text(visa['price'],
                      style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.primary)),
                ],
              ),
            ),
            const SizedBox(height: 24),
            const Text('Requirements',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.dark)),
            const SizedBox(height: 12),
            Container(
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
                children: (visa['requirements'] as List<String>)
                    .map((req) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Row(
                            children: [
                              const Icon(Icons.check_circle,
                                  color: Colors.green, size: 18),
                              const SizedBox(width: 12),
                              Text(req,
                                  style: const TextStyle(
                                      fontSize: 14, color: AppTheme.dark)),
                            ],
                          ),
                        ))
                    .toList(),
              ),
            ),
            const SizedBox(height: 24),
            const Text('Applicant Details',
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
              controller: _dobController,
              decoration: InputDecoration(
                labelText: 'Date of Birth',
                prefixIcon: const Icon(Icons.cake_outlined),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12)),
                filled: true,
                fillColor: AppTheme.white,
              ),
            ),
            const SizedBox(height: 24),
            const Text('Documents Checklist',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.dark)),
            const SizedBox(height: 12),
            Container(
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
                children: [
                  CheckboxListTile(
                    title: const Text('Return Ticket'),
                    value: _returnTicket,
                    onChanged: (v) =>
                        setState(() => _returnTicket = v!),
                    activeColor: AppTheme.primary,
                  ),
                  const Divider(height: 1),
                  CheckboxListTile(
                    title: const Text('Hotel Booking'),
                    value: _hotelBooked,
                    onChanged: (v) =>
                        setState(() => _hotelBooked = v!),
                    activeColor: AppTheme.primary,
                  ),
                  const Divider(height: 1),
                  CheckboxListTile(
                    title: const Text('Bank Statement'),
                    value: _bankStatement,
                    onChanged: (v) =>
                        setState(() => _bankStatement = v!),
                    activeColor: AppTheme.primary,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () => _applyNow(visa),
              child: const Text('Submit Application',
                  style: TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold)),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}