import 'package:flutter/material.dart';
import 'package:halo_pet/pages/login_pages/login_page.dart';

class IntroPage4 extends StatelessWidget {
  const IntroPage4({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
// Image
              Image.asset('lib/assets/image/intro_page_4.png', height: 400),
// Title
              const Text("Dapatkan obat secara cepat",
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 20,
                  fontWeight: FontWeight.bold
                ),
              ),
// Sub-Title
              const Padding(
                padding: EdgeInsets.only(top: 20),
                child: Text(
                  "Dapatkan obat  dan rekomendasi dokter untuk hewan peliharaanmu dimana pun anda berada",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 15
                  ),
                  ),
              ),
// button
                Padding(
              padding: const EdgeInsets.only(top: 50),
              child: GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LoginPage()
                  )
                ),
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: Colors.blue,
                  ),
                  child: const Icon(
                    Icons.keyboard_double_arrow_right,
                    color: Colors.white,
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