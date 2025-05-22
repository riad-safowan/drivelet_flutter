import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/vehicle.dart';
import '../repositories/vehicles_repository.dart';

class GetVehicleDetails implements UseCase<Vehicle, VehicleDetailsParams> {
  final VehiclesRepository repository;

  GetVehicleDetails(this.repository);

  @override
  Future<Either<Failure, Vehicle>> call(VehicleDetailsParams params) async {
    return await repository.getVehicleDetails(params.vehicleId);
  }
}

class VehicleDetailsParams extends Equatable {
  final String vehicleId;

  const VehicleDetailsParams({required this.vehicleId});

  @override
  List<Object> get props => [vehicleId];
}
