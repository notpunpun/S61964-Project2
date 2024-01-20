class Detail {
  final String username;
  final String email;
  final String phone;

  Detail({
    required this.username,
    required this.email,
    required this.phone,
  });

  factory Detail.fromJson(Map<String, dynamic> json) {
    return Detail(
      username: json['username'],
      email: json["email"],
      phone: json['phone'],
    );
  }
  Map<String, dynamic> toJSon() {
    return {
      'username': username,
      'email': email,
      'phone': phone,
    };
  }
}
