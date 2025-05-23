import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../../../core/constants/api_constants.dart';
import '../../../../core/error/exceptions.dart';
import '../models/profile_model.dart';

abstract class ProfileRemoteDataSource {
  Future<ProfileModel> getUserProfile();
}

class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  final http.Client client;

  ProfileRemoteDataSourceImpl({required this.client});

  @override
  Future<ProfileModel> getUserProfile() async {
    try {
      final response = await client.get(
        Uri.parse('${ApiConstants.baseUrl}/users/1'),
        headers: ApiConstants.headers,
      );

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        return ProfileModel.fromJson(json);
      } else {
        throw ServerException(
          'Failed to fetch profile: ${response.statusCode}',
        );
      }
    } catch (e) {
      if (e is ServerException) {
        rethrow;
      }
      throw ServerException('Network error: ${e.toString()}');
    }
  }
}
