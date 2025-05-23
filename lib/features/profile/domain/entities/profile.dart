import 'package:equatable/equatable.dart';

class Profile extends Equatable {
  final String name;
  final String email;
  final int totalTrips;

  const Profile({
    required this.name,
    required this.email,
    required this.totalTrips,
  });

  @override
  List<Object> get props => [name, email, totalTrips];
}