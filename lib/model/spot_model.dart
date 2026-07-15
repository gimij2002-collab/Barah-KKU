class SpotModel {
  final dynamic id;
  final dynamic name;

  SpotModel({
    required this.id,
    required this.name,
  });

  factory SpotModel.fromJson(Map<String, dynamic> json) {
    return SpotModel(
      id: json['id'] as dynamic,
      name: json['name'] as dynamic,
    );
  }
}
