import 'package:flutter/material.dart';
import '../components/custom_text_field.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              Image.asset(
                'assets/images/carelink_logo.png',
                height: 100,
              ),
              const SizedBox(height: 10),
              const Text(
                'Create your account',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 20),

              const CustomTextField(
                hintText: 'Full Name',
              ),
              const SizedBox(height: 12),
              const CustomTextField(
                hintText: 'Email',
              ),
              const SizedBox(height: 12),
              const CustomTextField(
                hintText: 'Password',
                obscureText: true,
              ),
              const SizedBox(height: 12),
              const CustomTextField(
                hintText: 'Confirm Password',
                obscureText: true,
              ),
              const SizedBox(height: 20),

              ElevatedButton(
                onPressed: () {
                  // TODO: Handle sign-up logic
                },
                child: const Text("Sign Up"),
              ),

              const SizedBox(height: 20),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("Already have an account? Log In"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
