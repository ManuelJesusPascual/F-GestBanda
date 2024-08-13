import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:gestbanda/models/Event.dart';

import '../config/config.dart';
import '../utils/enums/EventTypeEnum.dart';
import 'widgets.dart';

class EventTile extends StatelessWidget {
  final Event event;

  const EventTile({super.key, required this.event});
  @override
  Widget build(BuildContext context) {
    final DateTime now = DateTime.now();

    // Calcula la diferencia de tiempo en horas
    final Duration difference = event.initDate.difference(now);
    final double differenceInHours = difference.inMinutes / 60.0;

    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        padding: const EdgeInsets.all(8.0),
        fixedSize: const Size(100, 70),
      ),
      onPressed: () {
        context
            .read<RouterSimpleCubit>()
            .pushRoute("/event_detail", extra: event);
      },
      child: Row(
        children: [
          Container(
            height: 50,
            width: 50,
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(8))),
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              child: (event.imgList != null && event.imgList!.isNotEmpty)
                  ? CachedNetworkImage(
                      imageUrl: event.imgList!.first,
                      cacheManager: CacheManager(
                        Config(
                          event.imgList!.first,
                          stalePeriod: const Duration(days: 7),
                        ),
                      ),
                      placeholder: (context, url) => const Center(
                        child: CircularProgressIndicator(),
                      ),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: double.infinity,
                      alignment: Alignment.center,
                      fadeInDuration: Duration.zero,
                    )
                  : const ImagePlaceholder(),
            ),
          ),
          const SizedBox(
            width: 15,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        event.title,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onSurface,
                          fontSize: 16,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Container(
                      height: 10,
                      width: 10,
                      margin: const EdgeInsets.only(left: 10, right: 10),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: differenceInHours < -2
                            ? Theme.of(context).colorScheme.error
                            : differenceInHours > 2
                                ? const Color(0xFFFFC107)
                                : const Color(0xFF388E3C),
                        gradient: LinearGradient(
                          colors: [
                            differenceInHours < -2
                                ? Theme.of(context)
                                    .colorScheme
                                    .error
                                    .withOpacity(0.7)
                                : differenceInHours > 2
                                    ? const Color(0xFFFFC107).withOpacity(0.7)
                                    : const Color(0xFF66BB6A),
                            differenceInHours < -2
                                ? Theme.of(context).colorScheme.error
                                : differenceInHours > 2
                                    ? const Color(0xFFFFC107)
                                    : const Color(0xFF388E3C),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: differenceInHours < -2
                                ? Theme.of(context)
                                    .colorScheme
                                    .error
                                    .withOpacity(0.6)
                                : differenceInHours > 2
                                    ? const Color(0xFFFFC107).withOpacity(0.6)
                                    : const Color(0xFF66BB6A).withOpacity(0.6),
                            blurRadius: 3,
                            spreadRadius: 1,
                          ),
                        ],
                        border: Border.all(
                          color: Colors.white.withOpacity(0.8),
                          width: 1.5,
                        ),
                      ),
                    ),
                  ],
                ),
                Text(
                  EventTypeExtension.eventTypeToString(event.type),
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onSecondary,
                    fontWeight: FontWeight.w300,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          Icon(
            Icons.arrow_forward_ios_outlined,
            color: Theme.of(context).colorScheme.onSurface,
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
