class ProvinceEntity {
  String id;
  String name;

  ProvinceEntity({
    required this.id,
    required this.name,
  });

  factory ProvinceEntity.fromJson(Map<String, dynamic> json) {
    return ProvinceEntity(
      id: json["id"],
      name: json["name"]
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name
  };
}