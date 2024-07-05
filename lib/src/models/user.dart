class User {
  int? id;
  String name;
  String last_name;
  String password;
  String email;
  String password_confirmation;

  User({required this.name, required this.last_name, required this.password, required this.email, required this.password_confirmation, this.id});

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'last_name': last_name,
      'password': password,
      'email': email,
      'password_confirmation': password_confirmation
    };
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] ?? 1,
      name: json['name'] ?? '',
      last_name: json['last_name'] ?? '',
      password: json['password'] ?? '',
      email: json['email'] ?? '',
      password_confirmation: json['password_confirmation'] ?? '',
    );
  }

  String toQueryParameters() {
    return 'name=$name&last_name=$last_name&email=$email&password=$password&password_confirmation=$password_confirmation';
  }
}
