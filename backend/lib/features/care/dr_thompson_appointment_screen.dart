import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'dart:math';

class DrThompsonAppointmentScreen extends StatefulWidget {
  const DrThompsonAppointmentScreen({super.key});

  @override
  State<DrThompsonAppointmentScreen> createState() => _DrThompsonAppointmentScreenState();
}

class _DrThompsonAppointmentScreenState extends State<DrThompsonAppointmentScreen> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  final Map<String, List<String>> _dailySlots = {};

  @override
  void initState() {
    super.initState();
    _generateAllSlots();
  }

  void _generateAllSlots() {
    final now = DateTime.now();
    final end = DateTime(now.year, now.month + 2, now.day);

    for (var date = now; date.isBefore(end); date = date.add(const Duration(days: 1))) {
      _dailySlots[_formatDate(date)] = _generateRandomSlotsForDay(date);
    }
  }

  List<String> _generateRandomSlotsForDay(DateTime day) {
    final rng = Random();
    final slotCount = rng.nextInt(4) + 2; // 2–5 slots
    final baseTimes = [9, 10, 11, 13, 14, 15, 16];
    baseTimes.shuffle();
    final selected = baseTimes.take(slotCount).toList()..sort();
    return selected.map((hour) => '${_formatTime(hour)} - ${_formatTime(hour + 1)}').toList();
  }

  String _formatDate(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }

  String _formatTime(int hour) {
    final h = hour > 12 ? hour - 12 : hour;
    final period = hour >= 12 ? 'PM' : 'AM';
    return '$h:00 $period';
  }

  String formatPrettyDate(DateTime date) {
    const monthNames = [
      '',
      'January', 'February', 'March', 'April', 'May', 'June',
      'July', 'August', 'September', 'October', 'November', 'December'
    ];

    final day = date.day;
    final suffix = (day >= 11 && day <= 13)
        ? 'th'
        : (day % 10 == 1)
            ? 'st'
            : (day % 10 == 2)
                ? 'nd'
                : (day % 10 == 3)
                    ? 'rd'
                    : 'th';

    final formatted = '${monthNames[date.month]} $day$suffix, ${date.year}';
    return formatted;
  }

  void _onTimeSelected(String slot) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Confirm Appointment'),
        content: Text(
          'Would you like to schedule your appointment on '
          '${formatPrettyDate(_selectedDay!)} at $slot with Dr. Thompson?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pushNamed(
                context,
                '/appointment-form',
                arguments: {
                  'date': _selectedDay!,
                  'time': slot,
                  'doctor': 'Dr. Linda Thompson',
                  'specialty': 'Family Medicine',
                  'image': 'assets/icons/dr_thompson.png',
                },
              );
            },
            child: const Text('Confirm'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final slots = _selectedDay != null ? _dailySlots[_formatDate(_selectedDay!)] ?? [] : [];

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
        title: const Text('Schedule Appointment'),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TableCalendar(
              firstDay: DateTime.now(),
              lastDay: DateTime.now().add(const Duration(days: 60)),
              focusedDay: _focusedDay,
              calendarStyle: const CalendarStyle(
                todayDecoration: BoxDecoration(
                  color: Colors.deepPurple,
                  shape: BoxShape.circle,
                ),
                selectedDecoration: BoxDecoration(
                  color: Colors.purpleAccent,
                  shape: BoxShape.circle,
                ),
              ),
              selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
              onDaySelected: (selected, focused) {
                setState(() {
                  _selectedDay = selected;
                  _focusedDay = focused;
                });
              },
              onPageChanged: (focused) {
                _focusedDay = focused;
              },
              availableCalendarFormats: const {
                CalendarFormat.month: 'Month',
              },
            ),
            const SizedBox(height: 24),
            if (_selectedDay == null)
              const Text('Select a date to see available times.')
            else if (slots.isEmpty)
              const Text('No available slots for this day.')
            else
              Expanded(
                child: ListView.builder(
                  itemCount: slots.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () => _onTimeSelected(slots[index]),
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 6),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          gradient: const LinearGradient(
                            colors: [Color(0xFFF4F0FF), Color(0xFFFFFFFF)],
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 6,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              slots[index],
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            const Icon(Icons.arrow_forward_ios, size: 16),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
