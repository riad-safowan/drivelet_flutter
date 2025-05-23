import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '../../../../auth/presentation/bloc/auth_bloc.dart';
import '../../../../auth/presentation/bloc/auth_event.dart';
import '../../../../auth/presentation/pages/login_page.dart';
import '../../widgets/vehicle_card.dart';
import 'bloc/vehicles_list_bloc.dart';
import 'bloc/vehicles_list_event.dart';
import 'bloc/vehicles_list_state.dart';

class VehiclesListPage extends StatefulWidget {
  const VehiclesListPage({super.key});

  @override
  State<VehiclesListPage> createState() => _VehiclesListPageState();
}

class _VehiclesListPageState extends State<VehiclesListPage> {

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetIt.I<VehiclesListBloc>()..add(GetVehiclesListRequested()),
      child: Builder(
        builder: (context) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Available Vehicles'),
              actions: [
                IconButton(
                  icon: const Icon(Icons.refresh),
                  onPressed: () {
                    context.read<VehiclesListBloc>().add(
                      RefreshVehiclesListRequested(),
                    );
                  },
                ),
              ],
            ),
            body: BlocBuilder<VehiclesListBloc, VehiclesListState>(
              builder: (context, state) {
                if (state is VehiclesListLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (state is VehiclesListError) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.error_outline,
                          size: 64,
                          color: Colors.red.shade300,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Oops! Something went wrong',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey.shade700,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 32),
                          child: Text(
                            state.message,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),
                        ElevatedButton(
                          onPressed: () {
                            context.read<VehiclesListBloc>().add(
                              GetVehiclesListRequested(),
                            );
                          },
                          child: const Text('Retry'),
                        ),
                      ],
                    ),
                  );
                }

                if (state is VehiclesListEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.electric_scooter_outlined,
                          size: 64,
                          color: Colors.grey.shade300,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'No vehicles available',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey.shade700,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Check back later for available vehicles',
                          style: TextStyle(
                              fontSize: 14, color: Colors.grey.shade600),
                        ),
                        const SizedBox(height: 24),
                        ElevatedButton(
                          onPressed: () {
                            context.read<VehiclesListBloc>().add(
                              RefreshVehiclesListRequested(),
                            );
                          },
                          child: const Text('Refresh'),
                        ),
                      ],
                    ),
                  );
                }

                if (state is VehiclesListLoaded) {
                  return RefreshIndicator(
                    onRefresh: () async {
                      context.read<VehiclesListBloc>().add(
                        RefreshVehiclesListRequested(),
                      );
                    },
                    child: ListView.builder(
                      physics: const AlwaysScrollableScrollPhysics(),
                      itemCount: state.vehicles.length,
                      itemBuilder: (context, index) {
                        return VehicleCard(vehicle: state.vehicles[index]);
                      },
                    ),
                  );
                }

                return const SizedBox.shrink();
              },
            ),
            bottomNavigationBar: BottomNavigationBar(
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(Icons.electric_scooter),
                  label: 'Vehicles',
                ),
                BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
              ],
              currentIndex: 0,
              selectedItemColor: Colors.blue,
              onTap: (index) {
                if(index == 1){
                  context.push("/profile");
                }
              },
            ),
          );
        }
      ),
    );
  }
}
