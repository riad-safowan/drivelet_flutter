class RentalResponseModel {
  final String message;

  const RentalResponseModel({required this.message});

  factory RentalResponseModel.fromJson(Map<String, dynamic> json) {
    return RentalResponseModel(
      message: json['message'] as String,
    );
  }
}