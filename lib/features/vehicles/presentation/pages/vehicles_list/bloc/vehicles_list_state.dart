import 'package:equatable/equatable.dart';

import '../../../../domain/entities/vehicle.dart';

abstract class VehiclesListState extends Equatable {
  const VehiclesListState();

  @override
  List<Object> get props => [];
}

class VehiclesListInitial extends VehiclesListState {}

class VehiclesListLoading extends VehiclesListState {}

class VehiclesListLoaded extends VehiclesListState {
  final List<Vehicle> vehicles;

  const VehiclesListLoaded(this.vehicles);

  @override
  List<Object> get props => [vehicles];
}

class VehiclesListError extends VehiclesListState {
  final String message;

  const VehiclesListError(this.message);

  @override
  List<Object> get props => [message];
}

class VehiclesListEmpty extends VehiclesListState {}