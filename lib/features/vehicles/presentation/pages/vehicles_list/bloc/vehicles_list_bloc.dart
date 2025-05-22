import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/usecases/usecase.dart';
import '../../../../domain/usecases/get_vehicles_list.dart';
import 'vehicles_list_event.dart';
import 'vehicles_list_state.dart';

class VehiclesListBloc extends Bloc<VehiclesListEvent, VehiclesListState> {
  final GetVehiclesList getVehiclesList;

  VehiclesListBloc({
    required this.getVehiclesList,
  }) : super(VehiclesListInitial()) {
    on<GetVehiclesListRequested>(_onGetVehiclesListRequested);
    on<RefreshVehiclesListRequested>(_onRefreshVehiclesListRequested);
  }

  Future<void> _onGetVehiclesListRequested(
      GetVehiclesListRequested event,
      Emitter<VehiclesListState> emit,
      ) async {
    emit(VehiclesListLoading());
    await _fetchVehicles(emit);
  }

  Future<void> _onRefreshVehiclesListRequested(
      RefreshVehiclesListRequested event,
      Emitter<VehiclesListState> emit,
      ) async {
    await _fetchVehicles(emit);
  }

  Future<void> _fetchVehicles(Emitter<VehiclesListState> emit) async {
    final result = await getVehiclesList(NoParams());

    result.fold(
          (failure) => emit(VehiclesListError(failure.message)),
          (vehicles) {
        if (vehicles.isEmpty) {
          emit(VehiclesListEmpty());
        } else {
          emit(VehiclesListLoaded(vehicles));
        }
      },
    );
  }
}