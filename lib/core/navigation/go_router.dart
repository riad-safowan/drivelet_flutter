import 'package:drivelet/features/profile/presentation/pages/profile/profile_page.dart';
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
    initialLocation: '/vehicles',
    redirect: (context, state) async {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString(AppConstants.tokenKey);
      final isLoggedIn = token != null && token.isNotEmpty;

      if (!isLoggedIn) {
        return '/login';
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
        path: '/profile',
        builder: (context, state) => const ProfilePage(),
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
