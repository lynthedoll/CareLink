import 'package:flutter/material.dart';

// In-memory list for notifications and read status
List<String> notifications = [
  'Appointment with Dr. Asha Vali (Internal Medicine) on 05/28/2025 at 9:00AM'
];
bool notificationsViewed = false;

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Mark notifications as read
    notificationsViewed = true;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        backgroundColor: Colors.deepPurpleAccent,
      ),
      body: notifications.isEmpty
          ? const Center(child: Text('No notifications available.'))
          : ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: notifications.length,
              separatorBuilder: (_, __) => const Divider(),
              itemBuilder: (context, index) {
                return ListTile(
                  leading: const Icon(Icons.notifications),
                  title: Text(notifications[index]),
                );
              },
            ),
    );
  }
}
