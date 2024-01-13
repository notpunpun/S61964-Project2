class ParkingID {
  final String id;

  ParkingID({
    required this.id,
  });

  factory ParkingID.fromJson(Map<String, dynamic> json) {
    return ParkingID(
      id: json['id'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'Parking Id': id,
    };
  }
}
