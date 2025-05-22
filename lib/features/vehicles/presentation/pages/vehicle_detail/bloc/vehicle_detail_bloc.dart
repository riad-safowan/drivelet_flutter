import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/usecases/get_vehicle_details.dart';
import '../../../../domain/usecases/start_rental.dart';
import 'vehicle_detail_event.dart';
import 'vehicle_detail_state.dart';

class VehicleDetailBloc extends Bloc<VehicleDetailEvent, VehicleDetailState> {
  final GetVehicleDetails getVehicleDetails;
  final StartRental startRental;

  VehicleDetailBloc({
    required this.getVehicleDetails,
    required this.startRental,
  }) : super(VehicleDetailInitial()) {
    on<GetVehicleDetailRequested>(_onGetVehicleDetailRequested);
    on<StartRentalRequested>(_onStartRentalRequested);
  }

  Future<void> _onGetVehicleDetailRequested(
    GetVehicleDetailRequested event,
    Emitter<VehicleDetailState> emit,
  ) async {
    emit(VehicleDetailLoading());

    final result = await getVehicleDetails(
      VehicleDetailsParams(vehicleId: event.vehicleId),
    );

    result.fold(
      (failure) => emit(VehicleDetailError(failure.message)),
      (vehicle) => emit(VehicleDetailLoaded(vehicle)),
    );
  }

  Future<void> _onStartRentalRequested(
    StartRentalRequested event,
    Emitter<VehicleDetailState> emit,
  ) async {
    if (state is VehicleDetailLoaded) {
      emit(RentalStarting((state as VehicleDetailLoaded).vehicle));

      final result = await startRental(
        StartRentalParams(vehicleId: event.vehicleId),
      );

      result.fold(
        (failure) => emit(
          RentalError(
            message: failure.message,
            vehicle: (state as VehicleDetailLoaded).vehicle,
          ),
        ),
        (message) => emit(
          RentalStarted(
            message: message,
            vehicle: (state as VehicleDetailLoaded).vehicle,
          ),
        ),
      );
    }
  }
}
