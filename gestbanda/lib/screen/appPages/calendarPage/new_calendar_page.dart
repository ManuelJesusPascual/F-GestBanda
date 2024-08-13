import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gestbanda/utils/enums/EventTypeEnum.dart';
import 'package:gestbanda/widgets/new_main_bottom_bar.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../config/config.dart';
import '../../../models/Event.dart';
import '../../../widgets/new_events_list.dart';
import '../../../widgets/widgets.dart';

class NewCalendarPage extends StatefulWidget {
  const NewCalendarPage({super.key});

  @override
  State<NewCalendarPage> createState() => _NewCalendarPageState();
}

class _NewCalendarPageState extends State<NewCalendarPage> {
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
      bottomNavigationBar: const NewMainBottomBar(currentIndex: 0),
      backgroundColor: Theme.of(context).colorScheme.surface,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).colorScheme.onSurface,
        onPressed: () {
          context.read<RouterSimpleCubit>().pushRoute(
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
              const NewHeader(),
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
                              color: Theme.of(context).colorScheme.secondary,
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
                                      .secondary
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
                          child: NewEventsList(selectedEvents: _selectedEvents),
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
        // Determinar el color del evento
        int colorPriority(DateTime eventDate) {
          final differenceInHours =
              eventDate.difference(DateTime.now()).inHours;
          if (differenceInHours < -2) {
            return 3; // Rojo
          } else if (differenceInHours > 2) {
            return 2; // Ámbar
          } else {
            return 1; // Verde
          }
        }

        // Comparar por prioridad del color
        final colorPriorityA = colorPriority(a.initDate);
        final colorPriorityB = colorPriority(b.initDate);

        if (colorPriorityA != colorPriorityB) {
          // Primero ordenar por prioridad del color
          return colorPriorityA.compareTo(colorPriorityB);
        }

        // Dentro del mismo grupo de color, ordenar por fecha (más próxima primero)
        return a.initDate.compareTo(b.initDate);
      });
  }

  final _kEventSource = [
    Event(
        title: 'Concierto Almería',
        type: EventType.concierto,
        initDate: DateTime(2024, 8, 8, 18, 30),
        endDate: DateTime(2024, 8, 8, 20, 30),
        description: "a",
        location: "Almeria"),
    Event(
        title: 'Concierto Almería',
        type: EventType.concierto,
        initDate: DateTime(2024, 8, 8, 8, 30),
        endDate: DateTime(2024, 8, 8, 20, 30),
        description: "a",
        location: "Almeria"),
    Event(
        title: 'Concierto Almería',
        type: EventType.concierto,
        initDate: DateTime(2024, 8, 8, 23, 30),
        imgList: [
          ""
        ],
        endDate: DateTime(2024, 8, 8, 20, 30),
        description: "a",
        location: "Almeria"),
    Event(
        title: 'Lunes Santo',
        type: EventType.pasacalles,
        initDate: DateTime(2024, 8, 15),
        endDate: DateTime(2024, 8, 15, 20, 30),
        description: "a",
        location: "Sanlucar de Barrameda"),
    Event(
        title: 'Pasacalles Navideño',
        type: EventType.pasacalles,
        initDate: DateTime(2024, 8, 1),
        endDate: DateTime(2024, 8, 1, 20, 30),
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
        imgList: [
          ""
        ],
        type: EventType.concierto,
        initDate: DateTime(2024, 8, 1),
        endDate: DateTime(2024, 8, 1, 20, 30),
        description: "a",
        location: "Sanlucar de Barrameda"),
  ];
}
