import 'package:flutter/material.dart';

class HospitalPage extends StatelessWidget {
  const HospitalPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
                    boxShadow: [BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      blurStyle: BlurStyle.normal,
                      blurRadius: 2,
                      offset: const Offset(3, 3),
                      spreadRadius: 2
                    )]
                  ),
                  height: 270,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(child: Image.asset('lib/assets/image/map_location_3.png')),
                        const Padding(
                          padding: EdgeInsets.only(top: 5, left: 20),
                          child: Text(
                            "RHS Dunia Kucing",
                            style: TextStyle(
                              fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(top: 5, left: 15),
                          child: Row(
                            children: [
                              Icon(Icons.pin_drop_outlined),
                              Text(
                                "Ruko Mitra Junction, Jl. Mitra Raya Blok J"
                              )
                            ],
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(top: 5, left: 20),
                          child: Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(right: 10),
                                child: Text(
                                  "5.0"
                                ),
                              ),
                              Icon(Icons.star, color: Color(0xFFFEB052),),
                              Icon(Icons.star, color: Color(0xFFFEB052),),
                              Icon(Icons.star, color: Color(0xFFFEB052),),
                              Icon(Icons.star, color: Color(0xFFFEB052),),
                              Icon(Icons.star, color: Color(0xFFFEB052),),
                              Text(
                                "(128 Reviews)"
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 15),
                          child: Row(
                            children: [
                              Icon(Icons.route, color: Colors.black.withOpacity(0.5),),
                              const Padding(
                                padding: EdgeInsets.only(left: 10),
                                child: Text(
                                  "2.5 km/40min"
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
            
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
                      boxShadow: [BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        blurStyle: BlurStyle.normal,
                        blurRadius: 2,
                        offset: const Offset(3, 3),
                        spreadRadius: 2
                      )]
                    ),
                    height: 270,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(child: Image.asset('lib/assets/image/map_location_1.png')),
                          const Padding(
                            padding: EdgeInsets.only(top: 5, left: 20),
                            child: Text(
                              "De'Chruse Pet Center Batam Centre",
                              style: TextStyle(
                                fontWeight: FontWeight.bold
                              ),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(top: 5, left: 15),
                            child: Row(
                              children: [
                                Icon(Icons.pin_drop_outlined),
                                Text(
                                  "Ruko Puri Loka, Blk.E No.3"
                                )
                              ],
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(top: 5, left: 20),
                            child: Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(right: 10),
                                  child: Text(
                                    "4.9"
                                  ),
                                ),
                                Icon(Icons.star, color: Color(0xFFFEB052),),
                                Icon(Icons.star, color: Color(0xFFFEB052),),
                                Icon(Icons.star, color: Color(0xFFFEB052),),
                                Icon(Icons.star, color: Color(0xFFFEB052),),
                                Icon(Icons.star, color: Color(0xFFFEB052),),
                                Text(
                                  "(58 Reviews)"
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 15),
                            child: Row(
                              children: [
                                Icon(Icons.route, color: Colors.black.withOpacity(0.5),),
                                const Padding(
                                  padding: EdgeInsets.only(left: 10),
                                  child: Text(
                                    "2.5 km/40min"
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
            
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
                      boxShadow: [BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        blurStyle: BlurStyle.normal,
                        blurRadius: 2,
                        offset: const Offset(3, 3),
                        spreadRadius: 2
                      )]
                    ),
                    height: 270,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(child: Image.asset('lib/assets/image/map_location_2.png')),
                          const Padding(
                            padding: EdgeInsets.only(top: 5, left: 20),
                            child: Text(
                              "Bruno Pet Clinic",
                              style: TextStyle(
                                fontWeight: FontWeight.bold
                              ),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(top: 5, left: 15),
                            child: Row(
                              children: [
                                Icon(Icons.pin_drop_outlined),
                                Text(
                                  "Ruko Puri Loka, Blk.E No.3"
                                )
                              ],
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(top: 5, left: 20),
                            child: Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(right: 10),
                                  child: Text(
                                    "4.9"
                                  ),
                                ),
                                Icon(Icons.star, color: Color(0xFFFEB052),),
                                Icon(Icons.star, color: Color(0xFFFEB052),),
                                Icon(Icons.star, color: Color(0xFFFEB052),),
                                Icon(Icons.star, color: Color(0xFFFEB052),),
                                Icon(Icons.star, color: Color(0xFFFEB052),),
                                Text(
                                  "(58 Reviews)"
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 15),
                            child: Row(
                              children: [
                                Icon(Icons.route, color: Colors.black.withOpacity(0.5),),
                                const Padding(
                                  padding: EdgeInsets.only(left: 10),
                                  child: Text(
                                    "2.5 km/40min"
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ], // Main Column
            ),
          ),
        ),
      ),
    );
  }
}
