class Instrument {
  String name;
  final String img;
  int quantity;
  int borrowedQuantity;

  Instrument({
    required this.name,
    required this.quantity,
    required this.borrowedQuantity,
    required this.img,
  });

  Instrument copyWith({
    String? name,
    String? img,
    int? quantity,
    int? borrowedQuantity,
  }) {
    return Instrument(
      name: name ?? this.name,
      img: img ?? this.img,
      quantity: quantity ?? this.quantity,
      borrowedQuantity: borrowedQuantity ?? this.borrowedQuantity,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'img': img,
      'quantity': quantity,
      'borrowedQuantity': borrowedQuantity,
    };
  }

  factory Instrument.fromJson(Map<String, dynamic> json) {
    return Instrument(
      name: json['name'],
      img: json['img'],
      quantity: json['quantity'],
      borrowedQuantity: json['borrowedQuantity'],
    );
  }

  static listFromJson(json) {
    return json.map((e) => Instrument.fromJson(e)).toList();
  }
}
