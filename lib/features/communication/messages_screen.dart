import 'package:flutter/material.dart';
import 'audio_call_screen.dart';
import 'video_call_screen.dart';

class MessagesScreen extends StatefulWidget {
  final String doctorName;
  final String doctorImagePath;
  final List<Map<String, String>> chatHistory;

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
  final TextEditingController _messageController = TextEditingController();
  late List<Map<String, String>> messages;

  @override
  void initState() {
    super.initState();
    messages = List<Map<String, String>>.from(widget.chatHistory);
  }

  void _sendMessage() {
    final text = _messageController.text.trim();
    if (text.isNotEmpty) {
      final now = DateTime.now();
      final timestamp =
          "${now.hour % 12 == 0 ? 12 : now.hour % 12}:${now.minute.toString().padLeft(2, '0')} ${now.hour >= 12 ? 'PM' : 'AM'}";

      setState(() {
        messages.add({
          'sender': 'user',
          'text': text,
          'timestamp': timestamp,
        });
      });

      _messageController.clear();
    }
  }

  Widget _buildMessageBubble(Map<String, String> message, bool isLastUserMessage) {
    final isUser = message['sender'] == 'user';
    final alignment =
        isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start;
    final bgColor = isUser ? const Color(0xFFD6E8FA) : const Color(0xFFE6DBFF);
    final radius = BorderRadius.only(
      topLeft: const Radius.circular(16),
      topRight: const Radius.circular(16),
      bottomLeft: isUser ? const Radius.circular(16) : const Radius.circular(0),
      bottomRight: isUser ? const Radius.circular(0) : const Radius.circular(16),
    );

    return Column(
      crossAxisAlignment: alignment,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: radius,
          ),
          child: Text(
            message['text'] ?? '',
            style: const TextStyle(fontSize: 15),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 12, right: 12, bottom: 8),
          child: Column(
            crossAxisAlignment: alignment,
            children: [
              Text(
                message['timestamp'] ?? '',
                style: const TextStyle(fontSize: 11, color: Colors.grey),
              ),
              if (isUser && isLastUserMessage)
                const Text(
                  'Delivered',
                  style: TextStyle(fontSize: 11, color: Colors.grey),
                ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final lastUserIndex = messages.lastIndexWhere((msg) => msg['sender'] == 'user');

    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      appBar: AppBar(
        backgroundColor: const Color(0xFFE4D7FF),
        elevation: 0,
        title: Row(
          children: [
            CircleAvatar(
              backgroundImage: AssetImage(widget.doctorImagePath),
              radius: 18,
            ),
            const SizedBox(width: 10),
            Text(widget.doctorName),
          ],
        ),
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
              padding: const EdgeInsets.symmetric(vertical: 10),
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final msg = messages[index];
                return _buildMessageBubble(msg, index == lastUserIndex);
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: const BoxDecoration(color: Colors.white),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      hintText: 'Type a message...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24),
                        borderSide: BorderSide.none,
                      ),
                      fillColor: const Color(0xFFF0F0F0),
                      filled: true,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  icon: const Icon(Icons.send, color: Color(0xFF8C7AE6)),
                  onPressed: _sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
