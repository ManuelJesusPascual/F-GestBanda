class BandDTO {
  String id;
  String name;
  String? img;
  String? subscriptionID;
  DateTime? substriptionEndDate;

  BandDTO({
    required this.id,
    required this.name,
    required this.img,
    required this.subscriptionID,
    required this.substriptionEndDate,
  });

  BandDTO copyWith({
    String? id,
    String? name,
    String? img,
    String? subscriptionID,
    DateTime? substriptionEndDate,
    DateTime? updatedAt,
    DateTime? createdAt,
    required String token,
  }) {
    return BandDTO(
      id: id ?? this.id,
      name: name ?? this.name,
      img: img ?? this.img,
      subscriptionID: subscriptionID ?? this.subscriptionID,
      substriptionEndDate: substriptionEndDate ?? this.substriptionEndDate,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'img': img,
        'subscriptionID': subscriptionID,
        'substriptionEndDate': substriptionEndDate,
      };

  factory BandDTO.fromJson(Map<String, dynamic> json) {
    return BandDTO(
        id: json['id'],
        name: json['name'],
        img: json['img'],
        subscriptionID: json['subscriptionID'],
        substriptionEndDate: json['substriptionEndDate']);
  }

  static List<BandDTO> listFromJson(List<dynamic> jsonList) {
    return jsonList.map((json) => BandDTO.fromJson(json)).toList();
  }
}
