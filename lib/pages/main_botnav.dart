import 'package:flutter/material.dart';
import 'package:halo_pet/pages/main/apointment_page.dart';
import 'package:halo_pet/pages/main/doctor_page.dart';
import 'package:halo_pet/pages/main/homepage.dart';
import 'package:halo_pet/pages/main/profilepage.dart';
import 'package:halo_pet/pages/main_topnav.dart';

class MainBotnav extends StatefulWidget {
  final int initialIndex;

  // Constructor with optional parameter for initial index
  const MainBotnav({super.key, this.initialIndex = 0});

  @override
  State<MainBotnav> createState() => _MainBotnavState();
}

class _MainBotnavState extends State<MainBotnav> {
  late int _currentIndex;

  final List<Widget> _pages = [
    const Homepage(),
    const MainTopnav(),
    const DoctorPage(),
    const ApointmentPage(),
    const Profilepage(),
  ];

  @override
  void initState() {
    super.initState();
    // Initialize current index with the provided initialIndex
    _currentIndex = widget.initialIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex], // Load selected page dynamically
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index; // Update the current index
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.medical_services),
            label: 'Medicines',
          ),
          BottomNavigationBarItem(
              icon:  Icon(Icons.person_search),
              label: 'Doctor'
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'Appointments',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        selectedItemColor: Colors.blue, // Highlight selected icon
        unselectedItemColor: Colors.grey, // Dim unselected icons
        type: BottomNavigationBarType.fixed, // Ensure all items are visible
      ),
    );
  }
}
