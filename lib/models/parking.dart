class ParkingSpot {
  final String id;
  final double price;

  ParkingSpot({required this.id, required this.price});

  factory ParkingSpot.fromJson(Map<String, dynamic> json) {
    return ParkingSpot(
      id: json['id'],
      price: json['price'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'price': price,
    };
  }
}
