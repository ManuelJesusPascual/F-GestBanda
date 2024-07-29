// date_modal.dart

import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

Future<DateTimeRange?> showDateModal(
    BuildContext context, DateTimeRange initialDateRange) async {
  DateTime? _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  DateTime? _rangeStart = initialDateRange.start;
  DateTime? _rangeEnd = initialDateRange.end;
  return await showModalBottomSheet<DateTimeRange>(
    context: context,
    isScrollControlled: true,
    builder: (context) {
      return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          void onRangeSelected(
              DateTime? start, DateTime? end, DateTime focusedDay) {
            setState(() {
              _selectedDay = null;
              _focusedDay = focusedDay;
              _rangeStart = start;
              _rangeEnd = end;
              print('Selected Range: Start: $_rangeStart, End: $_rangeEnd');
            });
          }

          return Container(
            height: 500,
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Expanded(
                  child: TableCalendar(
                    locale: 'es_ES',
                    focusedDay: _focusedDay!,
                    rangeStartDay: _rangeStart,
                    rangeEndDay: _rangeEnd,
                    availableCalendarFormats: const {
                      CalendarFormat.month: 'Mes',
                    },
                    firstDay: DateTime(2024),
                    lastDay: DateTime(2027),
                    rangeSelectionMode: RangeSelectionMode.enforced,
                    startingDayOfWeek: StartingDayOfWeek.monday,
                    headerStyle: const HeaderStyle(
                      formatButtonVisible: false,
                      titleCentered: true,
                    ),
                    selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                    onRangeSelected: onRangeSelected,
                    calendarBuilders: CalendarBuilders(
                      rangeStartBuilder: (context, day, focusedDay) {
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
                              '${day.day}',
                              style: TextStyle(
                                  color: Theme.of(context).colorScheme.primary),
                            ),
                          ),
                        );
                      },
                      rangeEndBuilder: (context, day, focusedDay) {
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
                              '${day.day}',
                              style: TextStyle(
                                  color: Theme.of(context).colorScheme.primary),
                            ),
                          ),
                        );
                      },
                      rangeHighlightBuilder: (context, day, isWithinRange) {
                        if (isWithinRange) {
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
                                '${day.day}',
                                style: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.primary),
                              ),
                            ),
                          );
                        }
                        return null;
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
                                  color:
                                      Theme.of(context).colorScheme.secondary),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: const Text('Cancelar'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          print(_rangeStart);
                          print(_rangeEnd);
                          Navigator.pop(
                              context,
                              DateTimeRange(
                                  start: _rangeStart!, end: _rangeEnd!));
                        },
                        child: const Text('Aceptar'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      );
    },
  );
}
