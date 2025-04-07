import 'package:flutter/material.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          'Privacy Policy',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'CareLink Privacy Policy (Demo)',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFFB388EB), // soft lavender
              ),
            ),
            SizedBox(height: 16),
            Expanded(
              child: SingleChildScrollView(
                child: Text(
                  'Welcome to CareLink! This privacy policy mockup outlines how we would handle and protect your information in a real application.\n\n'
                  'DATA COLLECTION\n'
                  'CareLink may collect basic health and profile information to enhance your care experience. This can include appointment preferences, contact info, and feedback.\n\n'
                  'USAGE\n'
                  'Your data would be used to personalize your experience, match you with providers, send reminders, and improve the app based on feedback.\n\n'
                  'SECURITY\n'
                  'Your data would be encrypted and stored securely. We would never sell or share your information without your consent.\n\n'
                  'YOUR CHOICES\n'
                  'You could opt out of marketing emails, change preferences anytime, and access or delete your data upon request.\n\n'
                  'DISCLAIMER\n'
                  'This is a demonstration screen. No actual data is collected, shared, or stored through this survey or app in its current form.\n\n'
                  'Thank you for being part of the CareLink experience!',
                  style: TextStyle(fontSize: 15, height: 1.6),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
