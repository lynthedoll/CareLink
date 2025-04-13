import 'package:flutter/material.dart';
import '../../widgets/navigation_bar.dart';
import '../../navigation/main_screen_wrapper.dart';

class DrThompsonScreen extends StatelessWidget {
  const DrThompsonScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              // Back arrow
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () => Navigator.pop(context),
                  ),
                  const Spacer(),
                ],
              ),

              // Profile picture and name
              const CircleAvatar(
                backgroundImage: AssetImage('assets/icons/dr_thompson.png'),
                radius: 60,
              ),
              const SizedBox(height: 12),
              const Text(
                'Dr. Linda Thompson',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),

              // Buttons
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF007BFF),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text(
                        'Call or Text Now',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/care-tab-3');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF28A745),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text(
                        'Schedule Appointment',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Stats
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildStatBox(
                    'assets/icons/patients_icon.png',
                    '1200+',
                    'Patients',
                    Colors.blueAccent,
                  ),
                  _buildStatBox(
                    'assets/icons/experience_icon.png',
                    '12 Yrs',
                    'Experience',
                    Colors.pinkAccent,
                  ),
                  _buildStatBox(
                    'assets/icons/ratings_icon.png',
                    '4.9',
                    'Ratings',
                    Colors.orangeAccent,
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // About Doctor
              _buildSectionTitle('About Doctor'),
              Container(
                width: double.infinity,
                margin: const EdgeInsets.only(top: 8),
                padding: const EdgeInsets.all(14),
                decoration: _gradientBoxDecoration(),
                child: const Text(
                  'Dr. Linda Thompson is a compassionate and highly respected family medicine practitioner with over 12 years of experience. She is dedicated to delivering personalized, comprehensive care for patients of all ages—emphasizing preventive medicine and long-term health management. Dr. Thompson is known for her warm bedside manner, thoughtful approach, and unwavering commitment to improving the lives of those she serves. Patients trust her for expert guidance and a healthcare experience grounded in empathy, respect, and excellence.',
                  style: TextStyle(height: 1.4),
                ),
              ),
              const SizedBox(height: 20),

              // Working Time
              _buildSectionTitle('Working Time'),
              const SizedBox(height: 4),
              const Text('Mon – Fri (09:00 AM – 06:00 PM)'),
              const SizedBox(height: 24),

              // Communication
              _buildSectionTitle('Communication'),
              const SizedBox(height: 12),
              _buildCommOption(
                'assets/icons/messaging_icon.png',
                'Messaging',
                'Reach out for quick updates or questions',
              ),
              const SizedBox(height: 12),
              _buildCommOption(
                'assets/icons/audiocall_icon.png',
                'Audio Call',
                'Consult with Doctor directly for tailored advice',
              ),
              const SizedBox(height: 12),
              _buildCommOption(
                'assets/icons/videocall_icon.png',
                'Video Call',
                'Engage in face-to-face consultations',
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
      bottomNavigationBar: CustomNavigationBar(
        selectedIndex: 3,
        onTabSelected: (index) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (_) => MainScreenWrapper(initialTab: index),
            ),
          );
        },
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      ),
    );
  }

  Widget _buildStatBox(
    String? iconPath,
    String number,
    String label,
    Color iconColor, {
    IconData? fallbackIcon,
  }) {
    return Container(
      width: 90,
      padding: const EdgeInsets.all(10),
      decoration: _gradientBoxDecoration(),
      child: Column(
        children: [
          iconPath != null
              ? Image.asset(
                  iconPath,
                  height: 32,
                  color: iconColor,
                )
              : Icon(
                  fallbackIcon ?? Icons.info,
                  size: 32,
                  color: iconColor,
                ),
          const SizedBox(height: 6),
          Text(
            number,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          Text(
            label,
            style: const TextStyle(fontSize: 12),
          ),
        ],
      ),
    );
  }

  Widget _buildCommOption(
    String iconPath,
    String label,
    String subtitle,
  ) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: _gradientBoxDecoration(),
      child: Row(
        children: [
          Image.asset(iconPath, height: 36),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: const TextStyle(
                    color: Colors.black54,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  BoxDecoration _gradientBoxDecoration() {
    return BoxDecoration(
      gradient: const LinearGradient(
        colors: [Color(0xFFF4F0FF), Color(0xFFFFFFFF)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.05),
          blurRadius: 10,
          offset: const Offset(0, 4),
        ),
      ],
    );
  }
}
