import 'package:dartz/dartz.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/vehicle.dart';
import '../../domain/repositories/vehicles_repository.dart';
import '../data_sources/vehicle_remote_data_source.dart';
import '../data_sources/vehicles_local_data_source.dart';

class VehiclesRepositoryImpl implements VehiclesRepository {
  final VehiclesRemoteDataSource remoteDataSource;
  final VehiclesLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  VehiclesRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<Vehicle>>> getVehiclesList() async {
    if (await networkInfo.isConnected) {
      try {
        final remoteVehicles = await remoteDataSource.getVehiclesList();
        await localDataSource.cacheVehicles(remoteVehicles);
        return Right(remoteVehicles);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.message));
      } catch (e) {
        return Left(ServerFailure('Unexpected error: ${e.toString()}'));
      }
    } else {
      try {
        final localVehicles = await localDataSource.getLastVehicles();
        return Right(localVehicles);
      } on CacheException catch (e) {
        return Left(CacheFailure(e.message));
      } catch (e) {
        return Left(NetworkFailure('No internet connection and no cached data'));
      }
    }
  }

  @override
  Future<Either<Failure, Vehicle>> getVehicleDetails(String vehicleId) async {
    if (await networkInfo.isConnected) {
      try {
        final vehicle = await remoteDataSource.getVehicleDetails(vehicleId);
        return Right(vehicle);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.message));
      } catch (e) {
        return Left(ServerFailure('Unexpected error: ${e.toString()}'));
      }
    } else {
      return const Left(NetworkFailure('No internet connection'));
    }
  }

  @override
  Future<Either<Failure, String>> startRental(String vehicleId) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await remoteDataSource.startRental(vehicleId);
        return Right(result.message);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.message));
      } catch (e) {
        return Left(ServerFailure('Unexpected error: ${e.toString()}'));
      }
    } else {
      return const Left(NetworkFailure('No internet connection'));
    }
  }
}