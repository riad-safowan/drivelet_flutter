class ApiConstants {
  static const String baseUrl = 'https://6751b0c0d1983b9597b571e9.mockapi.io/api/v1';

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