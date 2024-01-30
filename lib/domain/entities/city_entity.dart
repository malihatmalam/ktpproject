class CityEntity {
  String id;
  String provinceId;
  String name;

  CityEntity({
    required this.id,
    required this.provinceId,
    required this.name,
  });

  factory CityEntity.fromJson(Map<String, dynamic> json) {
    return CityEntity(
        id: json["id"],
        provinceId: json["province_id"],
        name: json["name"]
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "province_id": provinceId,
    "name": name
  };
}