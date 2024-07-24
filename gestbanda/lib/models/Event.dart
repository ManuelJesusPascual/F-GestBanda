import '../utils/enums/EventTypeEnum.dart';

class Event {
  final String title;
  final DateTime initDate;
  final DateTime endDate;
  final EventType type;
  final List<String>? imgList;
  final String description;
  final String location; //Esto hay que cambiarlo para que sea lat y lang

  const Event(
      {required this.title,
      required this.type,
      required this.initDate,
      required this.endDate,
      required this.description,
      required this.location,
      this.imgList});

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

  // Deserializa un Map a un objeto Event
  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
        title: json['title'],
        initDate: DateTime.parse(json['initDate']),
        endDate: DateTime.parse(json['endDate']),
        type: EventTypeExtension.fromJson(
            json['type']), // Convierte la cadena a un enum
        imgList:
            json['imgList'] != null ? List<String>.from(json['imgList']) : null,
        description: json['description'],
        location: json['location']);
  }
}
