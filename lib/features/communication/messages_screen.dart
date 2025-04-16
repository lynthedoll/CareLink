import 'package:flutter/material.dart';
import 'audio_call_screen.dart';
import 'video_call_screen.dart';

class MessagesScreen extends StatefulWidget {
  final String doctorName;
  final String doctorImagePath;
  final List<Map<String, dynamic>> chatHistory;

  const MessagesScreen({
    super.key,
    required this.doctorName,
    required this.doctorImagePath,
    required this.chatHistory,
  });

  @override
  State<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  final TextEditingController _controller = TextEditingController();
  List<Map<String, String>> messages = [];

  @override
  void initState() {
    super.initState();
    messages = List.from(widget.chatHistory);
  }

  void _sendMessage(String text) {
    if (text.trim().isEmpty) return;

    setState(() {
      messages.add({
        'sender': 'user',
        'text': text,
        'time': TimeOfDay.now().format(context),
      });
    });
    _controller.clear();
  }

  Widget _buildMessage(Map<String, String> msg) {
    final isUser = msg['sender'] == 'user';
    final alignment = isUser ? Alignment.centerRight : Alignment.centerLeft;
    final color = isUser ? Colors.purple[100] : Colors.blue[100];
    final textColor = Colors.black87;

    return Align(
      alignment: alignment,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment:
              isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Text(msg['text'] ?? '', style: TextStyle(color: textColor)),
            if (msg['time'] != null)
              Text(
                'Delivered • ${msg['time']}',
                style: const TextStyle(fontSize: 10, color: Colors.black54),
              ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            CircleAvatar(backgroundImage: AssetImage(widget.doctorImagePath)),
            const SizedBox(width: 10),
            Text(widget.doctorName),
          ],
        ),
        backgroundColor: const Color(0xFFE4D7FF),
        actions: [
          IconButton(
            icon: const Icon(Icons.call),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const AudioCallScreen()),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.videocam),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const VideoCallScreen()),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: messages.length,
              itemBuilder: (context, index) => _buildMessage(messages[index]),
            ),
          ),
          const Divider(height: 1),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      hintText: 'Type a message...',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () => _sendMessage(_controller.text),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
