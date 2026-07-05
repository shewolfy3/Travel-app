import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../../core/theme/app_theme.dart';
import '../../../routes/app_routes.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final _box = Hive.box('profile');

  late bool _darkMode;
  late bool _biometrics;
  late String _language;
  late String _currency;

  final List<String> _languages = ['English', 'Arabic', 'French', 'German'];
  final List<String> _currencies = ['USD', 'EUR', 'GBP', 'EGP'];

  @override
  void initState() {
    super.initState();
    _darkMode = _box.get('darkMode', defaultValue: false);
    _biometrics = _box.get('biometrics', defaultValue: false);
    _language = _box.get('language', defaultValue: 'English');
    _currency = _box.get('currency', defaultValue: 'USD');
  }

  void _save(String key, dynamic value) {
    _box.put(key, value);
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
        title: const Text('Settings'),
        elevation: 0,
        backgroundColor: AppTheme.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Appearance',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.dark)),
            const SizedBox(height: 12),
            _buildCard([
              _buildToggle(
                Icons.dark_mode_outlined,
                'Dark Mode',
                'Switch to dark theme',
                _darkMode,
                (v) {
                  setState(() => _darkMode = v);
                  _save('darkMode', v);
                },
              ),
            ]),
            const SizedBox(height: 24),
            const Text('Security',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.dark)),
            const SizedBox(height: 12),
            _buildCard([
              _buildToggle(
                Icons.fingerprint,
                'Biometric Login',
                'Use fingerprint or face ID',
                _biometrics,
                (v) {
                  setState(() => _biometrics = v);
                  _save('biometrics', v);
                },
              ),
              const Divider(height: 1),
              _buildTile(
                Icons.lock_outline,
                'Change Password',
                'Update your password',
                () => Get.toNamed(AppRoutes.changePassword),
              ),
            ]),
            const SizedBox(height: 24),
            const Text('Preferences',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.dark)),
            const SizedBox(height: 12),
            _buildCard([
              _buildDropdown(
                Icons.language,
                'Language',
                _language,
                _languages,
                (v) {
                  setState(() => _language = v!);
                  _save('language', v);
                },
              ),
              const Divider(height: 1),
              _buildDropdown(
                Icons.attach_money,
                'Currency',
                _currency,
                _currencies,
                (v) {
                  setState(() => _currency = v!);
                  _save('currency', v);
                },
              ),
            ]),
            const SizedBox(height: 24),
            const Text('Account',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.dark)),
            const SizedBox(height: 12),
            _buildCard([
              _buildTile(
                Icons.delete_outline,
                'Delete Account',
                'Permanently delete your account',
                () => Get.dialog(
                  AlertDialog(
                    title: const Text('Delete Account'),
                    content: const Text(
                        'Are you sure? This action cannot be undone.'),
                    actions: [
                      TextButton(
                        onPressed: () => Get.back(),
                        child: const Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () {
                          Get.back();
                          Get.offAllNamed(AppRoutes.login);
                        },
                        child: const Text('Delete',
                            style: TextStyle(color: Colors.red)),
                      ),
                    ],
                  ),
                ),
                color: Colors.red,
              ),
            ]),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildCard(List<Widget> children) {
    return Container(
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
      child: Column(children: children),
    );
  }

  Widget _buildToggle(IconData icon, String title, String subtitle,
      bool value, ValueChanged<bool> onChanged) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppTheme.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: AppTheme.primary, size: 20),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: AppTheme.dark)),
                Text(subtitle,
                    style: const TextStyle(
                        fontSize: 12, color: AppTheme.grey)),
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: AppTheme.primary,
          ),
        ],
      ),
    );
  }

  Widget _buildTile(IconData icon, String title, String subtitle,
      VoidCallback onTap,
      {Color color = AppTheme.dark}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: color, size: 20),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: color)),
                  Text(subtitle,
                      style: const TextStyle(
                          fontSize: 12, color: AppTheme.grey)),
                ],
              ),
            ),
            Icon(Icons.arrow_forward_ios, size: 14, color: AppTheme.grey),
          ],
        ),
      ),
    );
  }

  Widget _buildDropdown(IconData icon, String title, String value,
      List<String> options, ValueChanged<String?> onChanged) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppTheme.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: AppTheme.primary, size: 20),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Text(title,
                style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: AppTheme.dark)),
          ),
          DropdownButton<String>(
            value: value,
            underline: const SizedBox(),
            items: options
                .map((o) => DropdownMenuItem(value: o, child: Text(o)))
                .toList(),
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}