import 'package:flutter/material.dart';
import 'features/splash/screens/splash_screen.dart';
import 'features/auth/screens/login_screen.dart'; 
import 'features/auth/screens/signup_screen.dart';
import 'features/auth/screens/forgot_password_screen.dart';
import 'features/home/intake_form.dart';
import 'features/home/carelink_experience_survey.dart';
import 'features/home/provider_feedback_survey.dart';
import 'navigation/main_screen_wrapper.dart';
import 'features/profile/profile_screen.dart';
import 'features/profile/edit_profile.dart';
import 'features/profile/favorites.dart';
import 'features/profile/payment_method.dart';
import 'features/profile/privacy_policy.dart';
import 'features/profile/settings.dart';
import 'features/profile/help.dart';
import 'features/meds/med_screen.dart';
import 'features/about/about_carelink_screen.dart'; 
import 'features/care/dr_thompson_screen.dart';
import 'features/care/dr_vali_screen.dart';





void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '  ',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Color(0xFF2A9D8F)),
        useMaterial3: true,
      ),
      home: SplashScreen.timer(
        seconds: 8,
        navigateAfterSeconds: '/login',
        backgroundColor: Colors.white,
        image: Image.asset('assets/images/carelink_logo.png'),
        loadingText: const Text(
          'Connecting Doctors and Patients',
          style: TextStyle(
            fontSize: 16.0,
            color: Colors.black87,
          ),
        ),
        photoSize: 150.0,
        loaderColor: Color(0xFF2A9D8F),
      ),
      routes: {
        '/login': (context) => const LoginScreen(),
        '/signup': (context) => const SignupScreen(),
        '/forgot-password': (context) => const ForgotPasswordScreen(),
        '/home': (context) => const MainScreenWrapper(),
        '/intake-form': (context) => const CarelinkIntakeForm(),
        '/survey-carelink': (context) => const CarelinkExperienceSurvey(),
        '/survey-provider': (context) => const ProviderFeedbackSurvey(),
        '/profile': (context) => const ProfileScreen(),
        '/edit-profile': (context) => const EditProfileScreen(),
        '/favorites': (context) => const FavoriteScreen(),
        '/payment': (context) => const PaymentScreen(),
        '/privacy-policy': (context) => const PrivacyPolicyScreen(),
        '/help': (context) => const HelpScreen(),
        '/settings': (context) => const SettingsScreen(),
        '/meds': (context) => const MedScreen(),
        '/about-carelink': (context) => const AboutCareLinkScreen(),
        '/doctor-thompson': (context) => const DrThompsonScreen(),
        '/doctor-vali': (context) => const DrValiScreen(),


      },
    );
  }
}
