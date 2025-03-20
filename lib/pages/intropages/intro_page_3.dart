import 'package:flutter/material.dart';
import 'package:halo_pet/pages/intropages/intro_page_4.dart';

class IntroPage3 extends StatelessWidget {
  const IntroPage3({super.key});

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
              Image.asset('lib/assets/image/intro_page_3.png', height: 400),
// Title
              const Text("Informasi Tepat dan Cepat",
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
                  "Memberikan anda tentang kesehatan hewan peliharan anda secara instan dan mudah dimanapun anda berapa",
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
                    builder: (context) => const IntroPage4()
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