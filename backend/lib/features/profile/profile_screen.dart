import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Confirm Logout'),
        content: const Text('Are you sure you want to log out?'),
        actions: [
          TextButton(
            child: const Text('Cancel'),
            onPressed: () => Navigator.pop(context),
          ),
          TextButton(
            child: const Text('Logout'),
            onPressed: () {
              Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
            },
          ),
        ],
      ),
    );
  }

  void _showEditPictureOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: const Icon(Icons.photo_library),
            title: const Text('Choose from Library'),
            onTap: () {
              Navigator.pop(context);
              _showMockupMessage(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.camera_alt),
            title: const Text('Take Picture'),
            onTap: () {
              Navigator.pop(context);
              _showMockupMessage(context);
            },
          ),
        ],
      ),
    );
  }

  void _showMockupMessage(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Mockup'),
        content: const Text('This is just a mockup! Feature coming soon.'),
        actions: [
          TextButton(
            child: const Text('OK'),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }

  Widget buildOption(
    BuildContext context, {
    required String iconPath,
    required String title,
    VoidCallback? onTap,
  }) {
    return ListTile(
      leading: Image.asset(iconPath, height: 28),
      title: Text(title, style: const TextStyle(fontSize: 16)),
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap ?? () {},
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Column(
          children: [
            const Text(
              'My Profile',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFFB388EB), // softer lavender purple
              ),
            ),
            const SizedBox(height: 8),
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: 120,
                  height: 120,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Color(0xFFCAACFF),
                        blurRadius: 15,
                        spreadRadius: 5,
                        offset: Offset(0, 5),
                      ),
                    ],
                    image: DecorationImage(
                      image: AssetImage('assets/images/profile_icon.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(20),
                    onTap: () => _showEditPictureOptions(context),
                    child: SizedBox(
                      height: 40,
                      width: 40,
                      child: Image.asset(
                        'assets/icons/edit_pic_icon.png',
                        height: 32,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            const Text(
              'Jamiliah Eubanks',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),

            // Profile Options
            buildOption(
              context, 
              iconPath: 'assets/icons/profile_icon.png', 
              title: 'Profile',
              onTap: () => Navigator.pushNamed(context, '/edit-profile'),
            ),
            buildOption(
              context,
              iconPath: 'assets/icons/favorites_icon.png',
              title: 'Favorites',
              onTap: () => Navigator.pushNamed(context, '/favorites'),
            ),
            buildOption(
              context,
              iconPath: 'assets/icons/payment_icon.png',
              title: 'Payment Method',
              onTap: () => Navigator.pushNamed(context, '/payment'),
            ),
            buildOption(
              context,
              iconPath: 'assets/icons/privacy_icon.png',
              title: 'Privacy Policy',
              onTap: () => Navigator.pushNamed(context, '/privacy-policy'),
            ),
            buildOption(
              context,
              iconPath: 'assets/icons/settings_icon.png',
              title: 'Settings',
              onTap: () => Navigator.pushNamed(context, '/settings'),
            ),
            buildOption(
              context,
              iconPath: 'assets/icons/help_icon.png',
              title: 'Help',
              onTap: () => Navigator.pushNamed(context, '/help'),
            ),
            buildOption(
              context,
              iconPath: 'assets/icons/logout_icon.png',
              title: 'Logout',
              onTap: () => _showLogoutDialog(context),
            ),
          ],
        ),
      ),
    );
  }
}
