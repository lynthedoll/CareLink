import 'package:flutter/material.dart';
import '../features/home/home_screen.dart';
import '../features/meds/med_screen.dart';
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
      SizedBox.shrink(), // Placeholder for the "+" icon
      CareScreen(),
      ProfileScreen(),
    ];
  }

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
