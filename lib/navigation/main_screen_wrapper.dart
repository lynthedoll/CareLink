import 'package:flutter/material.dart';
import '../features/home/home_screen.dart';
import '../features/meds/med_screen.dart';
import '../features/communication/communication_screen.dart'; // ← NEW
import '../features/care/care_screen.dart';
import '../features/profile/profile_screen.dart';
import '../widgets/navigation_bar.dart';

class MainScreenWrapper extends StatefulWidget {
  final int initialTab;

  const MainScreenWrapper({super.key, this.initialTab = 0});

  @override
  State<MainScreenWrapper> createState() => _MainScreenWrapperState();
}

class _MainScreenWrapperState extends State<MainScreenWrapper> {
  late int _currentIndex;
  late final List<Widget> _screens;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialTab;

    _screens = const [
      HomeScreen(),
      MedScreen(),
      CommunicationScreen(), // ← REPLACED the SizedBox with your new screen
      CareScreen(),
      ProfileScreen(),
    ];
  }

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
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
