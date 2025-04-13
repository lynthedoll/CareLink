import 'package:flutter/material.dart';

class AudioCallScreen extends StatelessWidget {
  const AudioCallScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple.shade50,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.call, size: 80, color: Colors.deepPurple),
            SizedBox(height: 20),
            Text("Connecting audio call...", style: TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}
