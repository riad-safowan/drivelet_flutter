import 'package:drivelet/core/usecases/usecase.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '../../../auth/domain/usecases/logout_user.dart';

class VehiclesListPage extends StatelessWidget {
  const VehiclesListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: GestureDetector(onTap:(){
      final LogoutUser logoutUser = GetIt.I<LogoutUser>();
      logoutUser.call(NoParams());
      context.go("/login");
    },child: Text("Vehicles List Page"))));
  }
}
