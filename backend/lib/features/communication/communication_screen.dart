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
  final List<String> selectedConversations = [];
  bool isEditMode = false;

  final List<Map<String, String>> _availableDoctors = [
    {
      "name": "Dr. Linda Thompson",
      "specialty": "Family Medicine",
      "image": "assets/icons/dr_thompson.png"
    },
    {
      "name": "Dr. Asha Vali",
      "specialty": "Internal Medicine",
      "image": "assets/icons/dr_vali.png"
    },
    {
      "name": "Dr. Raj Patel",
      "specialty": "Radiologist",
      "image": "assets/icons/dr_patel.png"
    },
    {
      "name": "Dr. Elena Martinez",
      "specialty": "Cardiologist",
      "image": "assets/icons/dr_martinez.png"
    },
    {
      "name": "Dr. Michael Anderson",
      "specialty": "Pediatrician",
      "image": "assets/icons/dr_anderson.png"
    },
    {
      "name": "Dr. Jamal Yusuf",
      "specialty": "Oncologists",
      "image": "assets/icons/dr_yusuf.png"
    },
  ];

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

  void _openDoctorPicker() {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return ListView(
          padding: const EdgeInsets.all(16),
          children: _availableDoctors.map((doctor) {
            return ListTile(
              leading: CircleAvatar(backgroundImage: AssetImage(doctor['image']!)),
              title: Text(doctor['name']!),
              subtitle: Text(doctor['specialty']!),
              onTap: () {
                Navigator.pop(context);
                final alreadyExists =
                    conversations.any((c) => c['name'] == doctor['name']);
                if (!alreadyExists) {
                  setState(() {
                    conversations.insert(0, {
                      'name': doctor['name']!,
                      'image': doctor['image']!,
                      'lastMessage': 'Say hi to ${doctor['name']} and introduce yourself!',
                      'date': '',
                    });
                  });
                }

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => MessagesScreen(doctorData: doctor),
                  ),
                );
              },
            );
          }).toList(),
        );
      },
    );
  }

  void _toggleEditMode() {
    setState(() {
      isEditMode = !isEditMode;
      selectedConversations.clear();
    });
  }

  void _handleSelection(String name, bool selected) {
    setState(() {
      if (selected) {
        selectedConversations.add(name);
      } else {
        selectedConversations.remove(name);
      }
    });
  }

  void _deleteSelectedConversations() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Delete Conversations'),
        content: const Text('Are you sure you want to delete the selected conversation(s)?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                conversations.removeWhere(
                  (convo) => selectedConversations.contains(convo['name']),
                );
                selectedConversations.clear();
                isEditMode = false;
              });
              Navigator.pop(context);
            },
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFF9F9F9),
        elevation: 0,
        leading: IconButton(
          icon: Icon(isEditMode ? Icons.close : Icons.edit, color: Colors.black),
          onPressed: _toggleEditMode,
        ),
        title: const Text(
          'Messages',
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          if (isEditMode && selectedConversations.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: _deleteSelectedConversations,
            ),
          if (!isEditMode)
            IconButton(
              icon: const Icon(Icons.person_add_alt_1, color: Colors.black),
              onPressed: _openDoctorPicker,
            ),
        ],
      ),
      body: ListView.builder(
        itemCount: conversations.length,
        itemBuilder: (context, index) {
          final convo = conversations[index];
          final isSelected = selectedConversations.contains(convo['name']);

          return ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage(convo['image']!),
              radius: 28,
            ),
            title: Text(
              convo['name']!,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(convo['lastMessage']!),
            trailing: isEditMode
                ? Checkbox(
                    value: isSelected,
                    onChanged: (bool? value) {
                      _handleSelection(convo['name']!, value ?? false);
                    },
                  )
                : Text(convo['date']!),
            onTap: isEditMode
                ? () {
                    _handleSelection(convo['name']!, !isSelected);
                  }
                : () {
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
