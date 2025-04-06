import 'package:flutter/material.dart';
import 'features/splash/screens/splash_screen.dart';
import 'features/auth/screens/login_screen.dart'; 
import 'features/auth/screens/signup_screen.dart';
import 'features/auth/screens/forgot_password_screen.dart';
import 'features/home/home_screen.dart';
import 'features/home/intake_form.dart';
import 'features/home/carelink_experience_survey.dart';
import 'features/home/provider_feedback_survey.dart';


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
        '/home': (context) => const HomeScreen(),
        '/intake-form': (context) => const CarelinkIntakeForm(),
        '/survey-carelink': (context) => const CarelinkExperienceSurvey(),
        '/survey-provider': (context) => const ProviderFeedbackSurvey(),

        // Add the "location" screen here when the screen is created
      },
    );
  }
}
