class users {
  final int id;
  final String name;
  final String email;
  final String password;
  final String remember_token;

  const users ({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.remember_token,
  });

  factory users.fromJson(Map<String, dynamic> json) {
    return users(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      password: json['password'],
      remember_token: json['remember_token'],
    );
  }
}