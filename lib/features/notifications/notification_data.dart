// notification_data.dart

List<String> notifications = [
  'Appointment with Dr. Asha Vali (Internal Medicine) on May 28th, 2025 at 9:00AM'
];

bool notificationsViewed = false;

/// Call this to mark notifications as read
void markNotificationsAsViewed() {
  notificationsViewed = true;
}

void addNotification(String newMessage) {
  if (!notifications.contains(newMessage)) {
    notifications.add(newMessage);
    notificationsViewed = false;
  }
}

/// Returns whether the red badge should be shown
bool shouldShowNotificationBadge() {
  return !notificationsViewed && notifications.isNotEmpty;
}

Map<String, dynamic>? latestScheduledAppointment;

void updateLatestAppointment(Map<String, dynamic> newAppointment) {
  if (latestScheduledAppointment == null ||
      newAppointment['date'].isBefore(latestScheduledAppointment!['date'])) {
    latestScheduledAppointment = newAppointment;
  }
}

