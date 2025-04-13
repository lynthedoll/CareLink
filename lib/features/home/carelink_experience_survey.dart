import 'package:flutter/material.dart';
import '../../widgets/navigation_bar.dart';
import '../../navigation/main_screen_wrapper.dart';

class CarelinkExperienceSurvey extends StatefulWidget {
  const CarelinkExperienceSurvey({super.key});

  @override
  State<CarelinkExperienceSurvey> createState() => _CarelinkExperienceSurveyState();
}

class _CarelinkExperienceSurveyState extends State<CarelinkExperienceSurvey> {
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
      backgroundColor: const Color(0xFFF9F9F9),
      appBar: AppBar(
        leading: BackButton(color: Colors.black),
        backgroundColor: const Color(0xFFE4D7FF),
        elevation: 0,
        title: const Text(
          'CareLink Experience Survey',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            const Text(
              'Thank you for choosing CareLink! This short survey helps us understand how we can improve your experience using the app. Your responses are anonymous and will only be used to enhance the CareLink platform.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 24),
            buildQuestion(1, 'How satisfied are you with the overall usability of the CareLink app?', ['Satisfied', 'Neutral', 'Unsatisfied']),
            buildQuestion(2, 'How easy was it to navigate through the app?', ['Easy', 'Neutral', 'Difficult']),
            buildQuestion(3, 'Did the app features support your needs?', ['Yes', 'Somewhat', 'No']),
            buildQuestion(4, 'How would you rate the app’s performance (speed, loading time, etc.)?', ['Great', 'Okay', 'Poor']),
            buildQuestion(5, 'Would you recommend CareLink to someone else?', ['Yes', 'Maybe', 'No']),
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
      bottomNavigationBar: CustomNavigationBar(
        selectedIndex: 0,
        onTabSelected: (int index) {
          if (index == 0 || index == 3) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => MainScreenWrapper(initialTab: index)),
            );
          }
        },
      ),
    );
  }
}
