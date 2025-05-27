import 'package:flutter/material.dart';
import 'package:halo_pet/pages/main/apointment_page.dart';
import 'package:halo_pet/pages/main/profilepage.dart';
import 'package:halo_pet/pages/sub_pages/hospital_page.dart';
import 'package:halo_pet/pages/main/medicine_page.dart';
import 'package:halo_pet/pages/sub_pages/shop_page.dart';
import 'package:halo_pet/services/api_service.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? firstName;
  String? lastName;
  File? _pickedImage;
  String _profileImage = 'lib/assets/image/profile_picture.png';

  @override
  void initState() {
    super.initState();
    _loadProfileImage();
  }

  Future<void> _loadProfileImage() async {
    final user = await ApiService.getUser();
    if (user != null) {
      if (!mounted) return;
      setState(() {
        firstName = user['first_name'];
        lastName = user['last_name'];
        if (user['profile_image'] != null && user['profile_image'].toString().isNotEmpty) {
          _profileImage = user['profile_image'];
        }
      });
    }
  }

  Future<void> _pickImage() async {
    final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picked != null) {
      if (!mounted) return;
      setState(() {
        _pickedImage = File(picked.path);
      });
      
      try {
        final response = await ApiService.updateProfile(
          firstName: firstName ?? '',
          lastName: lastName,
          imageFile: _pickedImage,
        );
        
        if (response['message'] == 'Profile updated successfully') {
          await _loadProfileImage();
          if (!mounted) return;
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Profile image updated successfully'),
              backgroundColor: Colors.green,
            ),
          );
        }
      } catch (e) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to update profile image: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: HomeContent(
        firstName: firstName,
        lastName: lastName,
        pickedImage: _pickedImage,
        profileImage: _profileImage,
        onProfileTap: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const Profilepage()
            )
          );
          _loadProfileImage();
        },
        onImagePick: _pickImage,
      ),
    );
  }
}

class HomeContent extends StatefulWidget {
  final String? firstName;
  final String? lastName;
  final File? pickedImage;
  final String profileImage;
  final Function() onProfileTap;
  final Function() onImagePick;

  const HomeContent({
    super.key,
    this.firstName,
    this.lastName,
    this.pickedImage,
    required this.profileImage,
    required this.onProfileTap,
    required this.onImagePick,
  });

  @override
  State<HomeContent> createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  Future<void> _refreshHomeData() async {
    if (mounted) {
      setState(() {});
    }
  }

  Future<List<dynamic>> _fetchUpcomingAppointments() async {
    try {
      final appointments = await ApiService().getAppointments();
      print('Appointments from API: ' + appointments.toString());
      // Filter for today and future
      final now = DateTime.now();
      final today = DateTime(now.year, now.month, now.day);
      final filtered = appointments.where((a) {
        final date = DateTime.tryParse(a['appointment_date'] ?? '') ?? today;
        final slotDate = DateTime(date.year, date.month, date.day);
        return slotDate.isAtSameMomentAs(today) || slotDate.isAfter(today);
      }).toList();
      print('Filtered upcoming appointments: ' + filtered.toString());
      return filtered;
    } catch (e) {
      throw Exception('Failed to load appointments: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: RefreshIndicator(
        onRefresh: _refreshHomeData,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header with Profile Icon
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 8),
                        const Text(
                          'Hello,',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                        ),
                        Text(
                          widget.firstName != null && widget.firstName!.isNotEmpty
                              ? "${widget.firstName} ${widget.lastName ?? ''}"
                              : "Pet Owner!",
                          style: const TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: widget.onProfileTap,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.08),
                                  blurRadius: 8,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                          ),
                          widget.pickedImage != null
                            ? ClipOval(child: Image.file(widget.pickedImage!, height: 46, width: 46, fit: BoxFit.cover))
                            : (widget.profileImage.startsWith('http')
                                ? ClipOval(child: Image.network(widget.profileImage, height: 46, width: 46, fit: BoxFit.cover))
                                : ClipOval(child: Image.asset(widget.profileImage, height: 46, width: 46, fit: BoxFit.cover))),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                // Search Bar
                Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFFF5FAF7),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  child: Row(
                    children: [
                      Icon(Icons.search, color: Colors.grey[500]),
                      const SizedBox(width: 8),
                      Expanded(
                        child: TextField(
                          decoration: const InputDecoration(
                            hintText: 'Search for services...',
                            border: InputBorder.none,
                          ),
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),
                // Services Section
                const Text(
                  'Our Services',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                GridView.count(
                  crossAxisCount: 2,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  childAspectRatio: 1.2,
                  children: [
                    _serviceCard(
                      icon: Icons.local_hospital,
                      title: 'Hospital',
                      color: const Color(0xFFD6E7FF),
                      iconColor: Colors.blue,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const HospitalPage(isSubPage: true)),
                        );
                      },
                    ),
                    _serviceCard(
                      icon: Icons.medical_services,
                      title: 'Pharmacy',
                      color: const Color(0xFFE3FCE1),
                      iconColor: Colors.green,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const MedicineTabView()),
                        );
                      },
                    ),
                    _serviceCard(
                      icon: Icons.pets,
                      title: 'Pet Shop',
                      color: const Color(0xFFFFF2D9),
                      iconColor: Colors.orange,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const ShopPage(isSubPage: true)),
                        );
                      },
                    ),
                    _serviceCard(
                      icon: Icons.calendar_month,
                      title: 'Appointment',
                      color: const Color(0xFFF3E6FF),
                      iconColor: Colors.purple,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const ApointmentPage()),
                        );
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 32),
                // Upcoming Appointments (from API)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Upcoming Appointments',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const ApointmentPage()),
                        );
                      },
                      child: const Text(
                        'See All',
                        style: TextStyle(
                          color: Colors.blue,
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                FutureBuilder<List<dynamic>>(
                  future: _fetchUpcomingAppointments(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const Center(child: Text('No upcoming appointments.'));
                    }
                    final appointments = snapshot.data!;
                    return Column(
                      children: appointments.take(3).map<Widget>((a) {
                        return Container(
                          margin: const EdgeInsets.only(bottom: 12),
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.05),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: Colors.blue.withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: const Icon(Icons.calendar_today, color: Colors.blue),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          a['doctor']?['name'] ?? 'Doctor',
                                          style: const TextStyle(
                                            fontFamily: 'Poppins',
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          a['doctor']?['specialty'] ?? '',
                                          style: const TextStyle(
                                            fontFamily: 'Poppins',
                                            fontSize: 14,
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16),
                              const Divider(),
                              const SizedBox(height: 16),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: _buildAppointmentInfo(
                                      icon: Icons.access_time,
                                      text: a['appointment_time'] != null
                                        ? DateFormat('HH:mm').format(DateTime.tryParse(a['appointment_time']) ?? DateTime.now())
                                        : '',
                                    ),
                                  ),
                                  Expanded(
                                    child: _buildAppointmentInfo(
                                      icon: Icons.calendar_today,
                                      text: a['appointment_date'] != null
                                        ? DateFormat('d MMM yyyy').format(DateTime.tryParse(a['appointment_date']) ?? DateTime.now())
                                        : '',
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _serviceCard({
    required IconData icon,
    required String title,
    required Color color,
    required Color iconColor,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: iconColor, size: 40),
            const SizedBox(height: 12),
            Text(
              title,
              style: TextStyle(
                color: iconColor,
                fontWeight: FontWeight.w600,
                fontSize: 16,
                fontFamily: 'Poppins',
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAppointmentInfo({
    required IconData icon,
    required String text,
  }) {
    return Row(
      children: [
        Icon(icon, size: 16, color: Colors.grey[600]),
        const SizedBox(width: 4),
        Text(
          text,
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 14,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }
} 