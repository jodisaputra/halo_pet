import 'package:flutter/material.dart';

class RabiesTreatment extends StatelessWidget {
  const RabiesTreatment({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            children: [
// Title
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: Text(
                  "Perawatan Rabies",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                ),
              ),
// Doctor pick
// 1
              Container(
                height: 250,
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: const Offset(2, 3))
                    ],
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        "May 22 2023 - 10:00 AM",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        child: Container(
                          height: 1,
                          color: Colors.grey,
                        ),
                      ),
                      Row(
                        children: [
                          Image.asset('lib/assets/image/doc_1.png'),
                          const Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(bottom: 10),
                                  child: Text(
                                    "Dr. James Robinson",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(bottom: 10),
                                  child: Text("Perawatan Rabies"),
                                ),
                                Row(
                                  children: [
                                    Icon(Icons.pin_drop_outlined),
                                    Text("Elite Ortho Clinic, USA")
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        child: Container(
                          height: 1,
                          color: Colors.grey,
                        ),
                      ),
                      Container(
                        height: 30,
                        decoration: BoxDecoration(
                            color: const Color(0xFF1C2A3A),
                            borderRadius: BorderRadius.circular(15)),
                        child: const Align(
                          alignment: Alignment.center,
                          child: Text(
                            "Atur Jadwal",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      )
                    ], // Main Column
                  ),
                ),
              ),


// 2
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Container(
                  height: 250,
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: const Offset(2, 3))
                      ],
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          "June 14 2023 - 03:00 PM",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          child: Container(
                            height: 1,
                            color: Colors.grey,
                          ),
                        ),
                        Row(
                          children: [
                            Image.asset('lib/assets/image/doc_2.png'),
                            const Padding(
                              padding: EdgeInsets.only(left: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(bottom: 10),
                                    child: Text(
                                      "Dr. Daniel Lee",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(bottom: 10),
                                    child: Text("Perawatan Rabies"),
                                  ),
                                  Row(
                                    children: [
                                      Icon(Icons.pin_drop_outlined),
                                      Text("Digestive Institute, USA")
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          child: Container(
                            height: 1,
                            color: Colors.grey,
                          ),
                        ),
                        Container(
                          height: 30,
                          decoration: BoxDecoration(
                              color: const Color(0xFF1C2A3A),
                              borderRadius: BorderRadius.circular(15)),
                          child: const Align(
                            alignment: Alignment.center,
                            child: Text(
                              "Atur Jadwal",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        )
                      ], // Main Column
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
