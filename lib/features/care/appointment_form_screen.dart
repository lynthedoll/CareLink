import 'package:flutter/material.dart';
import '../../navigation/main_screen_wrapper.dart';
import '../../widgets/navigation_bar.dart';

class AppointmentFormScreen extends StatefulWidget {
  const AppointmentFormScreen({super.key});

  @override
  State<AppointmentFormScreen> createState() => _AppointmentFormScreenState();
}

class _AppointmentFormScreenState extends State<AppointmentFormScreen> {
  final _formKey = GlobalKey<FormState>();

  String _fullName = '';
  String _age = '';
  String _gender = 'Select';
  String _reason = '';

  final List<String> _genderOptions = ['Male', 'Female', 'Other', 'Decline to say'];

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map;
    final date = args['date'];
    final time = args['time'];
    final doctor = args['doctor'];
    final specialty = args['specialty'];
    final image = args['image'];

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFE4D7FF), Color(0xFFFFFFFF)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
        title: const Text('Appointment Form'),
        elevation: 0,
      ),
      backgroundColor: const Color(0xFFF9F9F9),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              const Text(
                'Please provide the following information:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),

              TextFormField(
                decoration: const InputDecoration(labelText: 'Full Name'),
                onChanged: (val) => _fullName = val,
                validator: (val) => val == null || val.isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 12),

              TextFormField(
                decoration: const InputDecoration(labelText: 'Age'),
                keyboardType: TextInputType.number,
                onChanged: (val) => _age = val,
                validator: (val) => val == null || val.isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 12),

              DropdownButtonFormField<String>(
                value: _gender == 'Select' ? null : _gender,
                items: _genderOptions.map((g) {
                  return DropdownMenuItem(value: g, child: Text(g));
                }).toList(),
                hint: const Text('Gender'),
                onChanged: (val) => setState(() => _gender = val!),
                validator: (val) => val == null || val == 'Select' ? 'Required' : null,
              ),
              const SizedBox(height: 12),

              TextFormField(
                decoration: const InputDecoration(labelText: 'Reason for Appointment'),
                onChanged: (val) => _reason = val,
                validator: (val) => val == null || val.isEmpty ? 'Required' : null,
                maxLines: 3,
              ),
              const SizedBox(height: 24),

              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    Navigator.pushNamed(
                      context,
                      '/appointment-confirmation',
                      arguments: {
                        'date': date,
                        'time': time,
                        'doctor': doctor,
                        'specialty': specialty,
                        'image': image,
                        'fullName': _fullName,
                        'age': _age,
                        'gender': _gender,
                        'reason': _reason,
                      },
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurpleAccent,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: const Text(
                  'Confirm Appointment',
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: CustomNavigationBar(
        selectedIndex: 3,
        onTabSelected: (int index) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => MainScreenWrapper(initialTab: index)),
          );
        },
      ),
    );
  }
}
