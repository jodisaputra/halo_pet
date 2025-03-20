import 'package:flutter/material.dart';
import 'package:halo_pet/pages/main/doctor_page.dart';
import 'package:halo_pet/pages/sub_pages/new_apointment.dart';

class DoctorDetail extends StatelessWidget {
  const DoctorDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            children: [
//====================================================================================================================
//====================================================================================================================
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const DoctorPage())),
                        child: const Icon(
                          Icons.keyboard_arrow_left,
                          size: 30,
                        )),
//====================================================================================================================
                    const Text(
                      "Informasi Dokter",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
//====================================================================================================================
                    const Icon(Icons.chat_bubble_outline)
                  ],
                ),
              ),
//====================================================================================================================
//====================================================================================================================
              Container(
                height: 150,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: const Offset(2, 3))
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('lib/assets/image/doc_1.png'),
                      const Padding(
                        padding: EdgeInsets.only(left: 15),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Dr. David Patel",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              child: Text("Ahli gizi hewan"),
                            ),
                            Row(
                              children: [
                                Icon(Icons.pin_drop_outlined),
                                Text("Golden Cardiology Center")
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
//====================================================================================================================
//====================================================================================================================
// Details
              Padding(
                padding: const EdgeInsets.only(top: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
//====================================================================================================================
                    Column(
                      children: [
                        Container(
                          width: 70,
                          height: 70,
                          decoration: BoxDecoration(
                              color: const Color(0xFFF3F4F6),
                              borderRadius: BorderRadius.circular(35)),
                          child: const Icon(Icons.people, size: 35),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 2),
                          child: Text("2,000+"),
                        ),
                        const Text(
                          "Pasien",
                          style: TextStyle(color: Colors.grey),
                        )
                      ],
                    ),
//====================================================================================================================
                    Column(
                      children: [
                        Container(
                          width: 70,
                          height: 70,
                          decoration: BoxDecoration(
                              color: const Color(0xFFF3F4F6),
                              borderRadius: BorderRadius.circular(35)),
                          child: const Icon(Icons.military_tech, size: 35),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 2),
                          child: Text("10+"),
                        ),
                        const Text(
                          "Pengalaman",
                          style: TextStyle(color: Colors.grey),
                        )
                      ],
                    ),
//====================================================================================================================
                    Column(
                      children: [
                        Container(
                          width: 70,
                          height: 70,
                          decoration: BoxDecoration(
                              color: const Color(0xFFF3F4F6),
                              borderRadius: BorderRadius.circular(35)),
                          child: const Icon(Icons.star, size: 35),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 2),
                          child: Text("5"),
                        ),
                        const Text(
                          "Rating",
                          style: TextStyle(color: Colors.grey),
                        )
                      ],
                    ),
//====================================================================================================================
                    Column(
                      children: [
                        Container(
                          width: 70,
                          height: 70,
                          decoration: BoxDecoration(
                              color: const Color(0xFFF3F4F6),
                              borderRadius: BorderRadius.circular(35)),
                          child: const Icon(
                            Icons.chat_outlined,
                            size: 35,
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 2),
                          child: Text("1,872"),
                        ),
                        const Text(
                          "Ulasan",
                          style: TextStyle(color: Colors.grey),
                        )
                      ],
                    )
                  ],
                ),
              ),
//====================================================================================================================
//====================================================================================================================
              const Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: EdgeInsets.only(top: 20, bottom: 10),
                  child: Text(
                    "Tentang saya",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Text(
                "Dr. David Patel, seorang ahli gizi hewan yang berdedikasi, membawa banyak pengalaman ke Golden Gate Cardiology Center di Golden Gate, CA.",
                style: TextStyle(color: Colors.black.withOpacity(0.6)),
                textAlign: TextAlign.left,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "lihat selengkapnya",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black.withOpacity(0.6)),
                ),
              ),

              const Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: EdgeInsets.only(top: 20, bottom: 10),
                  child: Text(
                    "Working Time",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ),

              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Monday - Friday, 8:00 AM - 6:00 PM",
                  style: TextStyle(color: Colors.black.withOpacity(0.6)),
                  textAlign: TextAlign.left,
                ),
              ),

              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 20, bottom: 10),
                    child: Text(
                      "Reviews",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Opacity(
                    opacity: 0.6,
                    child: Text(
                      "See All",
                    ),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Row(
                  children: [
                    Image.asset('lib/assets/image/review_person_1.png'),
                    const Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Emily Anderson",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text("5.0"),
                              SizedBox(
                                width: 10,
                              ),
                              Icon(
                                Icons.star,
                                color: Color(0xFFFEB052),
                              ),
                              Icon(
                                Icons.star,
                                color: Color(0xFFFEB052),
                              ),
                              Icon(
                                Icons.star,
                                color: Color(0xFFFEB052),
                              ),
                              Icon(
                                Icons.star,
                                color: Color(0xFFFEB052),
                              ),
                              Icon(
                                Icons.star,
                                color: Color(0xFFFEB052),
                              ),
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              const Text(
                "Dr. Patel is a true professional who genuinely cares about his patients. I highly recommend Dr. Patel to",
                style: TextStyle(color: Color(0xFF9095A0)),
              ),

              Flexible(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: GestureDetector(
                      onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const NewApointment()
                      )
                      ),
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                            color: const Color(0xFF0174CE),
                            borderRadius: BorderRadius.circular(25)),
                        child: const Align(
                          alignment: Alignment.center,
                          child: Text(
                            "Buat Janji Dengan Dokter",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16
                            ),
                            ),
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ), //Main Column
        ),
      ),
    );
  }
}
