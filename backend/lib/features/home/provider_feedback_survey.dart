import 'package:flutter/material.dart';

class ProviderFeedbackSurvey extends StatefulWidget {
  const ProviderFeedbackSurvey({super.key});

  @override
  State<ProviderFeedbackSurvey> createState() => _ProviderFeedbackSurveyState();
}

class _ProviderFeedbackSurveyState extends State<ProviderFeedbackSurvey> {
  bool submitted = false;
  final Map<int, String> responses = {};

  void handleSubmit() {
    setState(() {
      submitted = true;
    });

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Thank you!'),
        content: const Text('Your responses have been recorded.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  Widget buildQuestion(int number, String question, List<String> options) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$number. $question',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        for (final option in options)
          RadioListTile<String>(
            title: Text(option),
            value: option,
            groupValue: responses[number],
            onChanged: submitted
                ? null
                : (value) {
                    setState(() {
                      responses[number] = value!;
                    });
                  },
          ),
        const SizedBox(height: 16),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(color: Colors.black),
        backgroundColor: const Color(0xFFE7E4FB),
        elevation: 0,
        title: const Text(
          'Provider Feedback Survey',
          style: TextStyle(color: Colors.black),
        ),
      ),
      backgroundColor: const Color(0xFFF9F9F9),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            const Text(
              'Thank you for taking a moment to share your feedback. This survey helps us ensure high-quality care through CareLink providers. Your answers are completely confidential and help us improve patient-provider interactions.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 24),
            buildQuestion(1, 'How satisfied were you with your provider’s care?', ['Satisfied', 'Neutral', 'Unsatisfied']),
            buildQuestion(2, 'Did your provider listen to your concerns and explain things clearly?', ['Yes', 'Somewhat', 'No']),
            buildQuestion(3, 'How would you rate the quality of the video call?', ['Good', 'Average', 'Poor']),
            buildQuestion(4, 'Would you want to meet with this provider again?', ['Yes', 'Maybe', 'No']),
            ElevatedButton(
              onPressed: submitted ? null : handleSubmit,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFE8F0FE),
                minimumSize: const Size(double.infinity, 48),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: const Text(
                'Submit',
                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
