import 'package:equatable/equatable.dart';

abstract class VehiclesListEvent extends Equatable {
  const VehiclesListEvent();

  @override
  List<Object> get props => [];
}

class GetVehiclesListRequested extends VehiclesListEvent {}

class RefreshVehiclesListRequested extends VehiclesListEvent {}