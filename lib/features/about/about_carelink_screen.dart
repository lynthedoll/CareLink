import 'package:flutter/material.dart';

class AboutCareLinkScreen extends StatelessWidget {
  const AboutCareLinkScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      appBar: AppBar(
        backgroundColor: const Color(0xFFDCD6F7),
        title: const Text('About CareLink', style: TextStyle(color: Colors.black87)),
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 0,
      ),
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFE7E4FB), Color(0xFFFFF4E5)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'Welcome to CareLink!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12),
            Text(
              'CareLink is a telemedicine platform designed by students at Howard University to better serve rural and underserved communities by offering:'
            ),
            SizedBox(height: 16),
            Text('• Prescription tracking'),
            Text('• Appointment scheduling'),
            Text('• Health goal monitoring'),
            Text('• Streamlined intake and feedback forms'),
            SizedBox(height: 24),
            Text(
              'Created by:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text('• Jamiliah Eubanks'),
            Text('• Caitlyn Lynch'),
            Text('• Rabia Mamo'),
            Text('• Kristian Morgan'),
            SizedBox(height: 24),
            Center(child: Text('Howard University - College of Engineering and Architecture')),
          ],
        ),
      ),
    );
  }
}
