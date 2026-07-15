class UserModel {
  final dynamic id;
  final dynamic name;
  final dynamic email;
  final dynamic password;
  final dynamic carNumber;
  final dynamic univNumber;
  final dynamic driverLicense;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.carNumber,
    required this.univNumber,
    required this.driverLicense,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as dynamic,
      name: json['name'] as dynamic,
      email: json['email'] as dynamic,
      password: json['password'] as dynamic,
      carNumber: json['car_number'] as dynamic,
      univNumber: json['univ_number'] as dynamic,
      driverLicense: json['driver_license'] as dynamic,
    );
  }
}
