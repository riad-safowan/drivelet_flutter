import 'package:Drivelet/features/profile/presentation/pages/profile/bloc/profile_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../core/network/network_info.dart';
import 'data/data_sources/profile_remote_data_source.dart';
import 'data/repositories/profile_repository_impl.dart';
import 'domain/repositories/profile_repository.dart';
import 'domain/usecases/get_user_profile.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! Features - Profile
  // Bloc
  sl.registerFactory(() => ProfileBloc(getUserProfile: sl()));

  // Use cases
  sl.registerLazySingleton(() => GetUserProfile(sl()));

  // Repository
  sl.registerLazySingleton<ProfileRepository>(
    () => ProfileRepositoryImpl(remoteDataSource: sl(), networkInfo: sl()),
  );

  // Data sources
  sl.registerLazySingleton<ProfileRemoteDataSource>(
    () => ProfileRemoteDataSourceImpl(client: sl()),
  );
}
