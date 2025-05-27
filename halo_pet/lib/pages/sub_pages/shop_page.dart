import 'package:flutter/material.dart';
import 'package:halo_pet/models/shop.dart';
import 'package:halo_pet/services/api_service.dart';
import 'package:url_launcher/url_launcher.dart';

class ShopPage extends StatefulWidget {
  const ShopPage({super.key});

  @override
  State<ShopPage> createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  final ApiService _apiService = ApiService();
  List<Shop> _shops = [];
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadShops();
  }

  Future<void> _loadShops() async {
    try {
      final data = await _apiService.getShops();
      if (data == null || data is! List) {
        setState(() {
          _shops = [];
          _isLoading = false;
          _error = 'Invalid data from server';
        });
        return;
      }
      setState(() {
        _shops = data.map((json) => Shop.fromJson(json)).toList();
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  Future<void> _openMapsDirections(String address) async {
    final query = Uri.encodeComponent(address);

    // Daftar URL yang akan dicoba secara berurutan
    final List<Map<String, String>> mapOptions = [
      {'url': 'geo:0,0?q=$query', 'name': 'Default Maps'},
      {
        'url': 'https://www.google.com/maps/search/?api=1&query=$query',
        'name': 'Google Maps Web'
      },
      {
        'url': 'https://maps.google.com/?q=$query',
        'name': 'Google Maps Alternative'
      },
    ];

    bool success = false;
    String lastError = '';

    for (var option in mapOptions) {
      try {
        final uri = Uri.parse(option['url']!);

        // Untuk geo scheme, langsung coba launch
        if (option['url']!.startsWith('geo:')) {
          try {
            await launchUrl(uri, mode: LaunchMode.externalApplication);
            success = true;
            break;
          } catch (e) {
            lastError = 'Maps app not available';
            continue;
          }
        } else {
          // Untuk HTTP/HTTPS, cek dulu kemudian launch
          if (await canLaunchUrl(uri)) {
            await launchUrl(uri, mode: LaunchMode.externalApplication);
            success = true;
            break;
          }
        }
      } catch (e) {
        lastError = e.toString();
        continue;
      }
    }

    if (!success && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
              'Cannot open maps app. Please install Google Maps or enable browser access.'),
          duration: const Duration(seconds: 3),
          action: SnackBarAction(
            label: 'Copy Address',
            onPressed: () {
              // Anda bisa menggunakan clipboard package untuk copy address
              // Clipboard.setData(ClipboardData(text: address));
            },
          ),
        ),
      );
    }
  }

  Future<void> _makePhoneCall(String phoneNumber) async {
    final uri = Uri(scheme: 'tel', path: phoneNumber);
    try {
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri);
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Cannot make phone call on this device')),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error making phone call: $e')),
        );
      }
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
                      Text(
                          'Error: $_error'), // Removed the color codes [38;5;9m and [0m
                      ElevatedButton(
                        onPressed: _loadShops,
                        child: const Text('Retry'),
                      ),
                    ],
                  ),
                )
              : _shops.isEmpty
                  ? const Center(child: Text('No shops found.'))
                  : RefreshIndicator(
                      onRefresh: _loadShops,
                      child: ListView.builder(
                        itemCount: _shops.length,
                        itemBuilder: (context, index) {
                          final shop = _shops[index];
                          return Card(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            elevation: 3,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16)),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    shop.name,
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Row(
                                    children: [
                                      const Icon(Icons.location_on,
                                          size: 16, color: Colors.blueGrey),
                                      const SizedBox(width: 4),
                                      Expanded(
                                        child: Text(
                                          shop.address,
                                          style: const TextStyle(
                                              color: Colors.grey),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  Row(
                                    children: [
                                      const Icon(Icons.star,
                                          color: Colors.amber, size: 16),
                                      const SizedBox(width: 4),
                                      Text(
                                        shop.rating.toString(),
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 12),
                                  Row(
                                    children: [
                                      ElevatedButton.icon(
                                        onPressed: () =>
                                            _makePhoneCall(shop.phone),
                                        icon: const Icon(Icons.call, size: 18),
                                        label: const Text('Call'),
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.green[50],
                                          foregroundColor: Colors.green[800],
                                          elevation: 0,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(30),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      ElevatedButton.icon(
                                        onPressed: () =>
                                            _openMapsDirections(shop.address),
                                        icon: const Icon(Icons.directions,
                                            size: 18),
                                        label: const Text('Directions'),
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.blue[50],
                                          foregroundColor: Colors.blue[800],
                                          elevation: 0,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(30),
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