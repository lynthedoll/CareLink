import 'package:flutter/material.dart';
import '../../navigation/main_screen_wrapper.dart';
import '../../widgets/navigation_bar.dart';

class CarelinkIntakeForm extends StatefulWidget {
  const CarelinkIntakeForm({super.key});

  @override
  State<CarelinkIntakeForm> createState() => _CarelinkIntakeFormState();
}

class _CarelinkIntakeFormState extends State<CarelinkIntakeForm> {
  bool submitted = false;

  final _formKey = GlobalKey<FormState>();

  final TextEditingController phoneController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  final TextEditingController languageController = TextEditingController();
  final TextEditingController insuranceDetailsController = TextEditingController();
  final TextEditingController appointmentReasonController = TextEditingController();
  final TextEditingController conditionsController = TextEditingController();
  final TextEditingController medicationsController = TextEditingController();
  final TextEditingController allergiesController = TextEditingController();
  final TextEditingController timezoneController = TextEditingController();
  final TextEditingController accommodationsController = TextEditingController();
  final TextEditingController referralOtherController = TextEditingController();
  final TextEditingController genderOtherController = TextEditingController();

  String? gender;
  String? hasInsurance;
  List<String> preferredTimes = [];
  String? communicationMethod;
  String? referralSource;

  void handleSubmit() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        submitted = true;
      });

      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text('Thank you!'),
          content: const Text('Your intake form has been submitted.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  Widget buildCheckbox(String label) {
    return CheckboxListTile(
      title: Text(label),
      value: preferredTimes.contains(label),
      onChanged: submitted
          ? null
          : (value) {
              setState(() {
                if (value == true) {
                  preferredTimes.add(label);
                } else {
                  preferredTimes.remove(label);
                }
              });
            },
    );
  }

  Widget buildRadioGroup(String title, List<String> options, String? groupValue, void Function(String?) onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        ...options.map(
          (option) => RadioListTile<String>(
            title: Text(option),
            value: option,
            groupValue: groupValue,
            onChanged: submitted ? null : onChanged,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(color: Colors.black),
        backgroundColor: const Color(0xFFDDF1FF),
        title: const Text('CareLink Intake Form', style: TextStyle(color: Colors.black)),
      ),
      backgroundColor: const Color(0xFFF9F9F9),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              const Text(
                'This demo intake form collects basic information to help tailor your CareLink experience. Your responses are confidential.',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 24),

              TextFormField(controller: phoneController, enabled: !submitted, decoration: const InputDecoration(labelText: 'Phone Number')),
              TextFormField(controller: dobController, enabled: !submitted, decoration: const InputDecoration(labelText: 'Date of Birth')),

              buildRadioGroup('Gender Identity', ['Woman', 'Man', 'Non-binary', 'Prefer not to say'], gender, (value) => setState(() => gender = value)),
              TextFormField(controller: genderOtherController, enabled: !submitted, decoration: const InputDecoration(labelText: 'Other (please specify)')),

              TextFormField(controller: languageController, enabled: !submitted, decoration: const InputDecoration(labelText: 'Preferred Language')),

              buildRadioGroup('Do you have health insurance?', ['Yes', 'No', 'Prefer not to say'], hasInsurance, (value) => setState(() => hasInsurance = value)),
              TextFormField(controller: insuranceDetailsController, enabled: !submitted, decoration: const InputDecoration(labelText: 'Insurance Provider and Plan')),

              TextFormField(controller: appointmentReasonController, enabled: !submitted, decoration: const InputDecoration(labelText: 'Reason(s) for Scheduling Appointment')),
              TextFormField(controller: conditionsController, enabled: !submitted, decoration: const InputDecoration(labelText: 'Current/Chronic Medical Conditions')),
              TextFormField(controller: medicationsController, enabled: !submitted, decoration: const InputDecoration(labelText: 'Current Medications')),
              TextFormField(controller: allergiesController, enabled: !submitted, decoration: const InputDecoration(labelText: 'Allergies')),

              const SizedBox(height: 16),
              const Text('Preferred Appointment Times', style: TextStyle(fontWeight: FontWeight.bold)),
              buildCheckbox('Weekday mornings'),
              buildCheckbox('Weekday afternoons'),
              buildCheckbox('Weekday evenings'),
              buildCheckbox('Weekends'),
              buildCheckbox('No preference'),

              TextFormField(controller: timezoneController, enabled: !submitted, decoration: const InputDecoration(labelText: 'Time Zone')),

              buildRadioGroup('Preferred Communication Method', ['Email', 'Text/SMS', 'Phone call'], communicationMethod, (value) => setState(() => communicationMethod = value)),
              TextFormField(controller: accommodationsController, enabled: !submitted, decoration: const InputDecoration(labelText: 'Accessibility Accommodations')),

              buildRadioGroup('How did you hear about CareLink?', ['Friend or family', 'Social media', 'School or university', 'Doctor referral', 'Online search'], referralSource, (value) => setState(() => referralSource = value)),
              TextFormField(controller: referralOtherController, enabled: !submitted, decoration: const InputDecoration(labelText: 'Other (please specify)')),

              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: submitted ? null : handleSubmit,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFE8F0FE),
                  minimumSize: const Size(double.infinity, 48),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text(
                  'Submit',
                  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: CustomNavigationBar(
        selectedIndex: 0,
        onTabSelected: (index) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => MainScreenWrapper(initialTab: index)),
          );
        },
      ),
    );
  }
}
