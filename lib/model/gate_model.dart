class GateModel {
  final dynamic id;
  final dynamic name;

  GateModel({
    required this.id,
    required this.name,
  });

  factory GateModel.fromJson(Map<String, dynamic> json) {
    return GateModel(
      id: json['id'] as dynamic,
      name: json['name'] as dynamic,
    );
  }
}
