import 'package:flutter/material.dart';
import 'package:halo_pet/pages/main/home_page.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:halo_pet/services/api_service.dart';
import 'package:intl/intl.dart';
import 'package:halo_pet/pages/main_botnav.dart';
import 'dart:convert';

class NewAppointment extends StatefulWidget {
  final int doctorId;
  const NewAppointment({super.key, required this.doctorId});

  @override
  _NewAppointmentState createState() => _NewAppointmentState();
}

class _NewAppointmentState extends State<NewAppointment> {
  DateTime _selectedDate = DateTime.now();
  DateTime? _selectedTime;
  bool _isLoading = false;
  List<Map<String, String>> _availableTimeSlots = [];
  String? _error;

  @override
  void initState() {
    super.initState();
    print('Debug: NewAppointment initialized with doctor ID: ${widget.doctorId}');
    _loadAvailableTimeSlots();
  }

  Future<void> _loadAvailableTimeSlots() async {
    if (!mounted) return;

    setState(() {
      _isLoading = true;
      _error = null;
      _availableTimeSlots = [];
    });

    try {
      print('Debug: Loading time slots for date: ${_selectedDate.toString()}');
      final dateStr = DateFormat('yyyy-MM-dd').format(_selectedDate);
      print('Debug: Formatted date: $dateStr');
      print('Debug: Doctor ID: ${widget.doctorId}');
      
      final slots = await ApiService().getAvailableTimeSlots(widget.doctorId, dateStr);
      print('Debug: Received time slots: $slots');
      
      if (!mounted) return;
      
      setState(() {
        _availableTimeSlots = slots;
        _isLoading = false;
      });
    } catch (e) {
      print('Debug: Error loading time slots: $e');
      if (!mounted) return;
      
      setState(() {
        _error = 'Failed to load time slots: ${e.toString()}';
        _isLoading = false;
      });
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(_error!),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 5),
          action: SnackBarAction(
            label: 'Retry',
            onPressed: _loadAvailableTimeSlots,
            textColor: Colors.white,
          ),
        ),
      );
    }
  }

  Future<void> _createAppointment() async {
    if (_selectedTime == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a time slot')),
      );
      return;
    }

    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final appointmentData = {
        'doctor_id': widget.doctorId,
        'appointment_date': DateFormat('yyyy-MM-dd').format(_selectedDate),
        'appointment_time': DateFormat('HH:mm').format(_selectedTime!),
      };

      await ApiService().createAppointment(appointmentData);

      if (mounted) {
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
                    const SizedBox(height: 16),
                    const Text(
                      "Success!",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "Your appointment on \\${DateFormat('d MMMM yyyy').format(_selectedDate)} at \\${DateFormat('HH:mm').format(_selectedTime!)} has been successfully booked.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => const MainBotnav()),
                          (route) => false,
                        );
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
                          "Continue",
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
      }
    } catch (e) {
      if (mounted) {
        String errorMessage = 'Error: ';
        if (e is Exception && e.toString().contains('Exception:')) {
          final msg = e.toString().split('Exception:').last.trim();
          errorMessage += msg;
        } else {
          errorMessage += e.toString();
        }
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(errorMessage)),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

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
        title: const Text('Choose Date'),
        centerTitle: true,
      ),
      body: _isLoading
          ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 16),
                  Text('Loading available time slots...'),
                ],
              ),
            )
          : _error != null
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.error_outline,
                        color: Colors.red,
                        size: 48,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        _error!,
                        style: const TextStyle(color: Colors.red),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton.icon(
                        onPressed: _loadAvailableTimeSlots,
                        icon: const Icon(Icons.refresh),
                        label: const Text('Retry'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF1C2A3A),
                          foregroundColor: Colors.white,
                        ),
                      ),
                    ],
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TableCalendar(
                        focusedDay: _selectedDate,
                        firstDay: DateTime.now(),
                        lastDay: DateTime.now().add(const Duration(days: 30)),
                        selectedDayPredicate: (day) {
                          return isSameDay(_selectedDate, day);
                        },
                        onDaySelected: (selectedDay, focusedDay) {
                          print('Debug: Date selected: ${selectedDay.toString()}');
                          setState(() {
                            _selectedDate = selectedDay;
                            _selectedTime = null;
                          });
                          _loadAvailableTimeSlots();
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
                      const Text(
                        "Pilih Jam",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 10),
                      if (_availableTimeSlots.isEmpty)
                        const Expanded(
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.access_time,
                                  size: 48,
                                  color: Colors.grey,
                                ),
                                SizedBox(height: 16),
                                Text(
                                  'No available time slots for this date',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 16,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        )
                      else
                        Expanded(
                          child: GridView.builder(
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              childAspectRatio: 2.5,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                            ),
                            itemCount: _availableTimeSlots.length,
                            itemBuilder: (context, index) {
                              final slot = _availableTimeSlots[index];
                              final startTimeStr = slot['start_time'] ?? '';
                              final endTimeStr = slot['end_time'] ?? '';
                              final displayText = '$startTimeStr - $endTimeStr';
                              final time = DateFormat('HH:mm').parse(startTimeStr);
                              final isSelected = _selectedTime != null && DateFormat('HH:mm').format(_selectedTime!) == startTimeStr;
                              return GestureDetector(
                                onTap: () {
                                  print('Debug: Time slot selected: $displayText');
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
                                    displayText,
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
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: _isLoading || _selectedTime == null ? null : _createAppointment,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF1C2A3A),
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(80),
                              ),
                            ),
                            child: _isLoading
                                ? const CircularProgressIndicator(color: Colors.white)
                                : const Text(
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
