import 'package:flutter/material.dart';
import 'package:halo_pet/pages/main_botnav.dart';

class SuccessPage extends StatelessWidget {
  const SuccessPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Center(
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 40),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("Halo", style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.bold, fontSize: 24),),
                    Text("Pet", style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.bold, fontSize: 24, color: Colors.blue),),
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(top: 200, bottom: 30),
                child: Image.asset("lib/assets/image/login_success.png", height: 100),
              ),

              const Text("Verifikasi Berhasil", style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
              const Padding(
                padding: EdgeInsets.only(top: 10, bottom: 80),
                child: Text(
                  "Anda telah menyelesaikan verifikasi dan pindah ke dashboard", 
                  style: TextStyle(
                    fontSize: 13,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),

              Center(
              child: GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MainBotnav()
                  )
                ),
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 25, 111, 182),
                    borderRadius: BorderRadius.circular(8)
                  ),
                  child: const Center(child: Text("Selanjutnya", style: TextStyle(color: Colors.white, fontSize: 18),)),
                ),
              ),
            )
            ],
          ),
        ),
      )
    );
  }
}