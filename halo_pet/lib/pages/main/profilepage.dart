import 'package:flutter/material.dart';
import 'package:halo_pet/pages/login_pages/login_page.dart';

class Profilepage extends StatefulWidget {
  const Profilepage({super.key});

  @override
  State<Profilepage> createState() => _ProfilepageState();
}

class _ProfilepageState extends State<Profilepage> {
  String? selectedGender;
  final List<String> gender = ['Male', 'Female', 'Other'];
  final TextEditingController _dateController = TextEditingController();
  String _profileImage = 'lib/assets/image/profile_picture.png';

  @override
  void dispose() {
    _dateController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null) {
      setState(() {
        _dateController.text = "${pickedDate.toLocal()}".split(' ')[0];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FB),
      body: Stack(
        children: [
          // Cover Image
          Container(
            height: 180,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('lib/assets/image/cover.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Main Content
          SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 120),
                // Avatar
                Center(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        // Dummy: Toggle between two local images
                        _profileImage = _profileImage == 'lib/assets/image/profile_picture.png'
                            ? 'lib/assets/image/profile_picture2.png'
                            : 'lib/assets/image/profile_picture.png';
                      });
                    },
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          width: 110,
                          height: 110,
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
                        Image.asset(
                          _profileImage,
                          height: 90,
                        ),
                        Positioned(
                          bottom: 8,
                          right: 8,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              shape: BoxShape.circle,
                            ),
                            padding: const EdgeInsets.all(4),
                            child: const Icon(Icons.camera_alt, color: Colors.white, size: 18),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                // Username & Email
                const Text(
                  "Username",
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  "username@gmail.com",
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    color: Colors.grey,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 24),
                // Info Card
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                    elevation: 2,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 18),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Personal Information",
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 18),
                          // First Name
                          TextField(
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.grey[100],
                              hintText: "Masukkan nama pertama anda",
                              hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide.none,
                              ),
                              prefixIcon: const Icon(Icons.person_outline),
                            ),
                          ),
                          const SizedBox(height: 14),
                          // Last Name
                          TextField(
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.grey[100],
                              hintText: "Masukkan nama terakhirmu",
                              hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide.none,
                              ),
                              prefixIcon: const Icon(Icons.person_outline),
                            ),
                          ),
                          const SizedBox(height: 14),
                          // Phone
                          TextField(
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.grey[100],
                              hintText: "Nomor telepon",
                              hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide.none,
                              ),
                              prefixIcon: const Icon(Icons.phone_outlined),
                            ),
                          ),
                          const SizedBox(height: 14),
                          // Gender
                          DropdownButtonFormField<String>(
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.grey[100],
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide.none,
                              ),
                              prefixIcon: const Icon(Icons.wc_outlined),
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
                                selectedGender = value;
                              });
                            },
                            hint: const Text(
                              "Choose Gender",
                              style: TextStyle(color: Colors.grey, fontSize: 14),
                            ),
                          ),
                          const SizedBox(height: 14),
                          // Date of Birth
                          TextField(
                            controller: _dateController,
                            readOnly: true,
                            decoration: InputDecoration(
                              hintText: "Tanggal Lahir",
                              hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
                              filled: true,
                              fillColor: Colors.grey[100],
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide.none,
                              ),
                              prefixIcon: const Icon(Icons.cake_outlined),
                              suffixIcon: const Icon(Icons.calendar_today),
                            ),
                            onTap: () => _selectDate(context),
                          ),
                          const SizedBox(height: 24),
                          // Update Profile Button
                          SizedBox(
                            width: double.infinity,
                            height: 48,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF0601B4),
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              onPressed: () {},
                              child: const Text(
                                "Update Profile",
                                style: TextStyle(fontSize: 15, fontFamily: 'Poppins'),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 32),
                // Logout Button
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(builder: (context) => const LoginPage()),
                          (route) => false,
                        );
                      },
                      child: const Text(
                        'Logout',
                        style: TextStyle(fontSize: 15, fontFamily: 'Poppins'),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 32),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
