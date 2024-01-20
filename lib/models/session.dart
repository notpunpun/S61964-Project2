class Session {
  final String type;
  final String plate;
  final String location;
  final String price;
  final String duration;
  final String spot;
  final DateTime date;

  Session({
    required this.plate,
    required this.type,
    required this.duration,
    required this.price,
    required this.location,
    required this.spot,
    required this.date,
  });

  factory Session.fromJson(Map<String, dynamic> json) {
    return Session(
        plate: json['plate'],
        type: json['type'],
        duration: json['duration'],
        price: json['price'],
        location: json['location'],
        spot: json['spot'],
        date: DateTime.parse(json['date']));
  }
  Map<String, dynamic> toJson() {
    return {
      'plate': plate,
      'type': type,
      'duration': duration,
      'price': price,
      'location': location,
      'spot': spot,
      'date': date.toIso8601String(),
    };
  }
}
