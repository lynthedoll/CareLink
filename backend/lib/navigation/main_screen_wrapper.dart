import 'package:flutter/material.dart';
import '../features/home/home_screen.dart';
import '../features/meds/med_screen.dart';
import '../features/care/care_screen.dart';
import '../features/profile/profile_screen.dart';
import '../widgets/navigation_bar.dart';

class MainScreenWrapper extends StatefulWidget {
  const MainScreenWrapper({super.key});

  @override
  State<MainScreenWrapper> createState() => _MainScreenWrapperState();
}

class _MainScreenWrapperState extends State<MainScreenWrapper> {
  int _currentIndex = 0;

  // Add a placeholder (e.g. SizedBox) at index 2 for the center + icon
  final List<Widget> _screens = const [
    HomeScreen(),
    MedScreen(),
    SizedBox.shrink(), // placeholder for the "+" icon (index 2)
    CareScreen(),
    ProfileScreen(),
  ];

  void _onTabTapped(int index) {
    if (index != 2) {
      setState(() {
        _currentIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: CustomNavigationBar(
        selectedIndex: _currentIndex,
        onTabSelected: _onTabTapped,
      ),
    );
  }
}
