import 'package:flutter/material.dart';
import 'package:halo_pet/pages/main/homepage.dart';
import 'package:table_calendar/table_calendar.dart';

class NewApointment extends StatefulWidget {
  const NewApointment({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _NewApointmentState createState() => _NewApointmentState();
}

class _NewApointmentState extends State<NewApointment> {
  DateTime _selectedDate = DateTime.now();
  final List<String> _timeSlots = [
    "09:00 AM", "09:30 AM", "10:00 AM",
    "10:30 AM", "11:00 AM", "11:30 AM",
    "03:00 PM", "03:30 PM", "04:00 PM",
    "04:30 PM", "05:00 PM", "05:30 PM",
  ];
  String? _selectedTime;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text('Pilih Tanggal'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Calendar Widget
            TableCalendar(
              focusedDay: _selectedDate,
              firstDay: DateTime(2000),
              lastDay: DateTime(2100),
              selectedDayPredicate: (day) {
                return isSameDay(_selectedDate, day);
              },
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  _selectedDate = selectedDay;
                });
              },
              calendarStyle: CalendarStyle(
                todayDecoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.8),
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(10)
                ),
                selectedDecoration: BoxDecoration(
                  color: const Color(0xFF1C2A3A),
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(10)
                ),
                defaultDecoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(10)
                ),
                weekendDecoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(10)
                ),
              ),
              headerStyle: const HeaderStyle(
                titleCentered: true,
                formatButtonVisible: false,
              ),
            ),

            const SizedBox(height: 20),

            // Time Slot Section
            const Text(
              "Pilih Jam",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 10),

            // Time Slots Grid
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 2.5,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: _timeSlots.length,
                itemBuilder: (context, index) {
                  final time = _timeSlots[index];
                  final isSelected = time == _selectedTime;

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedTime = time;
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: isSelected ? const Color(0xFF1C2A3A) : Colors.grey[200],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        time,
                        style: TextStyle(
                          color: isSelected ? Colors.white : Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            // Confirmation Button
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context, 
                      builder: (BuildContext context) {
                        return Dialog(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                CircleAvatar(
                                  radius: 40,
                                  backgroundColor: Colors.green.withOpacity(0.1),
                                  child: const Icon(
                                    Icons.check_circle,
                                    size: 60,
                                    color: Colors.green,
                                  ),
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                                const Text(
                                  "Selamat!",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 8,),
                                Text(
                                  "Janji temu dengan Dr.- pada tanggal -- sudah berhasil.",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey[600],
                                  ),
                                ),
                                const SizedBox(height: 24,),
                                
                                ElevatedButton(
                                  onPressed: () {
                                  Navigator.push(
                                    context, 
                                    MaterialPageRoute(
                                      builder: (context) => const Homepage()
                                      )
                                    );// Close the dialog
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF1C2A3A),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                ),
                                child: const Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                                  child: Text(
                                    "Lanjut",
                                    style: TextStyle(fontSize: 16, color: Colors.white),
                                  ),
                                ),
                              ),
                              ],
                            ),
                          ),
                        );
                      }
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1C2A3A),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(80),
                    ),
                  ),
                  child: const Text(
                    "Konfirmasi",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white
                      ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
