import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gestbanda/models/event.dart';

import '../config/config.dart';
import '../utils/enums/event_type_enum.dart';

class EventItem extends StatelessWidget {
  final Event event;

  const EventItem({super.key, required this.event});
  @override
  Widget build(BuildContext context) {
    final String month = getMonth(event.initDate);

    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
        padding: const EdgeInsets.all(8.0),
        fixedSize: const Size(100, 130),
      ),
      onPressed: () {
        context
            .read<RouterSimpleCubit>()
            .pushRoute("/event_detail", extra: event);
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Text(
                event.initDate.day.toString(),
                style: TextStyle(
                    color: Theme.of(context).colorScheme.onPrimary,
                    fontWeight: FontWeight.bold,
                    fontSize: 25),
                textAlign: TextAlign.center,
              ),
            ],
          ),
          Row(
            children: [
              Text(
                month,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onPrimary,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
          Expanded(
            child: Center(
              child: Text(
                EventTypeExtension.eventTypeToString(event.type),
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onPrimary,
                  fontSize: 10,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }

  String getMonth(DateTime date) {
    final List<String> months = [
      'Enero',
      'Febrero',
      'Marzo',
      'Abril',
      'Mayo',
      'Junio',
      'Julio',
      'Agosto',
      'Septiembre',
      'Octubre',
      'Noviembre',
      'Diciembre'
    ];
    return months[date.month - 1];
  }
}
