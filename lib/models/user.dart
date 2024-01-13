class User {
  final String phone;
  final String email;
  final String password;

  User({
    required this.phone,
    required this.email,
    required this.password,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      phone: json['phone'],
      email: json['email'],
      password: json['password'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'phone': phone,
      'email': email,
      'password': password,
    };
  }
}
