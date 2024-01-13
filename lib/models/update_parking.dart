class UpdateParking {
  final String location;
  final String priceperhour;

  UpdateParking({
    required this.location,
    required this.priceperhour,
  });

  factory UpdateParking.fromJson(Map<String, dynamic> json) {
    return UpdateParking(
      location: json['location'],
      priceperhour: json['priceperhour'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'location': location,
      'priceperhour': priceperhour,
    };
  }
}
