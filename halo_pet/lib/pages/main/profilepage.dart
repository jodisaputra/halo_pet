import 'package:flutter/material.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE9F0FE),
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
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  "Username",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ),
              const Text(
                "username@gmail.com",
                style: TextStyle(color: Colors.grey),
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
