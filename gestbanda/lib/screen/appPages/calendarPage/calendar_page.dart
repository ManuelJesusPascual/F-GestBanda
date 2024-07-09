import 'package:flutter/material.dart';
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
                  .tertiary, // Change this color to your desired marker color
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
          event.date.year == day.year &&
          event.date.month == day.month &&
          event.date.day == day.day)
      .toList();
}

final _kEventSource = [
  Event('Concierto Almería', DateTime(2024, 7, 9, 17, 30)),
  Event('Salida extraordinaria', DateTime(2024, 7, 9, 20, 30)),
  Event('Salida extraordinaria', DateTime(2024, 7, 9, 20, 30)),
  Event('Salida extraordinaria', DateTime(2024, 7, 9, 20, 30)),
  Event('Salida extraordinaria', DateTime(2024, 7, 9, 20, 30)),
  Event('Salida extraordinaria', DateTime(2024, 7, 9, 20, 30)),
  Event('Salida extraordinaria', DateTime(2024, 7, 9, 20, 30)),
  Event('Lunes Santo', DateTime(2024, 7, 15)),
  Event('Pasacalles Navideño', DateTime(2024, 7, 1)),
  Event('Pasacalles Pasión', DateTime(2024, 7, 1)),
  Event('Concierto de otoño', DateTime(2024, 8, 23)),
  Event('Concierto de verano', DateTime(2024, 8, 1)),
];
