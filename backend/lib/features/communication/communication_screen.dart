import 'package:flutter/material.dart';
import 'messages_screen.dart';
import '../notifications/notification_data.dart';


class CommunicationScreen extends StatefulWidget {
  const CommunicationScreen({super.key});

  @override
  State<CommunicationScreen> createState() => _CommunicationScreenState();
}

class _CommunicationScreenState extends State<CommunicationScreen> {
  List<Map<String, String>> conversations = [];

  @override
  void initState() {
    super.initState();
    _loadConversations();
  }

  void _loadConversations() {
    conversations = [
      {
        'name': 'Dr. Asha Vali',
        'image': 'assets/icons/dr_vali.png',
        'lastMessage': 'Hi Dr. Vali! Not yet.. but I will get it done ASAP. :)',
        'date': 'Mar 12, 2025',
      },
    ];

    if (latestScheduledAppointment != null &&
        latestScheduledAppointment!['doctor'] == 'Dr. Linda Thompson') {
      conversations.insert(0, {
        'name': 'Dr. Linda Thompson',
        'image': 'assets/icons/dr_thompson.png',
        'lastMessage': 'Say hi to Dr. Thompson and introduce yourself!',
        'date': '',
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFF9F9F9),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.edit, color: Colors.black),
          onPressed: () {
            // TODO: implement delete logic
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.person_add_alt_1, color: Colors.black),
            onPressed: () {
              // TODO: implement new conversation start
            },
          ),
        ],
        title: const Text(
          'Messages',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: ListView.builder(
        itemCount: conversations.length,
        itemBuilder: (context, index) {
          final convo = conversations[index];
          return ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage(convo['image']!),
              radius: 28,
            ),
            title: Text(convo['name']!,
                style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text(convo['lastMessage']!),
            trailing: Text(convo['date']!),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => MessagesScreen(doctorData: convo),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
