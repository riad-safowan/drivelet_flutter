import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/vehicles_repository.dart';

class StartRental implements UseCase<String, StartRentalParams> {
  final VehiclesRepository repository;

  StartRental(this.repository);

  @override
  Future<Either<Failure, String>> call(StartRentalParams params) async {
    return await repository.startRental(params.vehicleId);
  }
}

class StartRentalParams extends Equatable {
  final String vehicleId;

  const StartRentalParams({required this.vehicleId});

  @override
  List<Object> get props => [vehicleId];
}