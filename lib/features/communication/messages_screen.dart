import 'package:flutter/material.dart';

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
  late List<Map<String, String>> messages;
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    messages = List<Map<String, String>>.from(widget.chatHistory);
  }

  void _sendMessage(String text) {
    if (text.trim().isEmpty) return;

    final timestamp = _formatTimestamp(DateTime.now());

    setState(() {
      messages.add({
        'sender': 'user',
        'text': text,
        'timestamp': timestamp,
      });
    });

    _controller.clear();
  }

  String _formatTimestamp(DateTime dateTime) {
    final hour = dateTime.hour > 12 ? dateTime.hour - 12 : dateTime.hour;
    final ampm = dateTime.hour >= 12 ? 'PM' : 'AM';
    final minute = dateTime.minute.toString().padLeft(2, '0');
    return '${dateTime.month}/${dateTime.day}/${dateTime.year} $hour:$minute $ampm';
  }

  Widget _buildBubble(Map<String, String> message) {
    final isUser = message['sender'] == 'user';
    final alignment = isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start;
    final bubbleColor = isUser ? const Color(0xFFB388EB) : const Color(0xFFE0E0E0);
    final textColor = isUser ? Colors.white : Colors.black87;

    return Column(
      crossAxisAlignment: alignment,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 4),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          decoration: BoxDecoration(
            color: bubbleColor,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Text(
            message['text'] ?? '',
            style: TextStyle(color: textColor),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Text(
            '${message['timestamp']} • Delivered',
            style: const TextStyle(fontSize: 10, color: Colors.grey),
          ),
        ),
      ],
    );
  }

  void _endChatAndReturn() {
    Navigator.pop(context, messages);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        _endChatAndReturn();
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFFE4D7FF),
          title: Row(
            children: [
              CircleAvatar(backgroundImage: AssetImage(widget.doctorImagePath)),
              const SizedBox(width: 8),
              Text(widget.doctorName),
            ],
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.phone),
              onPressed: () {
                Navigator.pushNamed(context, '/audio-call');
              },
            ),
            IconButton(
              icon: const Icon(Icons.videocam),
              onPressed: () {
                Navigator.pushNamed(context, '/video-call');
              },
            ),
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  return _buildBubble(messages[index]);
                },
              ),
            ),
            const Divider(height: 1),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      decoration: const InputDecoration(
                        hintText: 'Type a message...',
                        filled: true,
                        fillColor: Color(0xFFF1F1F1),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: EdgeInsets.symmetric(horizontal: 16),
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
      ),
    );
  }
}
