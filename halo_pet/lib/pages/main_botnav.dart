import 'package:flutter/material.dart';
import 'package:halo_pet/pages/main/doctor_page.dart';
import 'package:halo_pet/pages/main/home_page.dart';
import 'package:halo_pet/pages/main/profilepage.dart';
import 'package:halo_pet/pages/main_topnav.dart';

class MainBotnav extends StatefulWidget {
  const MainBotnav({super.key});

  @override
  State<MainBotnav> createState() => _MainBotnavState();
}

class _MainBotnavState extends State<MainBotnav> {
  int _currentIndex = 0;
  
  final List<Widget> _pages = [
    const HomePage(),
    const MainTopnav(),
    const DoctorPage(),
    const Profilepage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.medical_services_outlined),
            activeIcon: Icon(Icons.medical_services),
            label: 'Medicines',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_search_outlined),
            activeIcon: Icon(Icons.person_search),
            label: 'Doctor'
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        backgroundColor: Colors.white,
        elevation: 8,
      ),
    );
  }
}