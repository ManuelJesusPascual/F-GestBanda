import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gestbanda/utils/enums/event_type_enum.dart';
import 'package:gestbanda/widgets/widgets.dart';

import '../../../../../config/config.dart';
import '../../../../../domain/models/event.dart';
import '../../../../../utils/string_utilites.dart';

class EventDetailPage extends ConsumerStatefulWidget {
  final Event event;

  const EventDetailPage({super.key, required this.event});

  @override
  ConsumerState<EventDetailPage> createState() => _EventDetailPageState();
}

class _EventDetailPageState extends ConsumerState<EventDetailPage> {
  int _current = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => {},
        child: const Icon(Icons.navigation),
      ),
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const PreviewBanner(),
            CarouselSlider(
              options: CarouselOptions(
                autoPlay: true,
                enlargeCenterPage: true,
                aspectRatio: 2.0,
                onPageChanged: (index, reason) {
                  setState(() {
                    _current = index;
                  });
                },
              ),
              items: (widget.event.imgList != null &&
                      widget.event.imgList!.isNotEmpty)
                  ? widget.event.imgList!
                      .map((item) => Center(
                          child: Image.network(item,
                              fit: BoxFit.cover,
                              width: MediaQuery.of(context).size.width)))
                      .toList()
                  : [const Center(child: ImagePlaceholder())],
            ),
            if (widget.event.imgList != null &&
                widget.event.imgList!.isNotEmpty)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: widget.event.imgList!.asMap().entries.map((entry) {
                  return Container(
                    width: 7.0,
                    height: 7.0,
                    margin: const EdgeInsets.symmetric(
                        vertical: 15.0, horizontal: 4.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: (Theme.of(context).brightness == Brightness.dark
                              ? Colors.white
                              : Colors.black)
                          .withOpacity(_current == entry.key ? 0.9 : 0.4),
                    ),
                  );
                }).toList(),
              ),
            Padding(
              padding: const EdgeInsets.only(left: 20, top: 20, right: 20),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      widget.event.title,
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () async {
                      final router = await ref.read(appRouterProvider.future);
                      router.push("/event_create_modify", extra: widget.event);
                    },
                  ),
                ],
              ),
            ),
            Row(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  child: Text(
                    EventTypeExtension.eventTypeToString(widget.event.type),
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
                const Text(" - "),
                Flexible(
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    child: Text(
                      widget.event.location,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  child: Text(formatDateTime(
                      widget.event.initDate, 'dd/MM/yyyy HH:mm')),
                ),
                const Text(" - "),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  child: Text(
                      formatDateTime(widget.event.endDate, 'dd/MM/yyyy HH:mm')),
                ),
              ],
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Text(widget.event.description),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
