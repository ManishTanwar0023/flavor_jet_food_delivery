class UserModel {
 final int id;
 final String name;
 final String email;
 final String password;
 final String phone;
 final String token;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.phone,
    required this.token,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] is int ? json['id'] : (json['id'] != null ? int.tryParse(json['id'].toString()) ?? 0 : 0),
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      password: json['password'] ?? '',
      phone: json['phone'] ?? '',
      token: json['token'] ?? '',
    );
  }

  // factory UserModel.fromJson(Map<String, dynamic> json) {
  //   return UserModel(
  //     id: json['id'],
  //     name: json['name'],
  //     email: json['email'],
  //     password: json['password'],
  //     phone: json['phone'],
  //     token: json['token'],
  //   );
  // }


  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'password': password,
      'phone': phone,
      'token': token,
    };
  }
}
