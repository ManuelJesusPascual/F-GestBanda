import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../config/config.dart';
import '../models/Event.dart';

class EventsList extends StatelessWidget {
  const EventsList({
    super.key,
    required ValueNotifier<List<Event>> selectedEvents,
  }) : _selectedEvents = selectedEvents;

  final ValueNotifier<List<Event>> _selectedEvents;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<List<Event>>(
      valueListenable: _selectedEvents,
      builder: (context, value, _) {
        return ListView.builder(
          itemCount: value.length,
          itemBuilder: (context, index) {
            return Container(
              margin: const EdgeInsets.symmetric(
                horizontal: 12.0,
                vertical: 4.0,
              ),
              decoration: BoxDecoration(
                color: value[index].initDate.compareTo(DateTime.now()) < 0
                    ? Colors.grey
                    : Theme.of(context).colorScheme.secondary,
                border: Border.all(),
                borderRadius: BorderRadius.circular(16.0),
              ),
              child: ListTile(
                onTap: () => (context
                    .read<RouterSimpleCubit>()
                    .pushRoute("/event_detail", extra: value[index])),
                title: Text(
                  value[index].title,
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.onSecondary),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
