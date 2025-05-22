import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../../../core/constants/api_constants.dart';
import '../../../../core/error/exceptions.dart';
import '../models/login_request_model.dart';
import '../models/login_response_model.dart';

abstract class AuthRemoteDataSource {
  Future<LoginResponseModel> login(LoginRequestModel loginRequest);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final http.Client client;

  AuthRemoteDataSourceImpl({required this.client});

  @override
  Future<LoginResponseModel> login(LoginRequestModel loginRequest) async {
    try {
      final response = await client.post(
        Uri.parse('${ApiConstants.baseUrl}/login'),
        headers: ApiConstants.headers,
        body: jsonEncode(loginRequest.toJson()),
      );

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        return LoginResponseModel.fromJson(jsonResponse);
      } else if (response.statusCode == 401) {
        throw const AuthException('Invalid credentials');
      } else {
        throw ServerException('Login failed: ${response.statusCode}');
      }
    } catch (e) {
      if (e is AuthException || e is ServerException) {
        rethrow;
      }
      throw ServerException('Network error: ${e.toString()}');
    }
  }
}

class AuthRemoteDataSourceImplFakeLocal implements AuthRemoteDataSource {
  final http.Client client;

  AuthRemoteDataSourceImplFakeLocal({required this.client});

  @override
  Future<LoginResponseModel> login(LoginRequestModel loginRequest) async {
    final response = """
    {
  "token": "abc123",
  "user": {
    "id": 1,
    "name": "John Doe",
    "email": "user@example.com"
  }
}
    """;

    final jsonResponse = jsonDecode(response);
    return LoginResponseModel.fromJson(jsonResponse);
  }
}
