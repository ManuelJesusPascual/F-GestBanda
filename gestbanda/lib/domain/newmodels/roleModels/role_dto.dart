class RoleDTO {
  String id;
  String name;
  String router;

  RoleDTO({
    required this.id,
    required this.name,
    required this.router,
  });

  RoleDTO copyWith({
    String? id,
    String? name,
    String? router,
  }) {
    return RoleDTO(
      id: id ?? this.id,
      name: name ?? this.name,
      router: router ?? this.router,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'router': router,
      };

  factory RoleDTO.fromJson(Map<String, dynamic> json) {
    return RoleDTO(
      id: json['id'],
      name: json['name'],
      router: json['router'],
    );
  }

  static listFromJson(json) {
    return json.map((e) => RoleDTO.fromJson(e)).toList();
  }
}
