import 'package:flutter/material.dart';
import 'package:halo_pet/pages/main/doctor_page.dart';
import 'package:halo_pet/pages/main/profilepage.dart';
import 'package:halo_pet/pages/main_topnav.dart';
import 'package:halo_pet/pages/sub_pages/rabies_treatment.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE9F0FE),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 10),
          child: Column(
            children: [
// Top Section
              Padding(
                padding: const EdgeInsets.only(bottom: 50),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Stack(clipBehavior: Clip.none, children: [
                      Positioned(
                        top: 8,
                        left: 20,
                        child: Container(
                          width: 120,
                          height: 35,
                          decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 240, 240, 240),
                              border: Border.all(color: Colors.black),
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 2,
                                    blurRadius: 5,
                                    offset: const Offset(2, 3))
                              ]),
                          child: const Center(child: Text("Username")),
                        ),
                      ),
                      Positioned(
                        top: 8,
                        left: 5,
                        child: Container(
                          width: 34,
                          height: 34,
                          decoration: BoxDecoration(
                              color: Colors.grey.withOpacity(0.8),
                              borderRadius: BorderRadius.circular(17)),
                        ),
                      ),
                      GestureDetector(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Profilepage()
                          )
                        ),
                        child: Image.asset(
                          'lib/assets/image/profile_picture.png',
                          height: 46,
                        ),
                      ),
                    ]),
                    const Flexible(
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Icon(
                          Icons.pin_drop,
                          size: 35,
                          color: Colors.red,
                        ),
                      ),
                    )
                  ],
                ),
              ),
// Text
              const Padding(
                padding: EdgeInsets.only(bottom: 20),
                child: Text(
                  "Solusi Kesehatan Terlengkap",
                  style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 20,
                      fontWeight: FontWeight.w600),
                ),
              ),
// Sub-Text
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  "Chat dokter, kunjungi rumah sakit hewan, beli obat, cek lab dan update informasi seputar kesehatan peliharaan, semua bisa di HaloPet!",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontFamily: 'Poppins', fontSize: 13),
                ),
              ),
// Row
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const DoctorPage()
                          )
                      ),
                      child: Container(
                        width: 94,
                        height: 86,
                        decoration:
                            BoxDecoration(color: Colors.white, boxShadow: [
                          BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: const Offset(2, 3))
                        ]),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset('lib/assets/image/male_nurse.png'),
                            const Text(
                              "Chat Dokter",
                              style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600),
                            )
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const MainTopnav()
                          )
                        ),
                      child: Container(
                        width: 94,
                        height: 86,
                        decoration:
                            BoxDecoration(color: Colors.white, boxShadow: [
                          BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: const Offset(2, 3))
                        ]),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset('lib/assets/image/drugs.png'),
                            const Text(
                              "Toko Kesehatan",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600),
                            )
                          ],
                        ),
                      ),
                    ),
                    Container(
                      width: 94,
                      height: 86,
                      decoration:
                          BoxDecoration(color: Colors.white, boxShadow: [
                        BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: const Offset(2, 3))
                      ]),
                      child: GestureDetector(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const MainTopnav()
                          )
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset('lib/assets/image/hospital.png'),
                            const Text(
                              "RSH Sekitar",
                              style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(right: 25, left: 25, bottom: 30),
                child: Container(
                  height: 76,
                  decoration: BoxDecoration(color: Colors.white, boxShadow: [
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: const Offset(2, 3))
                  ]),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Image.asset(
                        'lib/assets/image/cross.png',
                        height: 33,
                      ),
                      const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(bottom: 5),
                            child: Text(
                              "Pantau kesehatan anabulmu",
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          Text(
                            "Pantau terus kesehatan anabulmu",
                            style: TextStyle(fontSize: 11),
                          ),
                          Text(
                            "dengan gampang dengan HaloPet!",
                            style: TextStyle(fontSize: 11),
                          )
                        ],
                      ),
                      const Icon(Icons.keyboard_arrow_right)
                    ],
                  ),
                ),
              ),
              Container(
                  color: Colors.white,
                  height: 250,
                  width: 342,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(left: 20),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "Layanan Khusus",
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,
                              fontSize: 13
                            ),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          GestureDetector(
                            onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const RabiesTreatment()
                          )
                            ),
                            child: SizedBox(
                              width: 70,
                              height: 70,
                              child: Column(
                                children: [
                                  Image.asset('lib/assets/image/rabies_test.png', height: 39,),
                                  const Text(
                                    "Perawatan Rabies",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w600,
                                      fontSize: 10
                                    ),
                                    )
                                ],
                              ),
                            ),
                          ),

                          GestureDetector(
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                            builder: (context) => const MainTopnav()
                              )
                            ),
                            child: SizedBox(
                              width: 70,
                              height: 70,
                              child: Column(
                                children: [
                                  Image.asset('lib/assets/image/vaksin.png', height: 39,),
                                  const Text(
                                    "Vaksinasi",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w600,
                                      fontSize: 10
                                    ),
                                    )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          GestureDetector(
                            onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const DoctorPage()
                          )
                            ),
                            child: SizedBox(
                              width: 70,
                              height: 70,
                              child: Column(
                                children: [
                                  Image.asset('lib/assets/image/calendar.png', height: 39,),
                                  const Text(
                                    "Buat Janji Dokter",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w600,
                                      fontSize: 10
                                    ),
                                    )
                                ],
                              ),
                            ),
                          ),

                          GestureDetector(
                            onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const DoctorPage()
                          )
                            ),    
                            child: SizedBox(
                              width: 70,
                              height: 70,
                              child: Column(
                                children: [
                                  Image.asset('lib/assets/image/nutrition.png', height: 39,),
                                  const Text(
                                    "Konsultasi gizi hewan",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w600,
                                      fontSize: 10
                                    ),
                                    )
                                ],
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  )
              )
            ],
          ),
        ),
      ),
    );
  }
}
