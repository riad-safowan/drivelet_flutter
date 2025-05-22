import '../../domain/entities/vehicle.dart';
import 'location_model.dart';

class VehicleModel extends Vehicle {
  const VehicleModel({
    required super.id,
    required super.name,
    required super.type,
    required super.status,
    required super.image,
    required super.battery,
    required super.location,
    required super.costPerMinute,
  });

  factory VehicleModel.fromJson(Map<String, dynamic> json) {
    return VehicleModel(
      id: json['id'] as String,
      name: json['name'] as String,
      type: json['type'] as String,
      status: json['status'] as String,
      image: json['image'] as String,
      battery: json['battery'] as int,
      location: LocationModel.fromJson(json['location'] as Map<String, dynamic>),
      costPerMinute: (json['cost_per_minute'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'type': type,
      'status': status,
      'image': image,
      'battery': battery,
      'location': (location as LocationModel).toJson(),
      'cost_per_minute': costPerMinute,
    };
  }
}