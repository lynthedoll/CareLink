import 'package:flutter/material.dart';

class MessagesScreen extends StatelessWidget {
  final Map<String, String> doctorData;

  const MessagesScreen({super.key, required this.doctorData});

  @override
  Widget build(BuildContext context) {
    final String doctorName = doctorData['name'] ?? '';
    final bool isVali = doctorName == 'Dr. Asha Vali';

    return Scaffold(
      appBar: AppBar(
        title: Text(doctorName, style: const TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 1,
        iconTheme: const IconThemeData(color: Colors.black),
        actions: [
          IconButton(
            icon: const Icon(Icons.call),
            onPressed: () {
              Navigator.pushNamed(
                context,
                '/audio-call',
                arguments: doctorData,
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.videocam),
            onPressed: () {
              Navigator.pushNamed(
                context,
                '/video-call',
                arguments: doctorData,
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: isVali
                  ? const [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Hi Jamiliah! I look forward to seeing you for our appointment on May 28. Did you get a chance to complete your intake form yet?",
                        ),
                      ),
                      SizedBox(height: 12),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text("Hi Dr. Vali! Not yet.. but I will get it done ASAP. :)"),
                      ),
                    ]
                  : [
                      Text('Say hi to $doctorName and introduce yourself! 👋'),
                    ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.emoji_emotions_outlined),
                  onPressed: () {
                    // future emoji/sticker support
                  },
                ),
                Expanded(
                  child: TextField(
                    decoration: const InputDecoration(
                      hintText: 'Type a message...',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () {
                    // sending message logic
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
