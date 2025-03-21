class ApiConfig {
  // Base URL for API
  static const String baseUrl = 'https://halopet.my-saragih.com';

  // Auth Endpoints
  static const String register = '/api/auth/register';
  static const String login = '/api/auth/login';
  static const String googleLogin = '/api/auth/google';
  static const String logout = '/api/auth/logout';
  static const String userProfile = '/api/auth/user';
  static const String refreshToken = '/api/auth/refresh';
  static const String googleCallbackEndpoint = '';

  // Function to get full URL
  static String getUrl(String endpoint) {
    return baseUrl + endpoint;
  }
}