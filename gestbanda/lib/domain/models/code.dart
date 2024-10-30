class Code {
  final String code;
  final String voz;
  final DateTime dateCreated;
  DateTime dateEnd;

  Code(
      {required this.code,
      required this.voz,
      required this.dateCreated,
      required this.dateEnd});

  Code copyWith({
    String? code,
    String? voz,
    DateTime? dateCreated,
    DateTime? dateEnd,
  }) {
    return Code(
      code: code ?? this.code,
      voz: voz ?? this.voz,
      dateCreated: dateCreated ?? this.dateCreated,
      dateEnd: dateEnd ?? this.dateEnd,
    );
  }

  Map<String, dynamic> toJson() => {
        'code': code,
        'voz': voz,
        'dateCreated': dateCreated.toIso8601String(),
        'dateEnd': dateEnd.toIso8601String(),
      };

  factory Code.fromJson(Map<String, dynamic> json) {
    return Code(
      code: json['code'],
      voz: json['voz'],
      dateCreated: DateTime.parse(json['dateCreated']),
      dateEnd: DateTime.parse(json['dateEnd']),
    );
  }
}
