class UserDTO {
  String id;
  String name;
  String email;
  String phone;
  String token;

  UserDTO({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.token,
  });

  UserDTO copyWith({
    String? id,
    String? name,
    String? email,
    String? phone,
    String? token,
  }) {
    return UserDTO(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      token: token ?? this.token,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'email': email,
        'phone': phone,
        'token': token,
      };

  factory UserDTO.fromJson(Map<String, dynamic> json) {
    return UserDTO(
        id: json['id'],
        name: json['name'],
        email: json['email'],
        phone: json['phone'],
        token: json['token'] ?? '');
  }
}
