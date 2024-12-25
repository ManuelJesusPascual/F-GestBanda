enum EventType { pasacalles, salidaProcesional, concierto }

extension EventTypeExtension on EventType {
  String get toJson {
    switch (this) {
      case EventType.pasacalles:
        return 'pasacalles';
      case EventType.salidaProcesional:
        return 'salida_procesional';
      case EventType.concierto:
        return 'concierto';
      default:
        return '';
    }
  }

  static EventType fromJson(String json) {
    switch (json) {
      case 'pasacalles':
        return EventType.pasacalles;
      case 'salida_procesional':
        return EventType.salidaProcesional;
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
      case EventType.salidaProcesional:
        return 'Salida Procesional';
      case EventType.concierto:
        return 'Concierto';
      default:
        return 'Desconocido';
    }
  }
}
