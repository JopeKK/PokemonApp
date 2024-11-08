class PokeModel {
  final String name;
  final String type;

  const PokeModel({
    required this.name,
    required this.type,
  });

  PokeModel copyWith({
    String? name,
    String? type,
  }) {
    return PokeModel(
      name: name ?? this.name,
      type: type ?? this.type,
    );
  }

  factory PokeModel.fromJson(Map<String, dynamic> json) => PokeModel(
        name: json["name"],
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "type": type,
      };
}
