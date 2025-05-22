import 'package:equatable/equatable.dart';

abstract class VehicleDetailEvent extends Equatable {
  const VehicleDetailEvent();

  @override
  List<Object> get props => [];
}

class GetVehicleDetailRequested extends VehicleDetailEvent {
  final String vehicleId;

  const GetVehicleDetailRequested(this.vehicleId);

  @override
  List<Object> get props => [vehicleId];
}

class StartRentalRequested extends VehicleDetailEvent {
  final String vehicleId;

  const StartRentalRequested(this.vehicleId);

  @override
  List<Object> get props => [vehicleId];
}