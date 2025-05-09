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
    }
    return data;
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
    return jsonDecode(response.body);
  }

  // Forgot Password
  static Future<Map<String, dynamic>> forgotPassword(String email) async {
    final response = await http.post(
      Uri.parse('$baseUrl/forgot-password'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email}),
    );
    return jsonDecode(response.body);
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
    }
    return null;
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
} 