class Costume {
  String name;
  final String img;
  int quantity;
  int borrowedQuantity;

  Costume({
    required this.name,
    required this.quantity,
    required this.borrowedQuantity,
    required this.img,
  });

  Costume copyWith({
    String? name,
    String? img,
    int? quantity,
    int? borrowedQuantity,
  }) {
    return Costume(
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

  factory Costume.fromJson(Map<String, dynamic> json) {
    return Costume(
      name: json['name'],
      img: json['img'],
      quantity: json['quantity'],
      borrowedQuantity: json['borrowedQuantity'],
    );
  }
}
