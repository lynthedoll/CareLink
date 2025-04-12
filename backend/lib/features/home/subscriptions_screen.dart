import 'package:flutter/material.dart';
import '../../widgets/navigation_bar.dart';
import '../../navigation/main_screen_wrapper.dart';

class SubscriptionsScreen extends StatelessWidget {
  const SubscriptionsScreen({super.key});

  final List<Map<String, dynamic>> categories = const [
    {
      'title': 'Cold & Flu Relief',
      'description': 'Support your body during seasonal colds and flus.',
      'tips': [
        'Wash hands frequently with soap for at least 20 seconds.',
        'Avoid touching your face, especially the eyes, nose, and mouth.',
        'Get your annual flu vaccine and stay up to date with boosters.',
        'Sanitize commonly touched surfaces at home and work.',
        'Wear a mask in crowded indoor spaces during peak season.',
        'Stay well-hydrated with warm fluids (water, tea, broths).',
        'Use OTC medications like antihistamines and decongestants.',
        'Get plenty of rest — your body heals best during sleep.',
        'Use a humidifier to relieve congestion and throat irritation.',
        'See a provider if you have a high fever, chest pain, or worsening symptoms.',
        'Start a virtual visit to prevent complications like pneumonia.'
      ],
    },
    {
      'title': 'Immune Support',
      'description': 'Boost your immune system naturally.',
      'tips': [
        'Eat antioxidant-rich foods like berries, spinach, and citrus.',
        'Incorporate lean protein and healthy fats to fuel immune cells.',
        'Stay active — moderate exercise supports immune regulation.',
        'Manage stress, which can weaken immune defenses.',
        'Include vitamin C, D, zinc, and probiotics in your routine.',
        'Talk to a provider if you experience frequent colds or fatigue.',
        'Explore personalized nutrition plans via CareLink.'
      ],
    },
    {
      'title': 'Sleep Health',
      'description': 'Improve your sleep quality and restfulness.',
      'tips': [
        'Stick to a consistent bedtime and wake-up schedule.',
        'Create a calming pre-bedtime routine (reading, stretching, etc).',
        'Keep your bedroom cool, dark, and distraction-free.',
        'Avoid late-night meals, caffeine after 2 PM, and alcohol before bed.',
        'Identify sleep disruptors like anxiety or blue light from screens.',
        'Explore behavioral therapy for insomnia if needed.',
        'Consider melatonin or herbal supplements.',
        'Request a sleep study for chronic issues through CareLink.'
      ],
    },
    {
      'title': 'Gut Health',
      'description': 'Nurture your digestive system for overall health.',
      'tips': [
        'Eat fiber-rich foods like oats, beans, and leafy greens.',
        'Limit processed foods, added sugar, and alcohol.',
        'Stay hydrated to support digestion.',
        'Chew slowly and mindfully to reduce bloating.',
        'Include probiotics (yogurt, kimchi, kefir) in your diet.',
        'Eat prebiotic foods like bananas, garlic, and onions.',
        'Consider digestive enzymes (pineapple, papaya, supplements).',
        'See a provider if you experience food sensitivities or reflux.'
      ],
    },
    {
      'title': 'Stress Management',
      'description': 'Balance your mind and body with daily practices.',
      'tips': [
        'Practice deep breathing or guided meditation daily.',
        'Keep a journal for 5–10 minutes a day.',
        'Take movement breaks or short walks throughout your day.',
        'Listen to calming music or nature sounds.',
        'Explore long-term support like therapy or MBSR.',
        'Improve sleep and nutrition to reduce irritability.',
        'Watch for signs like headaches, fatigue, or poor focus.',
        'Book a virtual session through CareLink for support.'
      ],
    },
    {
      'title': 'Hydration',
      'description': 'Maintain optimal fluid balance.',
      'tips': [
        'Drink 6–8 glasses of water daily; more if you’re active.',
        'Eat hydrating foods like watermelon, cucumber, and oranges.',
        'Add electrolytes after workouts or illness.',
        'Use a refillable water bottle to monitor intake.',
        'Watch for signs of dehydration like dark urine or dry skin.',
        'Track water intake in-app using CareLink tools.',
        'Consult a provider for chronic hydration concerns.'
      ],
    },
    {
      'title': 'Energy Support',
      'description': 'Increase stamina and reduce fatigue.',
      'tips': [
        'Eat balanced meals with protein, fiber, and healthy fats.',
        'Get daily sunlight exposure in the morning.',
        'Incorporate light physical activity or stretch breaks.',
        'Limit screen time and take digital breaks during work.',
        'Investigate causes of fatigue like sleep apnea or low B12.',
        'Manage stress and mental health challenges.',
        'Use CareLink’s fatigue tracker and schedule a consult.'
      ],
    },
    {
      'title': 'Skin Health',
      'description': 'Glow from the inside out.',
      'tips': [
        'Cleanse gently twice daily.',
        'Moisturize and apply SPF every morning.',
        'Stay hydrated and eat foods rich in omega-3s and antioxidants.',
        'Avoid touching or picking your skin.',
        'Watch for signs like breakouts, hyperpigmentation, or eczema.',
        'Upload a photo or consult with a CareLink dermatologist.'
      ],
    },
    {
      'title': 'Heart Health',
      'description': 'Support cardiovascular wellness.',
      'tips': [
        'Limit saturated fats, sodium, and added sugars.',
        'Eat leafy greens, berries, and omega-3-rich foods.',
        'Exercise for at least 30 minutes most days.',
        'Track your blood pressure and cholesterol regularly.',
        'Watch for symptoms like chest pain or shortness of breath.',
        'Use CareLink for virtual heart screenings and prevention planning.'
      ],
    },
    {
      'title': 'Joint & Bone Support',
      'description': 'Maintain strength and flexibility.',
      'tips': [
        'Do low-impact exercises like walking, yoga, or swimming.',
        'Maintain a healthy weight to reduce joint strain.',
        'Eat foods rich in calcium and vitamin D.',
        'Stretch daily and warm up before any physical activity.',
        'Watch for early signs like stiffness, popping, or limited motion.',
        'Consult CareLink for pain relief or mobility screening.'
      ],
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      appBar: AppBar(
        title: const Text('My Subscriptions'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: BackButton(
          onPressed: () => Navigator.pop(context),
          color: Colors.black,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Find the subscription that’s best for you... click on a category for more details.',
              style: TextStyle(fontSize: 14, fontStyle: FontStyle.italic),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  final category = categories[index];
                  return Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [Color(0xFFFDF1FF), Color(0xFFD4C6F8)],
                      ),
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.14),
                          blurRadius: 12,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    child: ListTile(
                      title: Text(category['title']),
                      subtitle: Text(category['description']),
                      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          '/subscription-detail',
                          arguments: category,
                        );
                      },
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 12),
            const Center(
              child: Text(
                'Stay tuned — more wellness categories and features coming soon!',
                style: TextStyle(fontSize: 13, fontStyle: FontStyle.italic),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomNavigationBar(
        selectedIndex: 0,
        onTabSelected: (int index) {},
      ),
    );
  }
}
