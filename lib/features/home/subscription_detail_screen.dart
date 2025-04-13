import 'package:flutter/material.dart';
import '../../shared/subscription_data.dart';
import '../../widgets/navigation_bar.dart';
import '../../navigation/main_screen_wrapper.dart';

class SubscriptionDetailScreen extends StatefulWidget {
  const SubscriptionDetailScreen({super.key});

  @override
  State<SubscriptionDetailScreen> createState() => _SubscriptionDetailScreenState();
}

class _SubscriptionDetailScreenState extends State<SubscriptionDetailScreen> {
  late String title;
  late String description;
  late List<String> tips;
  bool isSubscribed = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    title = args['title'];
    description = args['description'];
    tips = List<String>.from(args['tips']);
    isSubscribed = subscribedCategories.any((item) => item['title'] == title);
  }

  void _toggleSubscription() {
    setState(() {
      if (isSubscribed) {
        subscribedCategories.removeWhere((item) => item['title'] == title);
        isSubscribed = false;
      } else {
        subscribedCategories.add({
          'title': title,
          'description': description,
          'tips': tips,
        });
        isSubscribed = true;
      }
    });

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(isSubscribed ? "Subscription Confirmed" : "Unsubscribed"),
        content: Text(
          isSubscribed
              ? "You are now subscribed to $title articles! A shortcut has been added to your Home tab."
              : "You have unsubscribed from $title articles. It will be removed from your Home tab.",
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("OK"),
          )
        ],
      ),
    );
  }

  void _goBackToHome() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const MainScreenWrapper(initialTab: 0)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: BackButton(
          onPressed: () {
            Navigator.popUntil(context, ModalRoute.withName('/subscriptions'));
            Future.delayed(const Duration(milliseconds: 200), () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const MainScreenWrapper(initialTab: 0)),
              );
            });
          },
          color: Colors.black,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(description, style: const TextStyle(fontSize: 16)),
              const SizedBox(height: 20),
              const Text(
                'Wellness Tips:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              ...tips.map((tip) => Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Text("• $tip"),
                  )),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _toggleSubscription,
                style: ElevatedButton.styleFrom(
                  backgroundColor: isSubscribed ? const Color(0xFFF8BBD0) : const Color(0xFFE4D7FF),
                  minimumSize: const Size(double.infinity, 48),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: Text(
                  isSubscribed ? 'Unsubscribe' : 'Subscribe',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(height: 12),
            ],
          ),
        ),
      ),
      bottomNavigationBar: CustomNavigationBar(
        selectedIndex: 0,
        onTabSelected: (int index) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => MainScreenWrapper(initialTab: index)),
          );
        },
      ),
    );
  }
}
