import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'core/network/network_info.dart';
import 'features/auth/auth_di.dart' as auth_di;

final sl = GetIt.instance;

Future<void> initDI() async {
  await _initExternalDependencies();
  _initCoreDependencies();
  await auth_di.init();
}

Future<void> _initExternalDependencies() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => Connectivity());
}

void _initCoreDependencies() {
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));
}