import 'package:flutter/material.dart';
import 'signup_screen.dart';
import '../components/custom_text_field.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

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
                height: 120,
              ),
              const SizedBox(height: 10),
              const Text(
                'Welcome back!',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 20),

              const CustomTextField(
                hintText: 'Email',
              ),
              const SizedBox(height: 12),
              const CustomTextField(
                hintText: 'Password',
                obscureText: true,
              ),

              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // TODO: Handle login logic
                },
                child: const Text("Login"),
              ),

              const SizedBox(height: 12),              
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/forgot-password');
                },
                child: const Text("Forgot Password?"),
              ),

              const SizedBox(height: 12),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/signup');
                },
                child: const Text("Don't have an account? Sign Up"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
