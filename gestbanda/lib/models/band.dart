class Band {
  String name;
  String suscription;
  String? img;

  Band({
    required this.name,
    required this.suscription,
    this.img,
  });

  Band copyWith({
    String? name,
    String? suscription,
    String? img,
  }) {
    return Band(
      name: name ?? this.name,
      suscription: suscription ?? this.suscription,
      img: img ?? this.img,
    );
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'suscription': suscription,
        'img': img,
      };

  factory Band.fromJson(Map<String, dynamic> json) {
    return Band(
      name: json['name'],
      suscription: json['suscription'],
      img: json['img'],
    );
  }
}
