import 'package:flutter/material.dart';

class ApointmentPage extends StatelessWidget {
  const ApointmentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 40),
                child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                // Back Button
                    const Icon(Icons.keyboard_arrow_left_outlined, size: 40,),
                // Message Notification
                    Container(
                      height: 25,
                      width: 68,
                      decoration: BoxDecoration(
                        color: Colors.grey[600],
                        borderRadius: BorderRadius.circular(6)
                      ),
                      child: const Center(
                        child: Text(
                          "1 Pesan",
                          style: TextStyle(
                            color: Colors.white
                          ),
                        )
                      ),
                    )
                  ],
                ),
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "HARI INI",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 16
                    ),
                  ),
                  Text(
                    "Tandai sudah dibaca",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Image.asset('lib/assets/image/calendar-tick.png', height: 60,),
                    const SizedBox(
                      width: 266,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Janji Medis Berhasil',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16
                                ),
                              ),
                              Text(
                                "1j",
                                style: TextStyle(
                                  color: Colors.grey
                                ),
                                )
                            ],
                          ),
                          Text(
                            'Kamu telah berhasil membuat janji medis dengan Dr.--',
                            softWrap: true,
                            style: TextStyle(
                              color: Colors.grey
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(top: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Image.asset('lib/assets/image/calendar-remove.png', height: 60,),
                    const SizedBox(
                      width: 266,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Janji Medis Dibatalkan',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16
                                ),
                              ),
                              Text(
                                "2j",
                                style: TextStyle(
                                  color: Colors.grey
                                ),
                                )
                            ],
                          ),
                          Text(
                            'Kamu telah berhasil membatalkan janji medis dengan Dr.--',
                            softWrap: true,
                            style: TextStyle(
                              color: Colors.grey
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(top: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Image.asset('lib/assets/image/calendar-edit.png', height: 60,),
                    const SizedBox(
                      width: 266,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Perubahan Jadwal',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16
                                ),
                              ),
                              Text(
                                "8j",
                                style: TextStyle(
                                  color: Colors.grey
                                ),
                                )
                            ],
                          ),
                          Text(
                            'Kamu telah berhasil mengubah jadwal janji medis dengan Dr.--',
                            softWrap: true,
                            style: TextStyle(
                              color: Colors.grey
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),

              const Padding(
                padding: EdgeInsets.only(top: 40),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "KEMARIN",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 16
                      ),
                    ),
                    Text(
                      "Tandai sudah dibaca",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14
                      ),
                    ),
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(top: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Image.asset('lib/assets/image/calendar-tick.png', height: 60,),
                    const SizedBox(
                      width: 266,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Janji Medis Berhasil',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16
                                ),
                              ),
                              Text(
                                "1h",
                                style: TextStyle(
                                  color: Colors.grey
                                ),
                                )
                            ],
                          ),
                          Text(
                            'Kamu telah berhasil membuat janji medis dengan Dr.--',
                            softWrap: true,
                            style: TextStyle(
                              color: Colors.grey
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      )
    );
  }
}