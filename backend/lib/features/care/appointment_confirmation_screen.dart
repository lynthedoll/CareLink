import 'package:flutter/material.dart';
import '../../navigation/main_screen_wrapper.dart';


class AppointmentConfirmationScreen extends StatelessWidget {
  const AppointmentConfirmationScreen({super.key});

  String _formatDate(DateTime date) {
    return '${date.month}/${date.day}/${date.year}';
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map;

    final date = args['date'] as DateTime;
    final time = args['time'];
    final doctor = args['doctor'];
    final specialty = args['specialty'];
    final image = args['image'];
    final fullName = args['fullName'];
    final age = args['age'];
    final gender = args['gender'];
    final reason = args['reason'];

    // Fake "add to notification" - simulate in-memory for now
    final notificationMessage =
        'Appointment confirmed with $doctor ($specialty) on ${_formatDate(date)} at $time.';

    // Optional: store to in-memory notification list if you create one

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFE4D7FF), Color(0xFFFFFFFF)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
        title: const Text('Appointment Confirmed'),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 10),
            CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage(image),
            ),
            const SizedBox(height: 20),

            const Text(
              'Your Appointment is Confirmed!',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),

            _buildInfoRow('Doctor', doctor),
            _buildInfoRow('Specialty', specialty),
            _buildInfoRow('Date', _formatDate(date)),
            _buildInfoRow('Time', time),
            const Divider(),
            _buildInfoRow('Name', fullName),
            _buildInfoRow('Age', age),
            _buildInfoRow('Gender', gender),
            _buildInfoRow('Reason', reason),
            const SizedBox(height: 30),

            ElevatedButton.icon(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const MainScreenWrapper(initialTab: 3),
                  ),
                  (route) => false,
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              icon: const Icon(Icons.check_circle, color: Colors.white),
              label: const Text(
                'Return to Care Tab',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Text(
            '$label: ',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: Text(value),
          ),
        ],
      ),
    );
  }
}
