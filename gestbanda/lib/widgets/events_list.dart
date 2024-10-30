import 'package:flutter/material.dart';
import 'package:gestbanda/widgets/event_tile.dart';

import '../domain/models/event.dart';

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
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: EventTile(event: value[index]),
            );
          },
        );
      },
    );
  }
}
