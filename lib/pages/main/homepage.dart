import 'package:flutter/material.dart';
import 'package:halo_pet/pages/main_topnav.dart';
import 'package:halo_pet/pages/sub_pages/rabies_treatment.dart';
import 'package:halo_pet/pages/main_botnav.dart';
import 'package:provider/provider.dart';
import 'package:halo_pet/services/auth_service.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  // Helper method for tab navigation
  void navigateToTab(BuildContext context, int tabIndex) {
    // Only navigate if we're not already in the MainBotnav
    if (Navigator.canPop(context)) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => MainBotnav(initialIndex: tabIndex),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Get AuthService from Provider
    final authService = Provider.of<AuthService>(context);

    // Get the current username, or use 'User' as fallback
    String username = authService.currentUser?.name ?? 'User';
    if (username.isNotEmpty) {
      username = username[0].toUpperCase() + username.substring(1);
    }

    return Scaffold(
      backgroundColor: const Color(0xFFE9F0FE),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top Section - Profile and Location
                buildProfileBar(context, username),

                const SizedBox(height: 24),

                // Welcome Message
                const Padding(
                  padding: EdgeInsets.only(bottom: 12),
                  child: Text(
                    "Solusi Kesehatan Terlengkap",
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF1B79C7),
                    ),
                  ),
                ),

                // Sub-Text
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 1,
                        blurRadius: 3,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: const Text(
                    "Chat dokter, kunjungi rumah sakit hewan, beli obat, cek lab dan update informasi seputar kesehatan peliharaan, semua bisa di HaloPet!",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 13,
                      height: 1.4,
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                // Main Services
                const Padding(
                  padding: EdgeInsets.only(left: 4, bottom: 8),
                  child: Text(
                    "Layanan Utama",
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),

                // Main Service Icons
                buildMainServices(context),

                const SizedBox(height: 24),

                // Health Monitoring Banner
                buildHealthMonitoringBanner(),

                const SizedBox(height: 24),

                // Special Services
                const Padding(
                  padding: EdgeInsets.only(left: 4, bottom: 8),
                  child: Text(
                    "Layanan Khusus",
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),

                // Special Services Grid
                buildSpecialServicesGrid(context),

                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildProfileBar(BuildContext context, String username) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            GestureDetector(
              onTap: () => navigateToTab(context, 4), // Navigate to Profile tab
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      spreadRadius: 1,
                      blurRadius: 3,
                      offset: const Offset(0, 1),
                    ),
                  ],
                ),
                child: CircleAvatar(
                  radius: 24,
                  backgroundColor: Colors.white,
                  child: ClipOval(
                    child: Image.asset(
                      'lib/assets/image/profile_picture.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 1,
                    blurRadius: 2,
                    offset: const Offset(0, 1),
                  ),
                ],
              ),
              child: Text(
                username, // Use the dynamic username here
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 1,
                blurRadius: 2,
                offset: const Offset(0, 1),
              ),
            ],
          ),
          child: const Icon(
            Icons.pin_drop,
            size: 24,
            color: Colors.red,
          ),
        ),
      ],
    );
  }

  Widget buildMainServices(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        buildServiceCard(
          context,
          'lib/assets/image/male_nurse.png',
          'Chat Dokter',
              () => navigateToTab(context, 2), // Navigate to Doctor tab (index 2)
        ),
        buildServiceCard(
          context,
          'lib/assets/image/drugs.png',
          'Toko Kesehatan',
              () => navigateToTab(context, 1), // Navigate to Medicines tab (index 1)
        ),
        buildServiceCard(
          context,
          'lib/assets/image/hospital.png',
          'RSH Sekitar',
              () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const MainTopnav()),
          ),
        ),
      ],
    );
  }

  Widget buildServiceCard(BuildContext context, String imagePath, String title, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.28,
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 1,
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              imagePath,
              height: 40,
            ),
            const SizedBox(height: 8),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontFamily: 'Poppins',
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildHealthMonitoringBanner() {
    return GestureDetector(
      onTap: () {
        // Add your action here
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF1B79C7), Color(0xFF3B92DD)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.4),
              spreadRadius: 1,
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 2,
                    offset: const Offset(0, 1),
                  ),
                ],
              ),
              child: Image.asset(
                'lib/assets/image/cross.png',
                height: 28,
                color: const Color(0xFF1B79C7),
              ),
            ),
            const SizedBox(width: 16),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Pantau kesehatan anabulmu",
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    "Pantau terus kesehatan anabulmu dengan gampang dengan HaloPet!",
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 11,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.keyboard_arrow_right,
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }

  Widget buildSpecialServicesGrid(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              buildSpecialServiceCard(
                context,
                'lib/assets/image/rabies_test.png',
                'Perawatan Rabies',
                    () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const RabiesTreatment()),
                ),
              ),
              buildSpecialServiceCard(
                context,
                'lib/assets/image/vaksin.png',
                'Vaksinasi',
                    () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MainTopnav()),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              buildSpecialServiceCard(
                context,
                'lib/assets/image/calendar.png',
                'Buat Janji Dokter',
                    () => navigateToTab(context, 3), // Navigate to Appointments tab (index 3)
              ),
              buildSpecialServiceCard(
                context,
                'lib/assets/image/nutrition.png',
                'Konsultasi gizi hewan',
                    () => navigateToTab(context, 2), // Navigate to Doctor tab (index 2)
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildSpecialServiceCard(BuildContext context, String imagePath, String title, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.38,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: const Color(0xFFF5F9FF),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            Image.asset(
              imagePath,
              height: 48,
            ),
            const SizedBox(height: 8),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}