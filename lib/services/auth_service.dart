import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../config/api_config.dart';
import '../models/user.dart';

class AuthService with ChangeNotifier {
  User? _currentUser;
  String? _token;
  bool _isLoading = false;

  User? get currentUser => _currentUser;
  String? get token => _token;
  bool get isLoading => _isLoading;
  bool get isAuthenticated => _token != null;

  // Set loading state
  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  // Initialize from storage
  Future<void> initAuthFromStorage() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');
    final userData = prefs.getString('user_data');

    if (token != null && userData != null) {
      _token = token;
      _currentUser = User.fromJson(json.decode(userData));
      notifyListeners();
    }
  }

  // Save auth data to storage
  Future<void> _saveAuthData(String token, User user) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('auth_token', token);
    prefs.setString('user_data', json.encode(user.toJson()));
  }

  // Clear auth data from storage
  Future<void> _clearAuthData() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('auth_token');
    prefs.remove('user_data');
  }

  // Register new user
  Future<Map<String, dynamic>> register(String name, String email, String password, String passwordConfirmation) async {
    _setLoading(true);

    try {
      final response = await http.post(
        Uri.parse(ApiConfig.getUrl(ApiConfig.register)),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'name': name,
          'email': email,
          'password': password,
          'password_confirmation': passwordConfirmation,
        }),
      );

      final responseData = json.decode(response.body);

      if (response.statusCode == 201) { // Success status code
        final user = User.fromJson(responseData['user']);
        final token = responseData['token'];

        _currentUser = user;
        _token = token;

        await _saveAuthData(token, user);
        notifyListeners();

        _setLoading(false);
        return {'success': true, 'message': responseData['message']};
      } else {
        _setLoading(false);
        return {
          'success': false,
          'message': responseData['message'] ?? 'Registration failed',
          'errors': responseData['errors']
        };
      }
    } catch (error) {
      _setLoading(false);
      return {'success': false, 'message': 'An error occurred during registration: $error'};
    }
  }

  // Login with email and password
  Future<Map<String, dynamic>> login(String email, String password) async {
    _setLoading(true);

    try {
      final response = await http.post(
        Uri.parse(ApiConfig.getUrl(ApiConfig.login)),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'email': email,
          'password': password,
        }),
      );

      final responseData = json.decode(response.body);

      if (response.statusCode == 200) { // Success
        final user = User.fromJson(responseData['user']);
        final token = responseData['token'];

        _currentUser = user;
        _token = token;

        await _saveAuthData(token, user);
        notifyListeners();

        _setLoading(false);
        return {'success': true, 'message': responseData['message']};
      } else {
        _setLoading(false);
        return {
          'success': false,
          'message': responseData['message'] ?? 'Login failed',
          'errors': responseData['errors']
        };
      }
    } catch (error) {
      _setLoading(false);
      return {'success': false, 'message': 'An error occurred during login: $error'};
    }
  }

  // Login with Google
  Future<Map<String, dynamic>> loginWithGoogle(String idToken) async {
    _setLoading(true);

    try {
      final response = await http.post(
        Uri.parse(ApiConfig.getUrl(ApiConfig.googleLogin)),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'id_token': idToken,
        }),
      );

      final responseData = json.decode(response.body);

      if (response.statusCode == 200) { // Success
        final user = User.fromJson(responseData['user']);
        final token = responseData['token'];

        _currentUser = user;
        _token = token;

        await _saveAuthData(token, user);
        notifyListeners();

        _setLoading(false);
        return {'success': true, 'message': responseData['message']};
      } else {
        _setLoading(false);
        return {
          'success': false,
          'message': responseData['message'] ?? 'Google login failed',
        };
      }
    } catch (error) {
      _setLoading(false);
      return {'success': false, 'message': 'An error occurred during Google login: $error'};
    }
  }

  // Logout user
  Future<Map<String, dynamic>> logout() async {
    _setLoading(true);

    try {
      // Only call API if we have a token
      if (_token != null) {
        final response = await http.post(
          Uri.parse(ApiConfig.getUrl(ApiConfig.logout)),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $_token',
          },
        );

        // Even if the server response is not successful, we'll still log out locally
        if (response.statusCode != 200) {
          print('Warning: Server logout returned status code ${response.statusCode}');
        }
      }

      // Clear local data regardless of API response
      _currentUser = null;
      _token = null;
      await _clearAuthData();
      notifyListeners();

      _setLoading(false);
      return {'success': true, 'message': 'Successfully logged out'};
    } catch (error) {
      // Still clear local data even if API call fails
      _currentUser = null;
      _token = null;
      await _clearAuthData();
      notifyListeners();

      _setLoading(false);
      return {'success': true, 'message': 'Logged out (offline)'};
    }
  }

  // Get current user profile
  Future<Map<String, dynamic>> getUserProfile() async {
    if (_token == null) {
      return {'success': false, 'message': 'Not authenticated'};
    }

    _setLoading(true);

    try {
      final response = await http.get(
        Uri.parse(ApiConfig.getUrl(ApiConfig.userProfile)),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $_token',
        },
      );

      final responseData = json.decode(response.body);

      if (response.statusCode == 200) {
        final user = User.fromJson(responseData['user']);
        _currentUser = user;
        await _saveAuthData(_token!, user);
        notifyListeners();

        _setLoading(false);
        return {'success': true, 'user': user};
      } else {
        _setLoading(false);
        return {'success': false, 'message': responseData['message'] ?? 'Failed to get user profile'};
      }
    } catch (error) {
      _setLoading(false);
      return {'success': false, 'message': 'An error occurred while fetching profile: $error'};
    }
  }

  // Refresh the token
  Future<bool> refreshToken() async {
    if (_token == null) return false;

    try {
      final response = await http.post(
        Uri.parse(ApiConfig.getUrl(ApiConfig.refreshToken)),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $_token',
        },
      );

      final responseData = json.decode(response.body);

      if (response.statusCode == 200) {
        _token = responseData['token'];
        await _saveAuthData(_token!, _currentUser!);
        notifyListeners();
        return true;
      } else {
        return false;
      }
    } catch (error) {
      return false;
    }
  }
}
