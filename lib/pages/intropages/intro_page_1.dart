import 'package:flutter/material.dart';
import 'package:halo_pet/pages/intropages/intro_page_2.dart';


class IntroPage1 extends StatelessWidget {
  const IntroPage1({super.key});

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
// Logo
            Padding(
              padding: const EdgeInsets.only(bottom: 80),
              child:
                  Image.asset('lib/assets/image/logo_transparant_2.png', height: 170),
            ),
// Logo Text
            const Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Halo",
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.bold,
                    fontSize: 36,
                  )
                ),
                Text("Pet",
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.bold,
                    fontSize: 36,
                    color: Colors.blue
                  )
                ),
              ],
            ),
// Button
            Padding(
              padding: const EdgeInsets.only(top: 30),
              child: GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const IntroPage2()
                  )
                ),
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                    border: Border.all(
                      color: Colors.black
                    )
                  ),
                  child: const Icon(
                    Icons.arrow_right_alt,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    ));
  }
}
