import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../../../core/constants/api_constants.dart';
import '../../../../core/error/exceptions.dart';
import '../models/responses/rental_response_model.dart';
import '../models/vehicle_model.dart';

abstract class VehiclesRemoteDataSource {
  Future<List<VehicleModel>> getVehiclesList();
  Future<VehicleModel> getVehicleDetails(String vehicleId);
  Future<RentalResponseModel> startRental(String vehicleId);
}

class VehiclesRemoteDataSourceImpl implements VehiclesRemoteDataSource {
  final http.Client client;

  VehiclesRemoteDataSourceImpl({required this.client});

  @override
  Future<List<VehicleModel>> getVehiclesList() async {
    try {
      final response = await client.get(
        Uri.parse('${ApiConstants.baseUrl}/vehicles'),
        headers: ApiConstants.headers,
      );
      print(response.body);
      if (response.statusCode == 200) {

        final List<dynamic> jsonList = jsonDecode(response.body);
        return jsonList.map((json) => VehicleModel.fromJson(json)).toList();
      } else {
        throw ServerException('Failed to fetch vehicles: ${response.statusCode}');
      }
    } catch (e) {
      if (e is ServerException) {
        rethrow;
      }
      throw ServerException('Network error: ${e.toString()}');
    }
  }

  @override
  Future<VehicleModel> getVehicleDetails(String vehicleId) async {
    try {
      final response = await client.get(
        Uri.parse('${ApiConstants.baseUrl}/vehicles/$vehicleId'),
        headers: ApiConstants.headers,
      );

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        return VehicleModel.fromJson(json);
      } else if (response.statusCode == 404) {
        throw ServerException('Vehicle not found');
      } else {
        throw ServerException('Failed to fetch vehicle details: ${response.statusCode}');
      }
    } catch (e) {
      if (e is ServerException) {
        rethrow;
      }
      throw ServerException('Network error: ${e.toString()}');
    }
  }

  @override
  Future<RentalResponseModel> startRental(String vehicleId) async {
    try {
      final response = await client.post(
        Uri.parse('${ApiConstants.baseUrl}/vehicles/$vehicleId/rent'),
        headers: ApiConstants.headers,
      );

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        return RentalResponseModel.fromJson(json);
      } else if (response.statusCode == 400) {
        throw ServerException('Vehicle not available for rental');
      } else {
        throw ServerException('Failed to start rental: ${response.statusCode}');
      }
    } catch (e) {
      if (e is ServerException) {
        rethrow;
      }
      throw ServerException('Network error: ${e.toString()}');
    }
  }
}