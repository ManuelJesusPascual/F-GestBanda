import 'package:flutter/material.dart';
import 'package:gestbanda/utils/enums/EventTypeEnum.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../models/Event.dart';
import '../../../widgets/widgets.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  late final ValueNotifier<List<Event>> _selectedEvents;

  CalendarFormat _calendarFormat = CalendarFormat.month;

  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;
    _selectedEvents = ValueNotifier(_getEventsForDay(_selectedDay!));
  }

  @override
  void dispose() {
    _selectedEvents.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TableCalendar<Event>(
          locale: 'es_ES',
          firstDay: DateTime(2020, 1, 1),
          lastDay: DateTime(2025, 12, 31),
          availableCalendarFormats: const {
            CalendarFormat.month: 'Mes',
          },
          headerStyle: const HeaderStyle(
            formatButtonVisible: false, // Hide the format button
            titleCentered: true, // Center the title
          ),
          focusedDay: _focusedDay,
          startingDayOfWeek: StartingDayOfWeek.monday,
          calendarStyle: CalendarStyle(
            markerDecoration: BoxDecoration(
              color: Theme.of(context)
                  .colorScheme
                  .secondary, // Change this color to your desired marker color
              shape: BoxShape.circle,
            ),
          ),
          selectedDayPredicate: (day) {
            return isSameDay(_selectedDay, day);
          },
          onDaySelected: (selectedDay, focusedDay) {
            setState(() {
              _selectedDay = selectedDay;
              _focusedDay = focusedDay;
              _selectedEvents.value = _getEventsForDay(selectedDay);
            });
          },
          onPageChanged: (focusedDay) {
            _focusedDay = focusedDay;
          },
          calendarFormat: _calendarFormat,
          onFormatChanged: (format) {
            setState(() {
              _calendarFormat = format;
            });
          },
          eventLoader: _getEventsForDay,
        ),
        const SizedBox(height: 25.0),
        Expanded(
          child: EventsList(selectedEvents: _selectedEvents),
        ),
      ],
    );
  }
}

List<Event> _getEventsForDay(DateTime day) {
  return _kEventSource
      .where((event) =>
          event.initDate.year == day.year &&
          event.initDate.month == day.month &&
          event.initDate.day == day.day)
      .toList()
    ..sort((a, b) => b.initDate.compareTo(a.initDate));
}

final _kEventSource = [
  Event(
      title: 'Concierto Almería',
      type: EventType.concierto,
      initDate: DateTime(2024, 7, 9, 17, 30),
      endDate: DateTime(2024, 7, 9, 20, 30),
      description: "a",
      location: "Almeria"),
  Event(
      title: 'Salida extraordinaria',
      type: EventType.salida_procesional,
      initDate: DateTime(2024, 7, 16, 15, 30),
      endDate: DateTime(2024, 7, 16, 20, 30),
      description: "a",
      location: "Sanlucar de Barrameda"),
  Event(
      title: 'Salida extraordinaria',
      type: EventType.salida_procesional,
      initDate: DateTime(2024, 7, 16, 16, 30),
      endDate: DateTime(2024, 7, 16, 20, 30),
      description: "a",
      location: "Sanlucar de Barrameda"),
  Event(
      title: 'Salida extraordinaria',
      type: EventType.salida_procesional,
      initDate: DateTime(2024, 7, 16, 17, 30),
      endDate: DateTime(2024, 7, 16, 20, 30),
      description: "a",
      location: "Sanlucar de Barrameda"),
  Event(
      title: 'Salida extraordinaria',
      type: EventType.salida_procesional,
      initDate: DateTime(2024, 7, 16, 18, 30),
      endDate: DateTime(2024, 7, 16, 20, 30),
      description: "a",
      location: "Sanlucar de Barrameda"),
  Event(
      title: 'Salida extraordinaria',
      type: EventType.salida_procesional,
      initDate: DateTime(2024, 7, 16, 19, 30),
      endDate: DateTime(2024, 7, 16, 20, 30),
      description: "a",
      location: "Sanlucar de Barrameda"),
  Event(
      title: 'Salida extraordinaria',
      type: EventType.salida_procesional,
      initDate: DateTime(2024, 7, 16, 20, 30),
      endDate: DateTime(2024, 7, 16, 20, 30),
      description: "a",
      location: "Sanlucar de Barrameda"),
  Event(
      title: 'Lunes Santo',
      type: EventType.salida_procesional,
      initDate: DateTime(2024, 7, 15),
      endDate: DateTime(2024, 7, 15, 20, 30),
      description: "a",
      location: "Sanlucar de Barrameda"),
  Event(
      title: 'Pasacalles Navideño',
      type: EventType.pasacalles,
      initDate: DateTime(2024, 7, 1),
      endDate: DateTime(2024, 7, 1, 20, 30),
      description: "a",
      location: "Sanlucar de Barrameda"),
  Event(
      title: 'Pasacalles Pasión',
      type: EventType.pasacalles,
      initDate: DateTime(2024, 7, 1),
      endDate: DateTime(2024, 8, 23, 20, 30),
      description: "a",
      location: "Sanlucar de Barrameda"),
  Event(
      title: 'Concierto de otoño',
      type: EventType.concierto,
      initDate: DateTime(2024, 8, 23),
      endDate: DateTime(2024, 8, 23, 20, 30),
      description: "a",
      location: "Sanlucar de Barrameda"),
  Event(
      title: 'Concierto de verano',
      type: EventType.concierto,
      initDate: DateTime(2024, 8, 1),
      endDate: DateTime(2024, 8, 1, 20, 30),
      description: "a",
      location: "Sanlucar de Barrameda"),
];
