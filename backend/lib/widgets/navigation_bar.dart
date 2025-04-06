import 'package:flutter/material.dart';

class CustomNavigationBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onTabSelected;

  const CustomNavigationBar({
    Key? key,
    required this.selectedIndex,
    required this.onTabSelected,
  }) : super(key: key);

  static const Color kActiveTabColor = Color(0xFF4D83C2); // Blue
  static const Color kInactiveTabColor = Colors.black;

  BottomNavigationBarItem buildNavItem({
    required String iconPath,
    required String label,
    required int index,
  }) {
    return BottomNavigationBarItem(
      icon: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            iconPath,
            height: 24,
            color: selectedIndex == index ? kActiveTabColor : kInactiveTabColor,
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: selectedIndex == index ? kActiveTabColor : kInactiveTabColor,
            ),
          ),
        ],
      ),
      label: '',
    );
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: selectedIndex,
      onTap: onTabSelected,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: kActiveTabColor,
      unselectedItemColor: kInactiveTabColor,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      items: [
        buildNavItem(iconPath: 'assets/icons/home_icon.png', label: 'Home', index: 0),
        buildNavItem(iconPath: 'assets/icons/meds_icon.png', label: 'Meds', index: 1),
        BottomNavigationBarItem(
          icon: Container(
            height: 50,
            width: 50,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
              boxShadow: [
                BoxShadow(color: Colors.black12, blurRadius: 6),
              ],
            ),
            child: Center(
              child: Image.asset(
                'assets/icons/plus_icon.png',
                height: 30,
              ),
            ),
          ),
          label: '',
        ),
        buildNavItem(iconPath: 'assets/icons/care_icon.png', label: 'Care', index: 3),
        buildNavItem(iconPath: 'assets/icons/userprofile_icon.png', label: 'Profile', index: 4),
      ],
    );
  }
}
