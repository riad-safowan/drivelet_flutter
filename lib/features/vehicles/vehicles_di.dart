import 'package:Drivelet/features/vehicles/presentation/pages/vehicle_detail/bloc/vehicle_detail_bloc.dart';
import 'package:Drivelet/features/vehicles/presentation/pages/vehicles_list/bloc/vehicles_list_bloc.dart';
import 'package:get_it/get_it.dart';

import 'data/data_sources/vehicle_remote_data_source.dart';
import 'data/data_sources/vehicles_local_data_source.dart';
import 'data/repositories/vehicles_repository_impl.dart';
import 'domain/repositories/vehicles_repository.dart';
import 'domain/usecases/get_vehicle_details.dart';
import 'domain/usecases/get_vehicles_list.dart';
import 'domain/usecases/start_rental.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! Features - Vehicles
  // Bloc
  sl.registerFactory(() => VehiclesListBloc(getVehiclesList: sl()));

  sl.registerFactory(
    () => VehicleDetailBloc(getVehicleDetails: sl(), startRental: sl()),
  );

  // Use cases
  sl.registerLazySingleton(() => GetVehiclesList(sl()));
  sl.registerLazySingleton(() => GetVehicleDetails(sl()));
  sl.registerLazySingleton(() => StartRental(sl()));

  // Repository
  sl.registerLazySingleton<VehiclesRepository>(
    () => VehiclesRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  // Data sources
  sl.registerLazySingleton<VehiclesRemoteDataSource>(
    () => VehiclesRemoteDataSourceImpl(client: sl()),
  );

  sl.registerLazySingleton<VehiclesLocalDataSource>(
    () => VehiclesLocalDataSourceImpl(sharedPreferences: sl()),
  );
}
