import 'package:flutter/material.dart';

List<Map<String, String>> favoriteDoctors = [];

class CareScreen extends StatefulWidget {
  const CareScreen({super.key});

  @override
  State<CareScreen> createState() => _CareScreenState();
}

class _CareScreenState extends State<CareScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedSpecialty = '';
  String _searchQuery = '';

  final List<Map<String, String>> _doctors = [
    {
      "name": "Dr. Linda Thompson",
      "specialty": "Family Medicine",
      "reviews": "126",
      "rating": "4.9",
      "image": "assets/icons/dr_thompson.png"
    },
    {
      "name": "Dr. Asha Vali",
      "specialty": "Internal Medicine",
      "reviews": "96",
      "rating": "4.5",
      "image": "assets/icons/dr_vali.png"
    },
    {
      "name": "Dr. Raj Patel",
      "specialty": "Radiologist",
      "reviews": "143",
      "rating": "4.3",
      "image": "assets/icons/dr_patel.png"
    },
    {
      "name": "Dr. Elena Martinez",
      "specialty": "Cardiologist",
      "reviews": "198",
      "rating": "4.8",
      "image": "assets/icons/dr_martinez.png"
    },
    {
      "name": "Dr. Michael Anderson",
      "specialty": "Pediatrician",
      "reviews": "316",
      "rating": "5",
      "image": "assets/icons/dr_anderson.png"
    },
    {
      "name": "Dr. Jamal Yusuf",
      "specialty": "Oncologists",
      "reviews": "232",
      "rating": "4.2",
      "image": "assets/icons/dr_yusuf.png"
    },
  ];

  void _handleSearch(String query) {
    setState(() {
      _searchQuery = query.toLowerCase();
    });
  }

  void _openFilterSheet() {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        final specialties =
            _doctors.map((doc) => doc['specialty']!).toSet().toList();

        return ListView(
          padding: const EdgeInsets.all(16),
          children: specialties.map((specialty) {
            return ListTile(
              title: Text(specialty),
              trailing: _selectedSpecialty == specialty
                  ? const Icon(Icons.check, color: Colors.green)
                  : null,
              onTap: () {
                setState(() {
                  _selectedSpecialty =
                      _selectedSpecialty == specialty ? '' : specialty;
                });
                Navigator.pop(context);
              },
            );
          }).toList(),
        );
      },
    );
  }

  void _toggleFavorite(Map<String, String> doctor) {
    setState(() {
      final alreadyFavorited = favoriteDoctors.any(
          (fav) => fav['name'] == doctor['name']);
      if (alreadyFavorited) {
        favoriteDoctors.removeWhere((fav) => fav['name'] == doctor['name']);
      } else {
        favoriteDoctors.add(doctor);
      }
    });
  }

  bool _isFavorited(Map<String, String> doctor) {
    return favoriteDoctors.any((fav) => fav['name'] == doctor['name']);
  }

  void _onDoctorTapped(String name) {
    if (name.contains("Thompson") ||
        name.contains("Anderson") ||
        name.contains("Vali")) {
      Navigator.pushNamed(context, '/doctor-${name.toLowerCase().split(' ').last}');
    }
  }

  @override
  Widget build(BuildContext context) {
    final filteredDoctors = _doctors.where((doctor) {
      final matchesSearch = doctor['name']!
              .toLowerCase()
              .contains(_searchQuery) ||
          doctor['specialty']!.toLowerCase().contains(_searchQuery);
      final matchesFilter =
          _selectedSpecialty.isEmpty || doctor['specialty'] == _selectedSpecialty;
      return matchesSearch && matchesFilter;
    }).toList();

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Doctors',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _searchController,
                      onChanged: _handleSearch,
                      decoration: InputDecoration(
                        hintText: 'Search by doctor...',
                        prefixIcon: const Icon(Icons.search),
                        filled: true,
                        fillColor: const Color(0xFFF1EEFF),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  InkWell(
                    onTap: _openFilterSheet,
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xFFDDD9FF),
                      ),
                      child: const Icon(Icons.filter_alt, color: Colors.deepPurple),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Expanded(
                child: GridView.builder(
                  itemCount: filteredDoctors.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.78,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16,
                  ),
                  itemBuilder: (context, index) {
                    final doc = filteredDoctors[index];
                    final isFav = _isFavorited(doc);
                    return GestureDetector(
                      onTap: () => _onDoctorTapped(doc['name']!),
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Color(0xFFE4E1FF), Color(0xFFFFFFFF)],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.12),
                              blurRadius: 6,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          children: [
                            CircleAvatar(
                              backgroundImage: AssetImage(doc['image']!),
                              radius: 75,
                            ),
                            const SizedBox(height: 12),
                            Text(
                              doc['name']!,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              doc['specialty']!,
                              style: const TextStyle(color: Colors.black54),
                            ),
                            const SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Icons.star, size: 16, color: Colors.purple),
                                const SizedBox(width: 4),
                                Text(
                                  doc['rating']!,
                                  style: const TextStyle(fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(width: 4),
                                Text("(${doc['reviews']} reviews)"),
                              ],
                            ),
                            const SizedBox(height: 6),
                            GestureDetector(
                              onTap: () => _toggleFavorite(doc),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.favorite,
                                    size: 18,
                                    color: isFav ? Colors.red : Colors.grey,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    'Favorite',
                                    style: TextStyle(
                                      color: isFav ? Colors.red : Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ),
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
      ),
    );
  }
}
