import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/error/exceptions.dart';
import '../models/vehicle_model.dart';

abstract class VehiclesLocalDataSource {
  Future<void> cacheVehicles(List<VehicleModel> vehicles);

  Future<List<VehicleModel>> getLastVehicles();

  Future<void> clearCache();
}

class VehiclesLocalDataSourceImpl implements VehiclesLocalDataSource {
  final SharedPreferences sharedPreferences;

  VehiclesLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<void> cacheVehicles(List<VehicleModel> vehicles) async {
    try {
      final vehiclesJson = vehicles.map((v) => v.toJson()).toList();
      await sharedPreferences.setString(
        AppConstants.vehiclesCacheKey,
        jsonEncode(vehiclesJson),
      );

      // Store cache timestamp
      await sharedPreferences.setInt(
        '${AppConstants.vehiclesCacheKey}_timestamp',
        DateTime.now().millisecondsSinceEpoch,
      );
    } catch (e) {
      throw CacheException('Failed to cache vehicles: ${e.toString()}');
    }
  }

  @override
  Future<List<VehicleModel>> getLastVehicles() async {
    try {
      final vehiclesString = sharedPreferences.getString(
        AppConstants.vehiclesCacheKey,
      );
      final timestamp = sharedPreferences.getInt(
        '${AppConstants.vehiclesCacheKey}_timestamp',
      );

      if (vehiclesString != null && timestamp != null) {
        final cacheTime = DateTime.fromMillisecondsSinceEpoch(timestamp);
        final now = DateTime.now();

        // Check if cache is still valid
        if (now.difference(cacheTime) < Duration(minutes: 30)) {
          final List<dynamic> vehiclesJson = jsonDecode(vehiclesString);
          return vehiclesJson
              .map((json) => VehicleModel.fromJson(json))
              .toList();
        }
      }

      throw CacheException('No valid cached vehicles found');
    } catch (e) {
      if (e is CacheException) {
        rethrow;
      }
      throw CacheException('Failed to get cached vehicles: ${e.toString()}');
    }
  }

  @override
  Future<void> clearCache() async {
    try {
      await sharedPreferences.remove(AppConstants.vehiclesCacheKey);
      await sharedPreferences.remove(
        '${AppConstants.vehiclesCacheKey}_timestamp',
      );
    } catch (e) {
      throw CacheException('Failed to clear cache: ${e.toString()}');
    }
  }
}
