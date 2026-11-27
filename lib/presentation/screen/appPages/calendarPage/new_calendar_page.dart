import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gestbanda/utils/enums/event_type_enum.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../../config/config.dart';
import '../../../../domain/models/event.dart';
import '../../../../widgets/widgets.dart';

class NewCalendarPage extends ConsumerStatefulWidget {
  const NewCalendarPage({super.key});

  @override
  ConsumerState<NewCalendarPage> createState() => _NewCalendarPageState();
}

class _NewCalendarPageState extends ConsumerState<NewCalendarPage> {
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
    return Scaffold(
      bottomNavigationBar: const MainBottomBar(currentIndex: 0),
      backgroundColor: Theme.of(context).colorScheme.surface,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).colorScheme.onSurface,
        onPressed: () async {
          final router = await ref.read(appRouterProvider.future);
          router.push(
            "/event_create_modify",
          );
        },
        child: Icon(
          Icons.add,
          color: Theme.of(context).colorScheme.surface,
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const Header(),
              Expanded(
                child: Stack(
                  children: [
                    Column(
                      children: [
                        TableCalendar<Event>(
                          locale: 'es_ES',
                          firstDay: DateTime(2020, 1, 1),
                          lastDay: DateTime(2025, 12, 31),
                          availableCalendarFormats: const {
                            CalendarFormat.month: 'Mes',
                          },
                          headerStyle: const HeaderStyle(
                            formatButtonVisible: false,
                            titleCentered: true,
                          ),
                          focusedDay: _focusedDay,
                          startingDayOfWeek: StartingDayOfWeek.monday,
                          calendarStyle: CalendarStyle(
                            markerDecoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.primary,
                              shape: BoxShape.circle,
                            ),
                          ),
                          calendarBuilders: CalendarBuilders(
                            selectedBuilder: (context, date, _) {
                              return Container(
                                margin: const EdgeInsets.all(4.0),
                                decoration: BoxDecoration(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .primary
                                      .withOpacity(0.2),
                                  shape: BoxShape.circle,
                                ),
                                child: Center(
                                  child: Text(
                                    '${date.day}',
                                    style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary),
                                  ),
                                ),
                              );
                            },
                            todayBuilder: (context, date, _) {
                              return Container(
                                margin: const EdgeInsets.all(4.0),
                                decoration: BoxDecoration(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .primary
                                      .withOpacity(0.3),
                                  shape: BoxShape.circle,
                                ),
                                child: Center(
                                  child: Text(
                                    '${date.day}',
                                    style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .secondary),
                                  ),
                                ),
                              );
                            },
                          ),
                          selectedDayPredicate: (day) {
                            return isSameDay(_selectedDay, day);
                          },
                          onDaySelected: (selectedDay, focusedDay) {
                            setState(() {
                              _selectedDay = selectedDay;
                              _focusedDay = focusedDay;
                              _selectedEvents.value =
                                  _getEventsForDay(selectedDay);
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
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Event> _getEventsForDay(DateTime day) {
    return _kEventSource
        .where((event) =>
            event.initDate.year == day.year &&
            event.initDate.month == day.month &&
            event.initDate.day == day.day)
        .toList()
      ..sort((a, b) {
        // Determine the color of the event
        int colorPriority(DateTime eventDate) {
          final differenceInHours =
              eventDate.difference(DateTime.now()).inHours;
          if (differenceInHours < -2) {
            return 3; // Red
          } else if (differenceInHours > 2) {
            return 2; // Amber
          } else {
            return 1; // Green
          }
        }

        // Compare by color priority
        final colorPriorityA = colorPriority(a.initDate);
        final colorPriorityB = colorPriority(b.initDate);

        if (colorPriorityA != colorPriorityB) {
          // First order by color priority
          return colorPriorityA.compareTo(colorPriorityB);
        }

        // Within the same color group, order by date (closest first)
        return a.initDate.compareTo(b.initDate);
      });
  }

  final _kEventSource = [
    Event(
        title: 'Concierto Almería',
        type: EventType.concierto,
        initDate: DateTime(2024, 9, 26, 19, 30),
        endDate: DateTime(2024, 9, 26, 20, 30),
        description: "a",
        location: "Almeria"),
    Event(
        title: 'Concierto Almería',
        type: EventType.concierto,
        initDate: DateTime(2024, 9, 26, 8, 30),
        endDate: DateTime(2024, 9, 26, 9, 30),
        description: "a",
        location: "Almeria"),
    Event(
        title: 'Concierto Almería',
        type: EventType.concierto,
        initDate: DateTime(2024, 9, 27, 23, 30),
        imgList: [],
        endDate: DateTime(2024, 9, 27, 20, 30),
        description: "a",
        location: "Almeria"),
    Event(
        title: 'Lunes Santo',
        type: EventType.pasacalles,
        initDate: DateTime(2024, 9, 27, 1, 0),
        endDate: DateTime(2024, 9, 27, 1, 30),
        description: "a",
        location: "Sanlucar de Barrameda"),
    Event(
        title: 'Lunes Santo',
        type: EventType.pasacalles,
        initDate: DateTime(2024, 9, 26, 11, 30),
        endDate: DateTime(2024, 9, 26, 12, 30),
        description: "a",
        location: "Sanlucar de Barrameda"),
    Event(
        title: 'Lunes Santo',
        type: EventType.pasacalles,
        initDate: DateTime(2024, 9, 15),
        endDate: DateTime(2024, 9, 15, 20, 30),
        description: "a",
        location: "Sanlucar de Barrameda"),
    Event(
        title: 'Pasacalles Navideño',
        type: EventType.pasacalles,
        initDate: DateTime(2024, 9, 1),
        endDate: DateTime(2024, 9, 1, 20, 30),
        description: "a",
        location: "Sanlucar de Barrameda"),
    Event(
        title: 'Pasacalles Pasión',
        type: EventType.pasacalles,
        initDate: DateTime(2024, 7, 1),
        endDate: DateTime(2024, 9, 23, 20, 30),
        description: "a",
        location: "Sanlucar de Barrameda"),
    Event(
        title: 'Concierto de otoño',
        type: EventType.concierto,
        initDate: DateTime(2024, 9, 23),
        endDate: DateTime(2024, 9, 23, 20, 30),
        description: "a",
        location: "Sanlucar de Barrameda"),
    Event(
        title: 'Concierto de verano',
        imgList: [],
        type: EventType.concierto,
        initDate: DateTime(2024, 9, 1),
        endDate: DateTime(2024, 9, 1, 20, 30),
        description: "a",
        location: "Sanlucar de Barrameda"),
  ];
}
