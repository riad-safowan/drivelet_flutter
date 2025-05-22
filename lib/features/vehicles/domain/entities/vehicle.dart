import 'package:equatable/equatable.dart';

import 'location.dart';

class Vehicle extends Equatable {
  final String id;
  final String name;
  final String type;
  final String status;
  final String image;
  final int battery;
  final Location location;
  final double costPerMinute;

  const Vehicle({
    required this.id,
    required this.name,
    required this.type,
    required this.status,
    required this.image,
    required this.battery,
    required this.location,
    required this.costPerMinute,
  });

  @override
  List<Object> get props => [
    id,
    name,
    type,
    status,
    image,
    battery,
    location,
    costPerMinute,
  ];
}