class LoginUserDTO {
  String email;
  String password;

  LoginUserDTO({required this.email, required this.password});

  LoginUserDTO copyWith({
    String? email,
    String? password,
  }) {
    return LoginUserDTO(
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }

  Map<String, dynamic> toJson() => {
        'email': email,
        'password': password,
      };

  factory LoginUserDTO.fromJson(Map<String, dynamic> json) {
    return LoginUserDTO(
      email: json['email'],
      password: json['password'],
    );
  }
}
