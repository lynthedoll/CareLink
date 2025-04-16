import 'package:flutter/material.dart';
import '../../features/care/care_screen.dart';
import '../communication/messages_screen.dart';
import '../notifications/notification_data.dart';
import '../../shared/doctor_data.dart';
import 'package:intl/intl.dart'; 


class CommunicationScreen extends StatefulWidget {
  const CommunicationScreen({super.key});

  @override
  State<CommunicationScreen> createState() => _CommunicationScreenState();
}

class _CommunicationScreenState extends State<CommunicationScreen> {
  List<Map<String, dynamic>> conversations = [];

  @override
  void initState() {
    super.initState();
    _initializeConversations();
  }

  void _initializeConversations() {
    conversations = [
      {
        'name': 'Dr. Asha Vali',
        'message': 'Hi Jamiliah! I look forward to seeing you for our appointment on March 12. Did you get a chance to complete your intake form yet? It’s ready for you on the home tab.',
        'preview': 'Hi Dr. Vali! Not yet.. but I will get it done ASAP. :)',
        'image': 'assets/icons/dr_vali.png',
        'timestamp': 'Mar 12, 2025',
        'chat': [
          {'sender': 'doctor', 
          'text': 'Hi Jamiliah! I look forward to seeing you for our appointment on March 12. Did you get a chance to complete your intake form yet? It’s ready for you on the home tab.',
          'timestamp': 'Mar 9, 2025 11:37 AM'
          },
          {'sender': 'user', 
          'text': 'Hi Dr. Vali! Not yet.. but I will get it done ASAP. :)',
          'timestamp': 'Mar 9, 2025 12:06 PM'},
        ]
      },
    ];

    if (latestScheduledAppointment != null &&
        latestScheduledAppointment!['doctor'] == 'Dr. Linda Thompson') {
      conversations.insert(0, {
        'name': 'Dr. Linda Thompson',
        'message': '',
        'preview': 'Say hi to Dr. Thompson and let her know you’re ready to chat!',
        'image': 'assets/icons/dr_thompson.png',
        'timestamp': DateFormat('MMM d, yyyy • h:mm a').format(latestScheduledAppointment!['date']),
        'chat': [],
      });
    }
  }

  void _startConversation(Map<String, String> doctor) {
    setState(() {
      conversations.insert(0, {
        'name': doctor['name'],
        'message': '',
        'preview': 'Say hi to ${doctor['name']} to get started!',
        'image': doctor['image'],
        'timestamp': '',
        'chat': [],
      });
    });
  }

  void _deleteConversation(int index) {
    setState(() {
      conversations.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      appBar: AppBar(
        title: const Text('Communications'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder: (_) => ListView(
                  children: careDoctors.map((doc) {
                    return ListTile(
                      leading: CircleAvatar(backgroundImage: AssetImage(doc['image']!)),
                      title: Text(doc['name']!),
                      subtitle: Text(doc['specialty']!),
                      onTap: () {
                        Navigator.pop(context);
                        _startConversation(doc);
                      },
                    );
                  }).toList(),
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              if (conversations.isNotEmpty) {
                showModalBottomSheet(
                  context: context,
                  builder: (_) => ListView.builder(
                    itemCount: conversations.length,
                    itemBuilder: (context, index) {
                      final convo = conversations[index];
                      return ListTile(
                        leading: CircleAvatar(backgroundImage: AssetImage(convo['image'])),
                        title: Text(convo['name']),
                        subtitle: Text(convo['preview']),
                        trailing: const Icon(Icons.delete),
                        onTap: () => _deleteConversation(index),
                      );
                    },
                  ),
                );
              }
            },
          ),
        ],
        backgroundColor: const Color(0xFFE4D7FF),
      ),
      body: ListView.builder(
        itemCount: conversations.length,
        itemBuilder: (context, index) {
          final convo = conversations[index];
          return ListTile(
            leading: CircleAvatar(backgroundImage: AssetImage(convo['image'])),
            title: Text(convo['name']),
            subtitle: Text(convo['preview']),
            trailing: Text(convo['timestamp']?.toString() ?? ''),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => MessagesScreen(
                    doctorName: convo['name'],
                    doctorImagePath: convo['image'],
                    chatHistory: List<Map<String, dynamic>>.from(convo['chat']),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
