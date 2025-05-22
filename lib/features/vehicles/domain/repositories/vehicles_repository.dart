import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/vehicle.dart';

abstract class VehiclesRepository {
  Future<Either<Failure, List<Vehicle>>> getVehiclesList();
  Future<Either<Failure, Vehicle>> getVehicleDetails(String vehicleId);
  Future<Either<Failure, String>> startRental(String vehicleId);
}