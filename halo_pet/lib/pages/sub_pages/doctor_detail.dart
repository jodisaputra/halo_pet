import 'package:flutter/material.dart';
import 'package:halo_pet/pages/sub_pages/new_apointment.dart';
import 'package:halo_pet/constants/ApiConstants.dart';
import 'package:halo_pet/models/doctor.dart';
import 'package:halo_pet/services/api_service.dart';

class DoctorDetail extends StatefulWidget {
  final int doctorId;
  const DoctorDetail({super.key, required this.doctorId});

  @override
  State<DoctorDetail> createState() => _DoctorDetailState();
}

class _DoctorDetailState extends State<DoctorDetail> {
  Doctor? _doctor;
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadDoctor();
  }

  Future<void> _loadDoctor() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });
    try {
      final data = await ApiService().getDoctor(widget.doctorId);
      setState(() {
        _doctor = Doctor.fromJson(data);
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
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Doctor Details', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _error != null
              ? Center(child: Text('Error: [31m$_error[0m'))
              : SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Doctor Image, Name, Specialty, Location
                      Column(
                        children: [
                          CircleAvatar(
                            radius: 54,
                            backgroundImage: (_doctor != null && _doctor!.image != null && _doctor!.image!.isNotEmpty)
                                ? NetworkImage(ApiConstants.baseUrl.replaceFirst('/api', '') + '/storage/' + _doctor!.image!) as ImageProvider
                                : const AssetImage('lib/assets/image/doc_1.png'),
                            backgroundColor: Colors.white,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            _doctor?.name ?? '-',
                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            _doctor?.specialty ?? '-',
                            style: const TextStyle(color: Colors.blueAccent, fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.location_on, color: Colors.blueAccent, size: 18),
                              const SizedBox(width: 4),
                              Text(_doctor?.location ?? '-', style: const TextStyle(color: Colors.grey, fontSize: 14)),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 28),
                      // About Section
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(20),
                        margin: const EdgeInsets.only(bottom: 18),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(18),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "About",
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              _doctor?.about ?? '-',
                              style: const TextStyle(color: Colors.black54, fontSize: 15),
                            ),
                          ],
                        ),
                      ),
                      // Working Time Section
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(20),
                        margin: const EdgeInsets.only(bottom: 18, top: 8),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(18),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Working Time",
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              _doctor?.workingTime ?? '-',
                              style: const TextStyle(color: Colors.black54, fontSize: 15),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
        child: SizedBox(
          width: double.infinity,
          height: 54,
          child: ElevatedButton(
            onPressed: _isLoading || _doctor == null
                ? null
                : () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NewAppointment(doctorId: widget.doctorId),
                      ),
                    ),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF0174CE),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(28),
              ),
              elevation: 0,
            ),
            child: const Text(
              "Book Appointment",
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }

  Widget _statCard(IconData icon, String value, String label) {
    return Container(
      width: 70,
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: const Color(0xFFF3F4F6),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Icon(icon, size: 30, color: Colors.blueAccent),
          const SizedBox(height: 6),
          Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
          Text(label, style: const TextStyle(color: Colors.grey, fontSize: 13)),
        ],
      ),
    );
  }
}
