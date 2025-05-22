import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/vehicles/presentation/pages/vehicle_detail/vehicle_detail_page.dart';
import '../../features/vehicles/presentation/pages/vehicles_list/vehicles_list_page.dart';
import '../constants/app_constants.dart';

late final GoRouter appRouter;

Future<void> initRouter() async {
  appRouter = GoRouter(
    debugLogDiagnostics: true,
    initialLocation: '/',
    redirect: (context, state) async {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString(AppConstants.tokenKey);
      final isLoggedIn = token != null && token.isNotEmpty;
      final goingToLogin = state.fullPath == '/login';

      if (!isLoggedIn && !goingToLogin) {
        return '/login';
      }
      if (isLoggedIn && goingToLogin) {
        return '/vehicles';
      }
      return null; // no redirect
    },
    routes: [
      GoRoute(path: '/login', builder: (context, state) => const LoginPage()),
      GoRoute(
        path: '/vehicles',
        builder: (context, state) => const VehiclesListPage(),
      ),
      GoRoute(
        path: '/vehicles/:vehicleId',
        builder: (context, state) {
          final vehicleId = state.pathParameters['vehicleId']!;
          return VehicleDetailPage(vehicleId: vehicleId);
        },
      ),
    ],
  );
}
