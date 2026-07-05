import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/theme/app_theme.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  bool _obscureCurrent = true;
  bool _obscureNew = true;
  bool _obscureConfirm = true;

  final _currentController = TextEditingController();
  final _newController = TextEditingController();
  final _confirmController = TextEditingController();

  @override
  void dispose() {
    _currentController.dispose();
    _newController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  void _changePassword() {
    if (_currentController.text.isEmpty ||
        _newController.text.isEmpty ||
        _confirmController.text.isEmpty) {
      Get.snackbar('Missing fields', 'Please fill in all fields');
      return;
    }
    if (_newController.text != _confirmController.text) {
      Get.snackbar('Mismatch', 'New passwords do not match');
      return;
    }
    if (_newController.text.length < 6) {
      Get.snackbar('Too short', 'Password must be at least 6 characters');
      return;
    }
    // TODO: replace with real change-password API call
    Get.snackbar('Success', 'Your password has been changed',
        duration: const Duration(seconds: 2));
    Future.delayed(const Duration(seconds: 2), () => Get.back());
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
        title: const Text('Change Password'),
        elevation: 0,
        backgroundColor: AppTheme.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),
            const Text(
              'Keep your account secure by using a strong password',
              style: TextStyle(fontSize: 14, color: AppTheme.grey),
            ),
            const SizedBox(height: 32),
            _buildPasswordField('Current Password', _currentController,
                _obscureCurrent, () {
              setState(() => _obscureCurrent = !_obscureCurrent);
            }),
            const SizedBox(height: 16),
            _buildPasswordField('New Password', _newController, _obscureNew,
                () {
              setState(() => _obscureNew = !_obscureNew);
            }),
            const SizedBox(height: 16),
            _buildPasswordField(
                'Confirm New Password', _confirmController, _obscureConfirm,
                () {
              setState(() => _obscureConfirm = !_obscureConfirm);
            }),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: _changePassword,
              child: const Text(
                'Update Password',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPasswordField(String label, TextEditingController controller,
      bool obscure, VoidCallback onToggle) {
    return TextField(
      controller: controller,
      obscureText: obscure,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: const Icon(Icons.lock_outline),
        suffixIcon: IconButton(
          icon: Icon(obscure ? Icons.visibility_off : Icons.visibility),
          onPressed: onToggle,
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        filled: true,
        fillColor: AppTheme.white,
      ),
    );
  }
}