import 'package:flutter/material.dart';
import 'package:halo_pet/services/api_service.dart';
import 'package:halo_pet/constants/ApiConstants.dart';
import 'package:intl/intl.dart';

class ApointmentPage extends StatefulWidget {
  const ApointmentPage({super.key});

  @override
  State<ApointmentPage> createState() => _ApointmentPageState();
}

class _ApointmentPageState extends State<ApointmentPage> {
  bool _isLoading = true;
  List<dynamic> _appointments = [];
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadAppointments();
  }

  String _getStatusText(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return 'Pending';
      case 'confirmed':
        return 'Confirmed';
      case 'completed':
        return 'Completed';
      case 'cancelled':
        return 'Cancelled';
      default:
        return 'Pending';
    }
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return Colors.orange;
      case 'confirmed':
        return Colors.blue;
      case 'completed':
        return Colors.green;
      case 'cancelled':
        return Colors.red;
      default:
        return Colors.orange;
    }
  }

  DateTime? _parseTime(String time) {
    try {
      String cleanTime = time.trim();
      cleanTime = cleanTime.replaceFirst(RegExp(r'^[^0-9-]+'), '');
      // If it's a full ISO string, parse and return only the time part for today
      if (cleanTime.contains('T')) {
        final dt = DateTime.parse(cleanTime);
        final now = DateTime.now();
        return DateTime(now.year, now.month, now.day, dt.hour, dt.minute);
      }
      // Try parsing as ISO string first
      return DateTime.parse(cleanTime);
    } catch (_) {
      try {
        final now = DateTime.now();
        final parts = time.trim().split(":");
        if (parts.length == 2) {
          return DateTime(now.year, now.month, now.day, int.parse(parts[0]), int.parse(parts[1]));
        }
        return null;
      } catch (_) {
        return null;
      }
    }
  }

  Future<void> _loadAppointments() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final appointments = await ApiService().getAppointments();
      setState(() {
        _appointments = appointments;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F6FA),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'My Appointments',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh, color: Colors.black),
            onPressed: _loadAppointments,
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
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
                        onPressed: _loadAppointments,
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
              : _appointments.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'lib/assets/image/empty_appointments.png',
                            height: 200,
                          ),
                          const SizedBox(height: 24),
                          const Text(
                            'No Appointments Yet',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'Book your first appointment with a doctor',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    )
                  : RefreshIndicator(
                      onRefresh: _loadAppointments,
                      child: ListView.builder(
                        padding: const EdgeInsets.all(16),
                        itemCount: _appointments.length,
                        itemBuilder: (context, index) {
                          final appointment = _appointments[index];
                          final date = DateTime.parse(appointment['appointment_date']);
                          final time = appointment['appointment_time'];
                          final doctor = appointment['doctor'];
                          final isToday = DateUtils.isSameDay(date, DateTime.now());
                          final isPast = date.isBefore(DateTime.now());

                          return Container(
                            margin: const EdgeInsets.only(bottom: 20),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.08),
                                  spreadRadius: 1,
                                  blurRadius: 16,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(20),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Row(
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          color: isToday
                                              ? Colors.blue.withOpacity(0.12)
                                              : isPast
                                                  ? Colors.grey.withOpacity(0.12)
                                                  : Colors.green.withOpacity(0.12),
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        child: Icon(
                                          Icons.calendar_today,
                                          color: isToday
                                              ? Colors.blue
                                              : isPast
                                                  ? Colors.grey
                                                  : Colors.green,
                                          size: 22,
                                        ),
                                      ),
                                      const SizedBox(width: 16),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              DateFormat('EEEE, d MMMM yyyy', 'en').format(date),
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 17,
                                              ),
                                            ),
                                            const SizedBox(height: 6),
                                            Text(
                                              _parseTime(time) != null
                                                  ? 'at ${DateFormat('HH:mm', 'en').format(_parseTime(time)!)}'
                                                  : 'at $time',
                                              style: TextStyle(
                                                color: Colors.grey[700],
                                                fontSize: 15,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 14,
                                          vertical: 7,
                                        ),
                                        decoration: BoxDecoration(
                                          color: isToday
                                              ? Colors.blue
                                              : isPast
                                                  ? Colors.grey
                                                  : Colors.green,
                                          borderRadius: BorderRadius.circular(24),
                                        ),
                                        child: Text(
                                          isToday
                                              ? 'Today'
                                              : isPast
                                                  ? 'Past'
                                                  : 'Upcoming',
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 13,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const Divider(height: 1, thickness: 1, color: Color(0xFFF0F0F0)),
                                Padding(
                                  padding: const EdgeInsets.only(top: 16, left: 20, right: 20, bottom: 8),
                                  child: Row(
                                    children: [
                                      CircleAvatar(
                                        radius: 26,
                                        backgroundImage: doctor['image'] != null && doctor['image'].toString().isNotEmpty
                                            ? NetworkImage('${ApiConstants.baseUrl.replaceFirst('/api', '')}/storage/${doctor['image']}')
                                            : const AssetImage('lib/assets/image/doc_1.png') as ImageProvider,
                                        onBackgroundImageError: (exception, stackTrace) {
                                          // Fallback to default image if network image fails
                                          const AssetImage('lib/assets/image/doc_1.png');
                                        },
                                      ),
                                      const SizedBox(width: 16),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              doctor['name'] ?? 'Unknown Doctor',
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16,
                                              ),
                                            ),
                                            const SizedBox(height: 4),
                                            Text(
                                              doctor['specialty'] ?? 'General Practitioner',
                                              style: TextStyle(
                                                color: Colors.grey[600],
                                                fontSize: 14,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 20, right: 20, bottom: 16),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 14,
                                        vertical: 6,
                                      ),
                                      decoration: BoxDecoration(
                                        color: _getStatusColor(appointment['status'] ?? 'pending').withOpacity(0.12),
                                        borderRadius: BorderRadius.circular(24),
                                        border: Border.all(
                                          color: _getStatusColor(appointment['status'] ?? 'pending'),
                                          width: 1,
                                        ),
                                      ),
                                      child: Text(
                                        _getStatusText(appointment['status'] ?? 'pending'),
                                        style: TextStyle(
                                          color: _getStatusColor(appointment['status'] ?? 'pending'),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 13,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
    );
  }
}