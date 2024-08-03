import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

Future<dynamic> showDateModal(
  BuildContext context, {
  DateTimeRange? initialDateRange,
  DateTime? initialDate,
  required bool isRangeSelection,
}) async {
  DateTime? _focusedDay = DateTime.now();
  DateTime? _selectedDay = initialDate;
  DateTime? _rangeStart = initialDateRange?.start;
  DateTime? _rangeEnd = initialDateRange?.end;

  return await showModalBottomSheet<dynamic>(
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

          void onDaySelected(DateTime selectedDay, DateTime focusedDay) {
            setState(() {
              _selectedDay = selectedDay;
              _focusedDay = focusedDay;
              _rangeStart = selectedDay;
              _rangeEnd = selectedDay;
              print('Selected Day: $_selectedDay');
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
                    rangeStartDay: isRangeSelection ? _rangeStart : null,
                    rangeEndDay: isRangeSelection ? _rangeEnd : null,
                    availableCalendarFormats: const {
                      CalendarFormat.month: 'Mes',
                    },
                    firstDay: DateTime(2024),
                    lastDay: DateTime(2027),
                    rangeSelectionMode: isRangeSelection
                        ? RangeSelectionMode.enforced
                        : RangeSelectionMode.toggledOff,
                    startingDayOfWeek: StartingDayOfWeek.monday,
                    headerStyle: const HeaderStyle(
                      formatButtonVisible: false,
                      titleCentered: true,
                    ),
                    selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                    onRangeSelected: isRangeSelection ? onRangeSelected : null,
                    onDaySelected: isRangeSelection ? null : onDaySelected,
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
                      selectedBuilder: (context, day, focusedDay) {
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
                                  color: Theme.of(context).colorScheme.primary),
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
                          if (isRangeSelection) {
                            print(_rangeStart);
                            print(_rangeEnd);
                            Navigator.pop(
                              context,
                              DateTimeRange(
                                start: _rangeStart!,
                                end: _rangeEnd!,
                              ),
                            );
                          } else {
                            print(_selectedDay);
                            Navigator.pop(context, _selectedDay);
                          }
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
