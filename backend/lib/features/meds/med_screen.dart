import 'package:flutter/material.dart';
import '../../navigation/main_screen_wrapper.dart';

class MedScreen extends StatelessWidget {
  const MedScreen({super.key});

  final List<Map<String, String>> ongoingMeds = const [
    {"name": "Zyrtec", "time": "Morning", "status": "Good Standing", "type": "pill"},
    {"name": "Multivitamins", "time": "Afternoon", "status": "Good Standing", "type": "pill"},
    {"name": "Fish Oil", "time": "Evening", "status": "Refill Needed", "type": "pill"},
    {"name": "Eye Drops", "time": "Night", "status": "Good Standing", "type": "eyedrop"},
  ];

  String getMedicationIcon(String type) {
    switch (type) {
      case 'eyedrop':
        return 'assets/icons/eyedrop_icon.png';
      case 'pill':
      default:
        return 'assets/icons/pill_icon.png';
    }
  }

  void _onProfileTapped(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const MainScreenWrapper(initialTab: 4)),
    );
  }

  void _onLogoTapped(BuildContext context) {
    Navigator.pushNamed(context, '/about-carelink');
  }

  void _onNotificationTapped() => print("Notification tapped");

  void _onAddMedicationTapped(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Add Medication"),
        content: SingleChildScrollView(
          child: Column(
            children: const [
              TextField(decoration: InputDecoration(labelText: "Name")),
              TextField(decoration: InputDecoration(labelText: "Dosage")),
              TextField(decoration: InputDecoration(labelText: "Frequency")),
              TextField(decoration: InputDecoration(labelText: "Time(s) of Day")),
              TextField(decoration: InputDecoration(labelText: "Start Date")),
              TextField(decoration: InputDecoration(labelText: "End Date")),
              TextField(decoration: InputDecoration(labelText: "Notes")),
            ],
          ),
        ),
        actions: [
          TextButton(
            child: const Text("Cancel"),
            onPressed: () => Navigator.pop(context),
          ),
          TextButton(
            child: const Text("Add"),
            onPressed: () {
              Navigator.pop(context);
              // TODO: Save new medication logic
            },
          ),
        ],
      ),
    );
  }

  void _showMedDetails(BuildContext context, String medName) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              medName,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            const Text("Dosage: 10mg"),
            const Text("Frequency: Daily"),
            const Text("Time: Morning"),
            const Text("Status: Taken"),
            const Text("Standing: Good Standing", style: TextStyle(color: Colors.green)),
            const Text("Doctor's Notes: Take with water"),
          ],
        ),
      ),
    );
  }

  Widget buildMedCard({
    required BuildContext context,
    required String name,
    required String time,
    required String status,
    required Color statusColor,
    required String iconAsset,
  }) {
    return GestureDetector(
      onTap: () => _showMedDetails(context, name),
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
            colors: [Color(0xFFE7E4FB), Color(0xFFFFF4E5)],
          ),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.14),
              blurRadius: 12,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(iconAsset, height: 90),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  const SizedBox(height: 4),
                  Text("Next Dose: $time"),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Text(status, style: TextStyle(color: statusColor)),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      body: SafeArea(
        child: SingleChildScrollView( // Fixes overflow
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            children: [
              // Top Bar
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () => _onProfileTapped(context),
                    borderRadius: BorderRadius.circular(30),
                    child: ClipOval(
                      child: Image.asset(
                        'assets/images/profile_icon.png',
                        height: 50,
                        width: 50,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      InkWell(
                        onTap: () => _onLogoTapped(context),
                        borderRadius: BorderRadius.circular(20),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.asset('assets/images/logo_icon.png', height: 28),
                        ),
                      ),
                      const SizedBox(width: 12),
                      InkWell(
                        onTap: _onNotificationTapped,
                        borderRadius: BorderRadius.circular(20),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.asset('assets/images/notification_icon.png', height: 28),
                        ),
                      ),
                    ],
                  )
                ],
              ),

              const SizedBox(height: 24),

              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Ongoing Prescriptions",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 12),

              ...ongoingMeds.map((med) {
                return buildMedCard(
                  context: context,
                  name: med['name']!,
                  time: med['time']!,
                  status: med['status']!,
                  statusColor: med['status'] == 'Refill Needed' ? Colors.red : Colors.green,
                  iconAsset: getMedicationIcon(med['type']!),
                );
              }).toList(),

              const SizedBox(height: 8),

              ElevatedButton(
                onPressed: () => _onAddMedicationTapped(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFE8F0FE),
                  minimumSize: const Size(double.infinity, 48),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text(
                  '+ Add Medication',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),

              const SizedBox(height: 24),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Past Prescriptions",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 12),

              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment.bottomLeft,
                    end: Alignment.topRight,
                    colors: [Color(0xFFE7E4FB), Color(0xFFFFF4E5)],
                  ),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.14),
                      blurRadius: 12,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Benadryl', style: TextStyle(fontWeight: FontWeight.bold)),
                    Text('Used for allergy relief'),
                    SizedBox(height: 4),
                    Text('Start: Jan 5, 2024'),
                    Text('End: Feb 15, 2024'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
