import 'package:equatable/equatable.dart';

import '../../../../domain/entities/vehicle.dart';

abstract class VehicleDetailState extends Equatable {
  const VehicleDetailState();

  @override
  List<Object> get props => [];
}

class VehicleDetailInitial extends VehicleDetailState {}

class VehicleDetailLoading extends VehicleDetailState {}

class VehicleDetailLoaded extends VehicleDetailState {
  final Vehicle vehicle;

  const VehicleDetailLoaded(this.vehicle);

  @override
  List<Object> get props => [vehicle];
}

class VehicleDetailError extends VehicleDetailState {
  final String message;

  const VehicleDetailError(this.message);

  @override
  List<Object> get props => [message];
}

class RentalStarting extends VehicleDetailLoaded {
  RentalStarting(super.vehicle);
}

class RentalStarted extends VehicleDetailLoaded {
  final String message;

  const RentalStarted({required this.message, required Vehicle vehicle})
    : super(vehicle);

  @override
  List<Object> get props => [message, vehicle];
}

class RentalError extends VehicleDetailLoaded {
  final String message;

  const RentalError({required this.message, required Vehicle vehicle})
    : super(vehicle);

  @override
  List<Object> get props => [message];
}
