class SignupModel {
  String name;
  String email;
  String password;
  String phone;

  SignupModel({
    required this.name,
    required this.email,
    required this.password,
    required this.phone,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["name"] = this.name;
    data["email"] = this.email;
    data["password"] = this.password;
    data["phone"] = this.phone;
    return data;
  }
}
