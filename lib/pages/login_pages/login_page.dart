import 'package:flutter/material.dart';
import 'package:halo_pet/pages/login_pages/otpage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String selectedCountry = "+62";

  final List<Map<String, dynamic>> countries = [
    {"code": "+62", "flag": "lib/assets/flags/ID.png"},
    {"code": "+1", "flag": "lib/assets/flags/US.png"},
    {"code": "+81", "flag": "lib/assets/flags/JP.png"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Padding(
            padding: const EdgeInsets.only(top: 50),
            child: Column(
              children: [
// Title
                const Padding(
                  padding: EdgeInsets.only(bottom: 25),
                  child: Text(
                    "Selamat Datang di Halopet!",
                    style: TextStyle(
                        fontFamily: 'Plus Jakarta Sans',
                        fontSize: 20,
                        fontWeight: FontWeight.w600),
                  ),
                ),

// Sub-Title
                const Text(
                  "Masuk atau buat akun baru",
                  style: TextStyle(
                      fontFamily: 'Plus Jakarta Sans',
                      fontSize: 15,
                      fontWeight: FontWeight.w400),
                ),

// Phone Number
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 30),
                  child: Container(
                    height: 40,
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 27, 121, 199),
                        borderRadius: BorderRadius.circular(8)),
                    child: const Center(
                      child: Text(
                        "Nomor HP",
                        style: TextStyle(
                            color: Color.fromARGB(255, 233, 233, 233)),
                      ),
                    ),
                  ),
                ),
// Row
// Drop Down Menu
                Row(
                  children: [
                    Container(
                      width: 120,
                      height: 57,
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: selectedCountry,
                          isExpanded: true,
                          items: countries.map((country) {
                            return DropdownMenuItem<String>(
                              value: country['code'],
                              child: Row(
                                children: [
                                  Image.asset(
                                    country['flag'],
                                    width: 24,
                                    height: 24,
                                    fit: BoxFit.cover,
                                  ),
                                  const SizedBox(width: 8),
                                  Text(country['code']),
                                ],
                              ),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedCountry = newValue!;
                            });
                          },
                          icon: const Icon(
                              Icons.arrow_drop_down), // Dropdown icon
                        ),
                      ),
                    ),
// Text Box
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: TextField(
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              hintText: "8123456789",
                              hintStyle: TextStyle(
                                  color: Colors.black.withOpacity(0.15)),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: const BorderSide(
                                      color: Colors.grey, width: 1))),
                        ),
                      ),
                    )
                  ],
                ),
// OTP Button
                GestureDetector(
                  onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Otpage()
                  )
                ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 30),
                    child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 27, 121, 199),
                          borderRadius: BorderRadius.circular(8)),
                      child: const Center(
                        child: Text(
                          "Kirim SMS OTP",
                          style: TextStyle(
                              color: Color.fromARGB(255, 233, 233, 233)),
                        ),
                      ),
                    ),
                  ),
                ),
// Google Login Button
                Container(
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey),
                  ),
                  child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Expanded(
                              child: Image.asset('lib/assets/image/google_icon.png'),
                            ),
                          ),
                          const Text(
                            "Continue with Google",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16
                            ),
                            ),
                        ],
                      )
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
