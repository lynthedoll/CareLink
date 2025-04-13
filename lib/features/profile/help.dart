import 'package:flutter/material.dart';
import '../../widgets/navigation_bar.dart';
import '../../navigation/main_screen_wrapper.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      appBar: AppBar(
        title: const Text(
          'Help',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: const Color(0xFFE4D7FF),
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: const [
            Text(
              "How can we help you?",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xFF9A6AFF),
              ),
            ),
            SizedBox(height: 16),
            Text(
              "• How to use the CareLink app\n"
              "• Resetting your password\n"
              "• Troubleshooting login issues\n"
              "• Understanding your appointment schedule\n"
              "• How to complete your intake form\n"
              "• Contacting technical support\n"
              "• General FAQs",
              style: TextStyle(fontSize: 16, height: 1.6),
            ),
            SizedBox(height: 24),
            Text(
              "This is a demo screen. For now, these help topics are not interactive, but in the future they will include full support articles or connect you with our support team.",
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomNavigationBar(
        selectedIndex: 4,
        onTabSelected: (int index) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => MainScreenWrapper(initialTab: index)),
          );
        },
      ),
    );
  }
}
