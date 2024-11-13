class PokeModel {
  final String name;
  final String type;
  final double lat;
  final double lng;
  final String photo;

  const PokeModel({
    required this.name,
    required this.type,
    required this.lat,
    required this.lng,
    required this.photo,
  });

  PokeModel copyWith({String? name, String? type, double? lat, double? lng,String? photo}) {
    return PokeModel(
      name: name ?? this.name,
      type: type ?? this.type,
      lat: lat ?? this.lat,
      lng: lng ?? this.lng,
      photo: photo ?? this.photo,
    );
  }

  factory PokeModel.fromJson(Map<String, dynamic> json) => PokeModel(
        name: json["name"],
        type: json["type"],
        lat: json["lat"],
        lng: json["lng"],
        photo: json["photo"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "type": type,
        "lat": lat,
        "lng": lng,
        "photo": photo,
      };
}
