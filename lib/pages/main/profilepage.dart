import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../services/auth_service.dart';
import '../login_pages/login_page.dart';

class Profilepage extends StatefulWidget {
  const Profilepage({super.key});

  @override
  State<Profilepage> createState() => _ProfilepageState();
}

class _ProfilepageState extends State<Profilepage> {
  String? selectedGender;
  final List<String> gender = ['Male', 'Female', 'Other'];
  final TextEditingController _dateController = TextEditingController();

  @override
  void dispose() {
    _dateController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(), // Default date
      firstDate: DateTime(1900), // Earliest date
      lastDate: DateTime(2100), // Latest date
    );

    if (pickedDate != null) {
      setState(() {
        // Update the TextField with the selected date
        _dateController.text = "${pickedDate.toLocal()}".split(' ')[0];
      });
    }
  }

  // Function to handle logout
  Future<void> _logout() async {
    final authService = Provider.of<AuthService>(context, listen: false);
    final result = await authService.logout();

    // Navigate to login screen using MaterialPageRoute instead of named route
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const LoginPage()),
    );

    // Still show a message if there was an error for debugging purposes
    if (!result['success']) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(result['message']))
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Get the current user from AuthService
    final authService = Provider.of<AuthService>(context);
    final currentUser = authService.currentUser;

    return Scaffold(
      backgroundColor: const Color(0xFFE9F0FE),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false, // This removes the back button
        title: const Text(
          'My Profile',
          style: TextStyle(
            color: Color(0xFF0601B4),
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          // Add logout button to app bar
          IconButton(
            onPressed: _logout,
            icon: const Icon(Icons.logout, color: Color(0xFF0601B4)),
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 30),
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Positioned(
                      top: 12,
                      left: 5,
                      child: Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: Colors.grey.withOpacity(0.2)),
                      ),
                    ),
                    Image.asset(
                      'lib/assets/image/profile_picture.png',
                      height: 62,
                    ),
                  ],
                ),
              ),
              // Display the current user's name instead of static "Username"
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  currentUser?.name ?? "Username",
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ),
              // Display the current user's email instead of static email
              Text(
                currentUser?.email ?? "username@gmail.com",
                style: const TextStyle(color: Colors.grey),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 40, bottom: 20),
                child: TextField(
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: "Masukkan nama pertama anda",
                        hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
                        border: InputBorder.none)),
              ),
              const Padding(
                padding: EdgeInsets.only(bottom: 20),
                child: TextField(
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: "Masukkan nama terakhirmu",
                        hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
                        border: InputBorder.none)),
              ),
              const Padding(
                padding: EdgeInsets.only(bottom: 20),
                child: TextField(
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: "Nomor telepon",
                        hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
                        border: InputBorder.none)),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: DropdownButtonFormField<String>(
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    filled: true,
                    fillColor: Colors.white, // Background color
                  ),
                  value: selectedGender,
                  items: gender.map((gender) {
                    return DropdownMenuItem<String>(
                      value: gender,
                      child: Text(gender),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedGender = value; // Update selected gender
                    });
                  },
                  hint: const Text(
                    "Choose Gender",
                    style: TextStyle(color: Colors.grey, fontSize: 14),
                  ),
                ),
              ),
              TextField(
                controller: _dateController,
                readOnly: true,
                decoration: const InputDecoration(
                  hintText: "Tanggal Lahir",
                  hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
                  border: InputBorder.none,
                  filled: true,
                  fillColor: Colors.white,
                  suffixIcon: Icon(Icons.calendar_today),
                ),
                onTap: () => _selectDate(context),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 45),
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                          color: const Color(0xFF0601B4),
                          borderRadius: BorderRadius.circular(14)),
                      child: const Center(
                          child: Text(
                            "Update Profile",
                            style: TextStyle(color: Colors.white, fontSize: 14),
                          )),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}