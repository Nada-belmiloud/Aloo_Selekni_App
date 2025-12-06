import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl, // Force RTL for Arabic
      child: Scaffold(
        backgroundColor: const Color(0xFFF5F5F5),
        appBar: AppBar(
          title: const Text('الإعدادات'),
          backgroundColor: const Color(0xFF4A8BB3),
          elevation: 0,
          centerTitle: true,
        ),
        body: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            // Language
            ListTile(
              leading: const Icon(Icons.language, color: Colors.blue),
              title: const Text('اللغة'),
              trailing: const Icon(Icons.arrow_back_ios, size: 16), // RTL arrow
              onTap: () {
                // TODO: Open language selection dialog
              },
            ),
            const Divider(),

            // Notifications
            ListTile(
              leading: const Icon(Icons.notifications, color: Colors.orange),
              title: const Text('الإشعارات'),
              trailing: Switch(
                value: true,
                onChanged: (value) {
                  // TODO: Handle notification toggle
                },
              ),
            ),
            const Divider(),

            // Account
            ListTile(
              leading: const Icon(Icons.person, color: Colors.green),
              title: const Text('الحساب'),
              trailing: const Icon(Icons.arrow_back_ios, size: 16),
              onTap: () {
                // TODO: Navigate to account settings
              },
            ),
            const Divider(),

            // Privacy
            ListTile(
              leading: const Icon(Icons.lock, color: Colors.red),
              title: const Text('الخصوصية'),
              trailing: const Icon(Icons.arrow_back_ios, size: 16),
              onTap: () {
                // TODO: Navigate to privacy settings
              },
            ),
          ],
        ),
      ),
    );
  }
}
