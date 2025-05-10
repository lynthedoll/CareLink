import 'package:flutter/material.dart';
import '../../navigation/main_screen_wrapper.dart';
import '../notifications/notification_data.dart';

class MedScreen extends StatefulWidget {
  const MedScreen({super.key});

  @override
  State<MedScreen> createState() => _MedScreenState();
}

class _MedScreenState extends State<MedScreen> {
  List<Map<String, String>> ongoingMeds = [
    {"name": "Zyrtec", "time": "Morning", "status": "Good Standing", "type": "pill"},
    {"name": "Multivitamins", "time": "Afternoon", "status": "Good Standing", "type": "pill"},
    {"name": "Fish Oil", "time": "Evening", "status": "Refill Needed", "type": "pill"},
    {"name": "Eye Drops", "time": "Night", "status": "Good Standing", "type": "eyedrop"},
  ];

  final List<String> timeOptions = ['Morning', 'Afternoon', 'Evening', 'Night'];
  final List<String> statusOptions = ['Good Standing', 'Refill Needed'];
  final List<String> typeOptions = ['pill', 'eyedrop'];

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

  void _onNotificationTapped(BuildContext context) async {
    await Navigator.pushNamed(context, '/notifications');
    setState(() {});
  }

  void _onAddMedicationTapped(BuildContext context) {
    final nameController = TextEditingController();
    String selectedTime = timeOptions[0];
    String selectedStatus = statusOptions[0];
    String selectedType = typeOptions[0];

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Add Medication"),
        content: SingleChildScrollView(
          child: Column(
            children: [
              TextField(controller: nameController, decoration: const InputDecoration(labelText: "Name")),
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                value: selectedTime,
                items: timeOptions.map((t) => DropdownMenuItem(value: t, child: Text(t))).toList(),
                decoration: const InputDecoration(labelText: "Time(s) of Day"),
                onChanged: (val) => selectedTime = val!,
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                value: selectedStatus,
                items: statusOptions.map((s) => DropdownMenuItem(value: s, child: Text(s))).toList(),
                decoration: const InputDecoration(labelText: "Status"),
                onChanged: (val) => selectedStatus = val!,
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                value: selectedType,
                items: typeOptions.map((t) => DropdownMenuItem(value: t, child: Text(t))).toList(),
                decoration: const InputDecoration(labelText: "Type"),
                onChanged: (val) => selectedType = val!,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(child: const Text("Cancel"), onPressed: () => Navigator.pop(context)),
          TextButton(
            child: const Text("Add"),
            onPressed: () {
              setState(() {
                ongoingMeds.add({
                  'name': nameController.text,
                  'time': selectedTime,
                  'status': selectedStatus,
                  'type': selectedType
                });
              });
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  void _onEditMedicationTapped(BuildContext context, int index) {
    final med = ongoingMeds[index];
    final nameController = TextEditingController(text: med['name']);
    String selectedTime = med['time'] ?? timeOptions[0];
    String selectedStatus = med['status'] ?? statusOptions[0];
    String selectedType = med['type'] ?? typeOptions[0];

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Edit Medication"),
        content: SingleChildScrollView(
          child: Column(
            children: [
              TextField(controller: nameController, decoration: const InputDecoration(labelText: "Name")),
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                value: selectedTime,
                items: timeOptions.map((t) => DropdownMenuItem(value: t, child: Text(t))).toList(),
                decoration: const InputDecoration(labelText: "Time(s) of Day"),
                onChanged: (val) => selectedTime = val!,
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                value: selectedStatus,
                items: statusOptions.map((s) => DropdownMenuItem(value: s, child: Text(s))).toList(),
                decoration: const InputDecoration(labelText: "Status"),
                onChanged: (val) => selectedStatus = val!,
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                value: selectedType,
                items: typeOptions.map((t) => DropdownMenuItem(value: t, child: Text(t))).toList(),
                decoration: const InputDecoration(labelText: "Type"),
                onChanged: (val) => selectedType = val!,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(child: const Text("Cancel"), onPressed: () => Navigator.pop(context)),
          TextButton(
            child: const Text("Save"),
            onPressed: () {
              setState(() {
                ongoingMeds[index] = {
                  'name': nameController.text,
                  'time': selectedTime,
                  'status': selectedStatus,
                  'type': selectedType
                };
              });
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  void _onDeleteMedicationTapped(BuildContext context, int index) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Confirm Delete"),
        content: const Text("Are you sure you want to delete this medication?"),
        actions: [
          TextButton(child: const Text("Cancel"), onPressed: () => Navigator.pop(context)),
          TextButton(
            child: const Text("Delete"),
            onPressed: () {
              setState(() {
                ongoingMeds.removeAt(index);
              });
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  Widget buildMedCard({
    required BuildContext context,
    required int index,
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
            Column(
              children: [
                Text(status, style: TextStyle(color: statusColor)),
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit, size: 18),
                      onPressed: () => _onEditMedicationTapped(context, index),
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete, size: 18),
                      onPressed: () => _onDeleteMedicationTapped(context, index),
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
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
            Text(medName, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      body: SafeArea(
        child: SingleChildScrollView(
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
                      child: Image.asset('assets/images/profile_icon.png', height: 50, width: 50, fit: BoxFit.cover),
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
                      Stack(
                        children: [
                          InkWell(
                            onTap: () => _onNotificationTapped(context),
                            borderRadius: BorderRadius.circular(20),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.asset('assets/images/notification_icon.png', height: 28),
                            ),
                          ),
                          if (!notificationsViewed && notifications.isNotEmpty)
                            Positioned(
                              right: 4,
                              top: 4,
                              child: Container(
                                padding: const EdgeInsets.all(2),
                                decoration: const BoxDecoration(color: Colors.red, shape: BoxShape.circle),
                                constraints: const BoxConstraints(minWidth: 14, minHeight: 14),
                                child: Text(
                                  '${notifications.length}',
                                  style: const TextStyle(color: Colors.white, fontSize: 9, fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ],
                  )
                ],
              ),
              const SizedBox(height: 24),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text("Ongoing Prescriptions", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
              const SizedBox(height: 12),

              ...List.generate(ongoingMeds.length, (index) {
                final med = ongoingMeds[index];
                return buildMedCard(
                  context: context,
                  index: index,
                  name: med['name']!,
                  time: med['time']!,
                  status: med['status']!,
                  statusColor: med['status'] == 'Refill Needed' ? Colors.red : Colors.green,
                  iconAsset: getMedicationIcon(med['type']!),
                );
              }),

              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: () => _onAddMedicationTapped(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFE8F0FE),
                  minimumSize: const Size(double.infinity, 48),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                ),
                child: const Text('+ Add Medication', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
              ),
              const SizedBox(height: 24),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text("Past Prescriptions", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
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
