enum EventType { pasacalles, salida_procesional, concierto }

extension EventTypeExtension on EventType {
  // Convierte el enum a una cadena
  String get toJson {
    switch (this) {
      case EventType.pasacalles:
        return 'pasacalles';
      case EventType.salida_procesional:
        return 'salida_procesional';
      case EventType.concierto:
        return 'concierto';
      default:
        return '';
    }
  }

  // Convierte una cadena a un enum
  static EventType fromJson(String json) {
    switch (json) {
      case 'pasacalles':
        return EventType.pasacalles;
      case 'salida_procesional':
        return EventType.salida_procesional;
      case 'concierto':
        return EventType.concierto;
      default:
        throw ArgumentError('Unknown EventType value: $json');
    }
  }

  static String eventTypeToString(EventType type) {
    switch (type) {
      case EventType.pasacalles:
        return 'Pasacalles';
      case EventType.salida_procesional:
        return 'Salida Procesional';
      case EventType.concierto:
        return 'Concierto';
      default:
        return 'Desconocido';
    }
  }
}
