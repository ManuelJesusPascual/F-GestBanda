class Code {
  final String code;
  final DateTime dateCreated;
  DateTime dateEnd;

  Code({required this.code, required this.dateCreated, required this.dateEnd});

  Code copyWith({
    String? code,
    DateTime? dateCreated,
    DateTime? dateEnd,
  }) {
    return Code(
      code: code ?? this.code,
      dateCreated: dateCreated ?? this.dateCreated,
      dateEnd: dateEnd ?? this.dateEnd,
    );
  }

  Map<String, dynamic> toJson() => {
        'code': code,
        'dateCreated': dateCreated.toIso8601String(),
        'dateEnd': dateEnd.toIso8601String(),
      };

  factory Code.fromJson(Map<String, dynamic> json) {
    return Code(
      code: json['code'],
      dateCreated: DateTime.parse(json['dateCreated']),
      dateEnd: DateTime.parse(json['dateEnd']),
    );
  }
}
