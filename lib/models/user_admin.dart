class UserAdmin {
  String email;
  String password;
  String fullName;
  String address;
  DateTime birthDay;
  String sex;
  String idAccount;
  String role;

  UserAdmin({
    required this.email,
    required this.password,
    required this.fullName,
    required this.address,
    required this.birthDay,
    required this.sex,
    required this.idAccount,
    required this.role,
  });

  factory UserAdmin.fromJson(Map<String, dynamic> json) {
    return UserAdmin(
      email: json['email'],
      password: json['password'],
      fullName: json['fullName'],
      address: json['address'],
      birthDay: DateTime.parse(json['birthDay']),
      sex: json['sex'],
      idAccount: json['idAccount'],
      role: json['role'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
      'fullName': fullName,
      'address': address,
      'birthDay': birthDay.toIso8601String(),
      'sex': sex,
      'idAccount': idAccount,
      'role': role,
    };
  }
}