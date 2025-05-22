class ApiConstants {
  static const String baseUrl = 'https://drivelet.riadsafowan.com';

  // Headers
  static const Map<String, String> headers = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };

  static Map<String, String> headersWithAuth(String token) => {
    ...headers,
    'Authorization': 'Bearer $token',
  };
}