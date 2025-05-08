import 'package:flutter/material.dart';
import 'package:halo_pet/pages/sub_pages/doctor_detail.dart';

class DoctorPage extends StatelessWidget {
  const DoctorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: Text(
                  "Dokter",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 30),
                child: Container(
                  height: 45,
                  decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(8)),
                  child: const Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: TextField(
                        decoration: InputDecoration(
                            hintText: "Cari Dokter",
                            alignLabelWithHint: true,
                            icon: Icon(Icons.search),
                            hintStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: 14,
                            ),
                            border: InputBorder.none)),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "532 Ditemukan",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    Opacity(
                      opacity: 0.7,
                      child: Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(right: 5),
                            child: Text("Default"),
                          ),
                          Icon(
                            Icons.sort_sharp,
                            size: 14,
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const DoctorDetail()
                          )
                        ),
                        child: Container(
                          height: 133,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                  offset: const Offset(2, 3))
                            ],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 15),
                                child: Image.asset('lib/assets/image/doc_1.png'),
                              ),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text(
                                      'Dr.David Patel',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 7),
                                      child: Container(
                                        height: 1,
                                        color: Colors.grey.withOpacity(0.5),
                                      ),
                                    ),
                                    const Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 20),
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          'Ahli Gizi Hewan',
                                        ),
                                      ),
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.only(top: 7, left: 15),
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Row(
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.only(right: 5),
                                              child: Opacity(
                                                  opacity: 0.5,
                                                  child: Icon(
                                                    Icons.pin_drop_outlined,
                                                    size: 20,
                                                  )),
                                            ),
                                            Text('-')
                                          ],
                                        ),
                                      ),
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.only(top: 7, left: 15),
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Row(
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.only(right: 5),
                                              child: Opacity(
                                                  opacity: 0.5,
                                                  child: Icon(
                                                    Icons.star,
                                                    size: 20,
                                                    color: Color.fromARGB(
                                                        255, 255, 174, 0),
                                                  )),
                                            ),
                                            Opacity(
                                              opacity: 0.5,
                                              child: Text('5'),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 10),
                                              child: Opacity(
                                                opacity: 0.5,
                                                child: Text('|'),
                                              ),
                                            ),
                                            Text('1,872 Ulasan')
                                          ],
                                        ),
                                      ),
                                    ),
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
                          height: 133,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                  offset: const Offset(2, 3))
                            ],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 15),
                                child:
                                    Image.asset('lib/assets/image/doc_4.png'),
                              ),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text(
                                      'Dr.Jessica Turner',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 7),
                                      child: Container(
                                        height: 1,
                                        color: Colors.grey.withOpacity(0.5),
                                      ),
                                    ),
                                    const Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 20),
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          'Hewan Peliharaan',
                                        ),
                                      ),
                                    ),
                                    const Padding(
                                      padding:
                                          EdgeInsets.only(top: 7, left: 15),
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Row(
                                          children: [
                                            Padding(
                                              padding:
                                                  EdgeInsets.only(right: 5),
                                              child: Opacity(
                                                  opacity: 0.5,
                                                  child: Icon(
                                                    Icons.pin_drop_outlined,
                                                    size: 20,
                                                  )),
                                            ),
                                            Text('-')
                                          ],
                                        ),
                                      ),
                                    ),
                                    const Padding(
                                      padding:
                                          EdgeInsets.only(top: 7, left: 15),
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Row(
                                          children: [
                                            Padding(
                                              padding:
                                                  EdgeInsets.only(right: 5),
                                              child: Opacity(
                                                  opacity: 0.5,
                                                  child: Icon(
                                                    Icons.star,
                                                    size: 20,
                                                    color: Color.fromARGB(
                                                        255, 255, 174, 0),
                                                  )),
                                            ),
                                            Opacity(
                                              opacity: 0.5,
                                              child: Text('4,9'),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 10),
                                              child: Opacity(
                                                opacity: 0.5,
                                                child: Text('|'),
                                              ),
                                            ),
                                            Text('127 Ulasan')
                                          ],
                                        ),
                                      ),
                                    ),
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
                          height: 133,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                  offset: const Offset(2, 3))
                            ],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 15),
                                child:
                                    Image.asset('lib/assets/image/doc_3.png'),
                              ),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text(
                                      'Dr.Michael Jhonson',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 7),
                                      child: Container(
                                        height: 1,
                                        color: Colors.grey.withOpacity(0.5),
                                      ),
                                    ),
                                    const Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 20),
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          'Hewan Ternak',
                                        ),
                                      ),
                                    ),
                                    const Padding(
                                      padding:
                                          EdgeInsets.only(top: 7, left: 15),
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Row(
                                          children: [
                                            Padding(
                                              padding:
                                                  EdgeInsets.only(right: 5),
                                              child: Opacity(
                                                  opacity: 0.5,
                                                  child: Icon(
                                                    Icons.pin_drop_outlined,
                                                    size: 20,
                                                  )),
                                            ),
                                            Text('-')
                                          ],
                                        ),
                                      ),
                                    ),
                                    const Padding(
                                      padding:
                                          EdgeInsets.only(top: 7, left: 15),
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Row(
                                          children: [
                                            Padding(
                                              padding:
                                                  EdgeInsets.only(right: 5),
                                              child: Opacity(
                                                  opacity: 0.5,
                                                  child: Icon(
                                                    Icons.star,
                                                    size: 20,
                                                    color: Color.fromARGB(
                                                        255, 255, 174, 0),
                                                  )),
                                            ),
                                            Opacity(
                                              opacity: 0.5,
                                              child: Text('4,9'),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 10),
                                              child: Opacity(
                                                opacity: 0.5,
                                                child: Text('|'),
                                              ),
                                            ),
                                            Text('127 Ulasan')
                                          ],
                                        ),
                                      ),
                                    ),
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
                          height: 133,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                  offset: const Offset(2, 3))
                            ],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 15),
                                child:
                                    Image.asset('lib/assets/image/doc_5.png'),
                              ),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text(
                                      'Dr.Emily Walker',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 7),
                                      child: Container(
                                        height: 1,
                                        color: Colors.grey.withOpacity(0.5),
                                      ),
                                    ),
                                    const Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 20),
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          'Satwa Liar',
                                        ),
                                      ),
                                    ),
                                    const Padding(
                                      padding:
                                          EdgeInsets.only(top: 7, left: 15),
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Row(
                                          children: [
                                            Padding(
                                              padding:
                                                  EdgeInsets.only(right: 5),
                                              child: Opacity(
                                                  opacity: 0.5,
                                                  child: Icon(
                                                    Icons.pin_drop_outlined,
                                                    size: 20,
                                                  )),
                                            ),
                                            Text('-')
                                          ],
                                        ),
                                      ),
                                    ),
                                    const Padding(
                                      padding:
                                          EdgeInsets.only(top: 7, left: 15),
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Row(
                                          children: [
                                            Padding(
                                              padding:
                                                  EdgeInsets.only(right: 5),
                                              child: Opacity(
                                                  opacity: 0.5,
                                                  child: Icon(
                                                    Icons.star,
                                                    size: 20,
                                                    color: Color.fromARGB(
                                                        255, 255, 174, 0),
                                                  )),
                                            ),
                                            Opacity(
                                              opacity: 0.5,
                                              child: Text('4,9'),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 10),
                                              child: Opacity(
                                                opacity: 0.5,
                                                child: Text('|'),
                                              ),
                                            ),
                                            Text('127 Ulasan')
                                          ],
                                        ),
                                      ),
                                    ),
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
                          height: 133,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                  offset: const Offset(2, 3))
                            ],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 15),
                                child:
                                    Image.asset('lib/assets/image/doc_4.png'),
                              ),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text(
                                      'Dr.Jessica Turner',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 7),
                                      child: Container(
                                        height: 1,
                                        color: Colors.grey.withOpacity(0.5),
                                      ),
                                    ),
                                    const Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 20),
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          'Hewan Peliharaan',
                                        ),
                                      ),
                                    ),
                                    const Padding(
                                      padding:
                                          EdgeInsets.only(top: 7, left: 15),
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Row(
                                          children: [
                                            Padding(
                                              padding:
                                                  EdgeInsets.only(right: 5),
                                              child: Opacity(
                                                  opacity: 0.5,
                                                  child: Icon(
                                                    Icons.pin_drop_outlined,
                                                    size: 20,
                                                  )),
                                            ),
                                            Text('-')
                                          ],
                                        ),
                                      ),
                                    ),
                                    const Padding(
                                      padding:
                                          EdgeInsets.only(top: 7, left: 15),
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Row(
                                          children: [
                                            Padding(
                                              padding:
                                                  EdgeInsets.only(right: 5),
                                              child: Opacity(
                                                  opacity: 0.5,
                                                  child: Icon(
                                                    Icons.star,
                                                    size: 20,
                                                    color: Color.fromARGB(
                                                        255, 255, 174, 0),
                                                  )),
                                            ),
                                            Opacity(
                                              opacity: 0.5,
                                              child: Text('4,9'),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 10),
                                              child: Opacity(
                                                opacity: 0.5,
                                                child: Text('|'),
                                              ),
                                            ),
                                            Text('127 Ulasan')
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
