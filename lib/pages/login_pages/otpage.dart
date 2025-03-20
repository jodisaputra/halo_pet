import 'package:flutter/material.dart';
import 'dart:async';

import 'package:halo_pet/pages/login_pages/success_page.dart';

class Otpage extends StatefulWidget {
  const Otpage({super.key});

  @override
  State<Otpage> createState() => _OtpageState();
}

class _OtpageState extends State<Otpage> {

  List<TextEditingController> controllers = List.generate(6, (_) => TextEditingController());
  List<FocusNode> focusNodes = List.generate(6, (_) => FocusNode());
  // ignore: unused_field
  late Timer _timer;
  int _start = 59; // Initial countdown value

  @override
  void initState() {
    super.initState();
    startTimer(); // Start the timer when the widget is initialized
  }


  @override
  void dispose() {
    // Dispose controllers and focus nodes to free resources
    for (var controller in controllers) {
      controller.dispose();
    }
    for (var focusNode in focusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_start == 0) {
        timer.cancel(); // Stop the timer when it reaches 0
      } else {
        setState(() {
          _start--;
        });
      }
    });
  }

  void resetTimer() {
    setState(() {
      _start = 59; // Reset the timer
    });
    startTimer(); // Restart the timer
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey.withOpacity(0.5)
                  ),
                  borderRadius: BorderRadius.circular(10)
                ),
                child: const Icon(Icons.keyboard_double_arrow_left_outlined),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 30, bottom: 10),
              child: Text(
                "Masukkan kode",
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 30,
                  fontWeight: FontWeight.bold
                ),
                ),
            ),

            const Text(
              'Kami telah mengirimkan SMS berisi kode aktivasi ke ponsel anda',
              style: TextStyle(
                fontSize: 16
              ),
              ),

            Padding(
              padding: const EdgeInsets.only(top: 40),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(6, (index) {
                    return Container(
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      width: 50,
                      height: 60,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey.withOpacity(0.5)
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: TextField(
                        controller: controllers[index],
                        focusNode: focusNodes[index],
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        maxLength: 1,
                        decoration: const InputDecoration(
                          counterText: '',
                          border: InputBorder.none
                        ),
                        onChanged: (value) {
                          if (value.isNotEmpty && index < 5) {
                           // Move to the next field if not empty and not the last field
                          FocusScope.of(context).requestFocus(focusNodes[index + 1]);
                          } else if (value.isEmpty && index > 0) {
                            // Move to the previous field if empty
                            FocusScope.of(context).requestFocus(focusNodes[index - 1]);
                          }
                        }
                      ),
                    );
                  }
                  ),
                )
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(top: 40, bottom: 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Kirim ulang kode",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black
                  ),
                  ),
                  Text(
                    " 00:${_start.toString().padLeft(2, '0')}",
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: ElevatedButton(
                      onPressed: _start == 0 ? resetTimer : null, // Disable button if timer is active
                      child: const Text("Kirim Ulang"),
                    ),
                  ),
                ],
              ),
            ),

            Center(
              child: GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SuccessPage()
                  )
                ),
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 27, 121, 199),
                    borderRadius: BorderRadius.circular(8)
                  ),
                  child: const Center(child: Text("Verifikasi", style: TextStyle(color: Colors.white, fontSize: 18),)),
                ),
              ),
            )
          ]
        )
      )
    );
  }
}