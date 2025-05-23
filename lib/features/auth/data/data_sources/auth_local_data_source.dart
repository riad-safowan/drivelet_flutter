import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/error/exceptions.dart';
import '../models/user_model.dart';

abstract class AuthLocalDataSource {
  Future<void> cacheUser(UserModel user);

  Future<void> cacheToken(String token);

  Future<UserModel?> getLastUser();

  Future<String?> getToken();

  Future<void> clearCache();
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final SharedPreferences sharedPreferences;

  AuthLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<void> cacheUser(UserModel user) async {
    try {
      await sharedPreferences.setString(
        AppConstants.userKey,
        jsonEncode(user.toJson()),
      );
    } catch (e) {
      throw CacheException('Failed to cache user: ${e.toString()}');
    }
  }

  @override
  Future<void> cacheToken(String token) async {
    try {
      await sharedPreferences.setString(AppConstants.tokenKey, token);
    } catch (e) {
      throw CacheException('Failed to cache token: ${e.toString()}');
    }
  }

  @override
  Future<UserModel?> getLastUser() async {
    try {
      final userString = sharedPreferences.getString(AppConstants.userKey);
      if (userString != null) {
        final userJson = jsonDecode(userString);
        return UserModel.fromJson(userJson);
      }
      return null;
    } catch (e) {
      throw CacheException('Failed to get cached user: ${e.toString()}');
    }
  }

  @override
  Future<String?> getToken() async {
    try {
      return sharedPreferences.getString(AppConstants.tokenKey);
    } catch (e) {
      throw CacheException('Failed to get token: ${e.toString()}');
    }
  }

  @override
  Future<void> clearCache() async {
    try {
      await sharedPreferences.remove(AppConstants.userKey);
      await sharedPreferences.remove(AppConstants.tokenKey);
    } catch (e) {
      throw CacheException('Failed to clear cache: ${e.toString()}');
    }
  }
}
