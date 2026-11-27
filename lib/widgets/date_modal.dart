import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

Future<dynamic> showDateModal(
  BuildContext context, {
  DateTimeRange? initialDateRange,
  DateTime? initialDate,
  required bool isRangeSelection,
}) async {
  DateTime? focusedDay = DateTime.now();
  DateTime? selectedDay = initialDate;
  DateTime? rangeStart = initialDateRange?.start;
  DateTime? rangeEnd = initialDateRange?.end;

  return await showModalBottomSheet<dynamic>(
    context: context,
    isScrollControlled: true,
    builder: (context) {
      return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          void onRangeSelected(
              DateTime? start, DateTime? end, DateTime newFocusedDay) {
            setState(() {
              selectedDay = null;
              focusedDay = newFocusedDay;
              rangeStart = start;
              rangeEnd = end;
            });
          }

          void onDaySelected(DateTime newSelectedDay, DateTime newFocusedDay) {
            setState(() {
              selectedDay = newSelectedDay;
              focusedDay = newFocusedDay;
              rangeStart = selectedDay;
              rangeEnd = selectedDay;
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
                    focusedDay: focusedDay!,
                    rangeStartDay: isRangeSelection ? rangeStart : null,
                    rangeEndDay: isRangeSelection ? rangeEnd : null,
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
                    selectedDayPredicate: (day) => isSameDay(selectedDay, day),
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
                                .withValues(alpha: 0.2),
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
                                .withValues(alpha: 0.2),
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
                                  .withValues(alpha: 0.3),
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
                                .withValues(alpha: 0.3),
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
                                .withValues(alpha: 0.3),
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
                            Navigator.pop(
                              context,
                              DateTimeRange(
                                start: rangeStart!,
                                end: rangeEnd!,
                              ),
                            );
                          } else {
                            Navigator.pop(context, selectedDay);
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
