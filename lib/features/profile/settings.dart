import 'package:flutter/material.dart';
import '../../widgets/navigation_bar.dart';
import '../../navigation/main_screen_wrapper.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      appBar: AppBar(
        backgroundColor: const Color(0xFFDCD6F7), // soft lavender
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Settings',
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          ListTile(
            title: Text('Notification Preferences'),
            subtitle: Text('Manage push, email, and SMS alerts'),
            trailing: Icon(Icons.chevron_right),
          ),
          Divider(),
          ListTile(
            title: Text('Language'),
            subtitle: Text('Select your preferred language'),
            trailing: Icon(Icons.chevron_right),
          ),
          Divider(),
          ListTile(
            title: Text('Accessibility'),
            subtitle: Text('Customize font size, colors, etc.'),
            trailing: Icon(Icons.chevron_right),
          ),
          Divider(),
          ListTile(
            title: Text('Data Usage'),
            subtitle: Text('Control background data and permissions'),
            trailing: Icon(Icons.chevron_right),
          ),
          Divider(),
          ListTile(
            title: Text('App Version'),
            subtitle: Text('CareLink v1.0.0'),
          ),
        ],
      ),
      bottomNavigationBar: CustomNavigationBar(
        selectedIndex: 4,
        onTabSelected: (int index) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (_) => MainScreenWrapper(initialTab: index),
            ),
          );
        },
      ),
    );
  }
}
