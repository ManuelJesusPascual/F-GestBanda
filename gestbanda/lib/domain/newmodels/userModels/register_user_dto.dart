class RegisterUserDTO {
  String name;
  String email;
  String phone;
  String password;
  String confirmPassword;

  RegisterUserDTO(
      {required this.name,
      required this.email,
      required this.phone,
      required this.password,
      required this.confirmPassword});

  RegisterUserDTO copyWith({
    String? name,
    String? email,
    String? phone,
    String? password,
    String? confirmPassword,
  }) {
    return RegisterUserDTO(
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
    );
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'email': email,
        'phone': phone,
        'password': password,
        'confirmPassword': confirmPassword
      };

  factory RegisterUserDTO.fromJson(Map<String, dynamic> json) {
    return RegisterUserDTO(
        name: json['name'],
        email: json['email'],
        phone: json['phone'],
        password: json['password'],
        confirmPassword: json['confirmPassword']);
  }
}
