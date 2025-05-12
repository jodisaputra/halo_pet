import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constants/ApiConstants.dart';

class ApiService {
  static String get baseUrl => ApiConstants.baseUrl;

  // Login
  static Future<Map<String, dynamic>> login(
      String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );
    final data = jsonDecode(response.body);
    if (response.statusCode == 200 && data['token'] != null) {
      // Save token
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', data['token']);
      // Save role if present
      if (data['user'] != null && data['user']['role'] != null) {
        await prefs.setString('role', data['user']['role']);
      }
      return data;
    } else {
      if (data is Map && data['message'] != null) {
        throw Exception(data['message']);
      } else if (data is Map && data['errors'] != null) {
        throw Exception(data['errors'].toString());
      } else {
        throw Exception('Failed to login: ${response.body}');
      }
    }
  }

  // Register
  static Future<Map<String, dynamic>> register(
      String firstName, String lastName, String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/register'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'first_name': firstName,
        'last_name': lastName,
        'email': email,
        'password': password
      }),
    );
    final data = jsonDecode(response.body);
    if (response.statusCode == 201 || response.statusCode == 200) {
      // Save role if present
      if (data['user'] != null && data['user']['role'] != null) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('role', data['user']['role']);
      }
      return data;
    } else {
      if (data is Map && data['message'] != null) {
        throw Exception(data['message']);
      } else if (data is Map && data['errors'] != null) {
        throw Exception(data['errors'].toString());
      } else {
        throw Exception('Failed to register: ${response.body}');
      }
    }
  }

  // Forgot Password
  static Future<Map<String, dynamic>> forgotPassword(String email) async {
    final response = await http.post(
      Uri.parse('$baseUrl/forgot-password'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email}),
    );
    final data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      return data;
    } else {
      if (data is Map && data['message'] != null) {
        throw Exception(data['message']);
      } else if (data is Map && data['errors'] != null) {
        throw Exception(data['errors'].toString());
      } else {
        throw Exception('Failed to reset password: ${response.body}');
      }
    }
  }

  // Get logged-in user
  static Future<Map<String, dynamic>?> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    if (token == null) return null;
    final response = await http.get(
      Uri.parse('$baseUrl/user'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      final data = jsonDecode(response.body);
      if (data is Map && data['message'] != null) {
        throw Exception(data['message']);
      } else if (data is Map && data['errors'] != null) {
        throw Exception(data['errors'].toString());
      } else {
        throw Exception('Failed to get user: ${response.body}');
      }
    }
  }

  // Logout
  static Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
  }

  // Update Profile (multipart)
  static Future<Map<String, dynamic>> updateProfile({
    required String firstName,
    String? lastName,
    String? email,
    String? phone,
    String? gender,
    String? dob,
    File? imageFile,
  }) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');
      if (token == null) {
        throw Exception('No authentication token found');
      }
      
      var uri = Uri.parse('$baseUrl/user/profile');
      
      var request = http.MultipartRequest('POST', uri);
      request.headers['Authorization'] = 'Bearer $token';
      request.headers['Accept'] = 'application/json';
      request.headers['_method'] = 'PUT';
      
      // Add fields with logging
      request.fields['first_name'] = firstName;
      if (lastName != null) request.fields['last_name'] = lastName;
      if (email != null) request.fields['email'] = email;
      if (phone != null) request.fields['phone'] = phone;
      if (gender != null) request.fields['gender'] = gender;
      if (dob != null) request.fields['dob'] = dob;
      
      // Add image if provided
      if (imageFile != null) {
        try {
          print('Debug: Adding image from path: ${imageFile.path}');
          if (await imageFile.exists()) {
            final fileSize = await imageFile.length();
            print('Debug: Image file exists, size: $fileSize bytes');
            request.files.add(await http.MultipartFile.fromPath(
              'profile_image', 
              imageFile.path,
              contentType: MediaType('image', 'jpeg'),
            ));
          } else {
            print('Debug: Image file does not exist at path: ${imageFile.path}');
          }
        } catch (e) {
          print('Debug: Error adding image file: $e');
        }
      }
  
      final streamedResponse = await request.send().timeout(
        const Duration(seconds: 30),
        onTimeout: () {
          throw TimeoutException('Request timed out after 30 seconds');
        },
      );
      final response = await http.Response.fromStream(streamedResponse);
      
      // Safely parse JSON
      Map<String, dynamic> data;
      try {
        data = jsonDecode(response.body);
      } catch (e) {
        throw Exception('Failed to parse server response');
      }
      
      if (response.statusCode >= 200 && response.statusCode < 300) {
        return data;
      } else {
        print('Debug: Profile update failed with status ${response.statusCode}');
        print('Debug: Error message: ${data['message'] ?? 'No error message provided'}');
        throw Exception(data['message'] ?? 'Failed to update profile: Status ${response.statusCode}');
      }
    } catch (e) {
      print('Debug: Exception in updateProfile: $e');
      if (e is FormatException) {
        throw Exception('Failed to update profile: Invalid response format');
      } else if (e is SocketException) {
        throw Exception('Failed to update profile: Network error - check your connection');
      } else if (e is TimeoutException) {
        throw Exception('Failed to update profile: Request timed out');
      } else {
        throw Exception('Failed to update profile: ${e.toString()}');
      }
    }
  }

  // Hospital endpoints
  Future<List<dynamic>> getHospitals() async {
    final response = await http.get(Uri.parse('$baseUrl/hospitals'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    }
    throw Exception('Failed to load hospitals');
  }

  Future<dynamic> getHospital(int id) async {
    final response = await http.get(Uri.parse('$baseUrl/hospitals/$id'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    }
    throw Exception('Failed to load hospital');
  }

  Future<dynamic> createHospital(Map<String, dynamic> data) async {
    final response = await http.post(
      Uri.parse('$baseUrl/hospitals'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(data),
    );
    if (response.statusCode == 201) {
      return json.decode(response.body);
    } else {
      final error = json.decode(response.body);
      if (error is Map && error['message'] != null) {
        throw Exception(error['message']);
      } else if (error is Map && error['errors'] != null) {
        throw Exception(error['errors'].toString());
      } else {
        throw Exception('Failed to create hospital: ${response.body}');
      }
    }
  }

  Future<dynamic> updateHospital(int id, Map<String, dynamic> data) async {
    final response = await http.put(
      Uri.parse('$baseUrl/hospitals/$id'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(data),
    );
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      final error = json.decode(response.body);
      if (error is Map && error['message'] != null) {
        throw Exception(error['message']);
      } else if (error is Map && error['errors'] != null) {
        throw Exception(error['errors'].toString());
      } else {
        throw Exception('Failed to update hospital: ${response.body}');
      }
    }
  }

  Future<void> deleteHospital(int id) async {
    final response = await http.delete(Uri.parse('$baseUrl/hospitals/$id'));
    if (response.statusCode != 204) {
      final error = json.decode(response.body);
      if (error is Map && error['message'] != null) {
        throw Exception(error['message']);
      } else if (error is Map && error['errors'] != null) {
        throw Exception(error['errors'].toString());
      } else {
        throw Exception('Failed to delete hospital: ${response.body}');
      }
    }
  }

  // Shop endpoints
  Future<List<dynamic>> getShops() async {
    final response = await http.get(Uri.parse('$baseUrl/shops'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    }
    throw Exception('Failed to load shops');
  }

  Future<dynamic> getShop(int id) async {
    final response = await http.get(Uri.parse('$baseUrl/shops/$id'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    }
    throw Exception('Failed to load shop');
  }

  Future<dynamic> createShop(Map<String, dynamic> data) async {
    final response = await http.post(
      Uri.parse('$baseUrl/shops'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(data),
    );
    if (response.statusCode == 201) {
      return json.decode(response.body);
    } else {
      final error = json.decode(response.body);
      if (error is Map && error['message'] != null) {
        throw Exception(error['message']);
      } else if (error is Map && error['errors'] != null) {
        throw Exception(error['errors'].toString());
      } else {
        throw Exception('Failed to create shop: ${response.body}');
      }
    }
  }

  Future<dynamic> updateShop(int id, Map<String, dynamic> data) async {
    final response = await http.put(
      Uri.parse('$baseUrl/shops/$id'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(data),
    );
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      final error = json.decode(response.body);
      if (error is Map && error['message'] != null) {
        throw Exception(error['message']);
      } else if (error is Map && error['errors'] != null) {
        throw Exception(error['errors'].toString());
      } else {
        throw Exception('Failed to update shop: ${response.body}');
      }
    }
  }

  Future<void> deleteShop(int id) async {
    final response = await http.delete(Uri.parse('$baseUrl/shops/$id'));
    if (response.statusCode != 204) {
      final error = json.decode(response.body);
      if (error is Map && error['message'] != null) {
        throw Exception(error['message']);
      } else if (error is Map && error['errors'] != null) {
        throw Exception(error['errors'].toString());
      } else {
        throw Exception('Failed to delete shop: ${response.body}');
      }
    }
  }

  // Doctor endpoints
  Future<List<dynamic>> getDoctors({String? search}) async {
    String url = '$baseUrl/doctors';
    if (search != null && search.isNotEmpty) {
      url += '?search=${Uri.encodeComponent(search)}';
    }
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    }
    throw Exception('Failed to load doctors');
  }

  Future<dynamic> getDoctor(int id) async {
    final response = await http.get(Uri.parse('$baseUrl/doctors/$id'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      final error = json.decode(response.body);
      if (error is Map && error['message'] != null) {
        throw Exception(error['message']);
      } else if (error is Map && error['errors'] != null) {
        throw Exception(error['errors'].toString());
      } else {
        throw Exception('Failed to load doctor: ${response.body}');
      }
    }
  }

  // Appointment endpoints
  Future<List<dynamic>> getAppointments({String? status}) async {
    String url = '$baseUrl/appointments';
    if (status != null) {
      url += '?status=$status';
    }
    final response = await http.get(
      Uri.parse(url),
      headers: await _getAuthHeaders(),
    );
    if (response.statusCode == 200) {
      return json.decode(response.body);
    }
    throw Exception('Failed to load appointments');
  }

  Future<dynamic> createAppointment(Map<String, dynamic> data) async {
    final response = await http.post(
      Uri.parse('$baseUrl/appointments'),
      headers: await _getAuthHeaders(),
      body: json.encode(data),
    );
    if (response.statusCode == 201) {
      return json.decode(response.body);
    } else {
      try {
        final error = json.decode(response.body);
        if (error is Map && error['message'] != null) {
          throw Exception(error['message']);
        } else if (error is Map && error['errors'] != null) {
          throw Exception(error['errors'].toString());
        } else {
          throw Exception('Failed to create appointment: ${response.body}');
        }
      } catch (_) {
        throw Exception('Failed to create appointment: ${response.body}');
      }
    }
  }

  Future<dynamic> getAppointment(int id) async {
    final response = await http.get(
      Uri.parse('$baseUrl/appointments/$id'),
      headers: await _getAuthHeaders(),
    );
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      final error = json.decode(response.body);
      if (error is Map && error['message'] != null) {
        throw Exception(error['message']);
      } else if (error is Map && error['errors'] != null) {
        throw Exception(error['errors'].toString());
      } else {
        throw Exception('Failed to load appointment: ${response.body}');
      }
    }
  }

  Future<dynamic> updateAppointment(int id, Map<String, dynamic> data) async {
    final response = await http.put(
      Uri.parse('$baseUrl/appointments/$id'),
      headers: await _getAuthHeaders(),
      body: json.encode(data),
    );
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      final error = json.decode(response.body);
      if (error is Map && error['message'] != null) {
        throw Exception(error['message']);
      } else if (error is Map && error['errors'] != null) {
        throw Exception(error['errors'].toString());
      } else {
        throw Exception('Failed to update appointment: ${response.body}');
      }
    }
  }

  Future<void> deleteAppointment(int id) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/appointments/$id'),
      headers: await _getAuthHeaders(),
    );
    if (response.statusCode != 204) {
      final error = json.decode(response.body);
      if (error is Map && error['message'] != null) {
        throw Exception(error['message']);
      } else if (error is Map && error['errors'] != null) {
        throw Exception(error['errors'].toString());
      } else {
        throw Exception('Failed to delete appointment: ${response.body}');
      }
    }
  }

  Future<List<Map<String, String>>> getAvailableTimeSlots(int doctorId, String date) async {
    try {
      print('Debug: Fetching time slots for doctor $doctorId');
      final response = await http.get(
        Uri.parse('$baseUrl/doctors/$doctorId/available-time-slots'),
      );
      print('Debug: Response status code: ${response.statusCode}');
      print('Debug: Response body: ${response.body}');
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map<Map<String, String>>((slot) => {
          'start_time': slot['start_time'],
          'end_time': slot['end_time'],
        }).toList();
      } else {
        final error = json.decode(response.body);
        throw Exception(error['message'] ?? 'Failed to load available time slots');
      }
    } catch (e) {
      print('Debug: Error in getAvailableTimeSlots: $e');
      if (e is FormatException) {
        throw Exception('Invalid response format from server');
      } else if (e is SocketException) {
        throw Exception('Network error - check your connection');
      } else {
        throw Exception('Failed to load available time slots: ${e.toString()}');
      }
    }
  }

  Future<Map<String, String>> _getAuthHeaders() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    return {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
  }
} 