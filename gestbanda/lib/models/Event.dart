import '../utils/enums/EventTypeEnum.dart';

class Event {
  String title;
  DateTime initDate;
  DateTime endDate;
  EventType type;
  List<String>? imgList;
  String description;
  String location; //Esto hay que cambiarlo para que sea lat y lang

  Event(
      {required this.title,
      required this.type,
      required this.initDate,
      required this.endDate,
      required this.description,
      required this.location,
      this.imgList});

  Event copyWith({
    String? title,
    DateTime? initDate,
    DateTime? endDate,
    EventType? type,
    List<String>? imgList,
    String? description,
    String? location,
  }) {
    return Event(
      title: title ?? this.title,
      type: type ?? this.type,
      initDate: initDate ?? this.initDate,
      endDate: endDate ?? this.endDate,
      imgList: imgList ?? this.imgList,
      description: description ?? this.description,
      location: location ?? this.location,
    );
  }

  // Hacemos que el objeto sea serializable para que se pueda pasar a través de parámetros en el GoRouter
  Map<String, dynamic> toJson() => {
        'title': title,
        'initDate': initDate.toIso8601String(),
        'endDate': endDate.toIso8601String(),
        'type': type.toJson,
        'imgList': imgList,
        'description': description,
        'location': location
      };

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
        title: json['title'],
        initDate: DateTime.parse(json['initDate']),
        endDate: DateTime.parse(json['endDate']),
        type: EventTypeExtension.fromJson(json['type']),
        imgList:
            json['imgList'] != null ? List<String>.from(json['imgList']) : null,
        description: json['description'],
        location: json['location']);
  }
}
