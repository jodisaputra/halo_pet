import 'package:flutter/material.dart';
import 'package:halo_pet/models/hospital.dart';
import 'package:halo_pet/services/api_service.dart';
import 'package:url_launcher/url_launcher.dart';

class HospitalPage extends StatefulWidget {
  const HospitalPage({super.key});

  @override
  State<HospitalPage> createState() => _HospitalPageState();
}

class _HospitalPageState extends State<HospitalPage> {
  final ApiService _apiService = ApiService();
  List<Hospital> _hospitals = [];
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadHospitals();
  }

  Future<void> _loadHospitals() async {
    try {
      final data = await _apiService.getHospitals();
      if (data == null || data is! List) {
        setState(() {
          _hospitals = [];
          _isLoading = false;
          _error = 'Invalid data from server';
        });
        return;
      }
      setState(() {
        _hospitals = data.map((json) => Hospital.fromJson(json)).toList();
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
      backgroundColor: const Color(0xFFF8F6FA), // Light background
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _error != null
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Error: $_error'),
                      ElevatedButton(
                        onPressed: _loadHospitals,
                        child: const Text('Retry'),
                      ),
                    ],
                  ),
                )
              : _hospitals.isEmpty
                  ? const Center(child: Text('No hospitals found.'))
                  : RefreshIndicator(
                      onRefresh: _loadHospitals,
                      child: ListView.builder(
                        itemCount: _hospitals.length,
                        itemBuilder: (context, index) {
                          final hospital = _hospitals[index];
                          return Card(
                            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            elevation: 3,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    hospital.name,
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Row(
                                    children: [
                                      const Icon(Icons.location_on, size: 16, color: Colors.blueGrey),
                                      const SizedBox(width: 4),
                                      Expanded(
                                        child: Text(
                                          hospital.address,
                                          style: const TextStyle(color: Colors.grey),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  Row(
                                    children: [
                                      const Icon(Icons.star, color: Colors.amber, size: 16),
                                      const SizedBox(width: 4),
                                      Text(
                                        hospital.rating.toString(),
                                        style: const TextStyle(fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 12),
                                  Row(
                                    children: [
                                      ElevatedButton.icon(
                                        onPressed: () async {
                                          final uri = Uri(scheme: 'tel', path: hospital.phone);
                                          if (await canLaunchUrl(uri)) {
                                            await launchUrl(uri);
                                          }
                                        },
                                        icon: const Icon(Icons.call, size: 18),
                                        label: const Text('Call'),
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.green[50],
                                          foregroundColor: Colors.green[800],
                                          elevation: 0,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(30),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      ElevatedButton.icon(
                                        onPressed: () async {
                                          final query = Uri.encodeComponent(hospital.address);
                                          final googleMapsUrl = 'https://www.google.com/maps/search/?api=1&query=$query';
                                          final uri = Uri.parse(googleMapsUrl);
                                          if (await canLaunchUrl(uri)) {
                                            await launchUrl(uri);
                                          }
                                        },
                                        icon: const Icon(Icons.directions, size: 18),
                                        label: const Text('Directions'),
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.blue[50],
                                          foregroundColor: Colors.blue[800],
                                          elevation: 0,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(30),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
    );
  }
}
