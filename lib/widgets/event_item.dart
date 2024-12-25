import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gestbanda/domain/models/event.dart';
import 'package:gestbanda/utils/string_utilites.dart';

import '../config/config.dart';
import 'widgets.dart';

class EventItem extends ConsumerWidget {
  final Event event;

  const EventItem({super.key, required this.event});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.all(8.0),
        fixedSize: const Size(400, 100),
      ),
      onPressed: () async {
        final router = await ref.read(appRouterProvider.future);

        router.push("/event_detail", extra: event);
      },
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  event.title,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onSurface,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  formatDateTime(event.initDate, "d MMMM yyyy"),
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.onSecondary,
                      fontSize: 14,
                      fontWeight: FontWeight.normal),
                ),
              ],
            ),
            Container(
                height: 100,
                width: 120,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(16))),
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(16)),
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
                ))
          ],
        ),
      ),
    );
  }
}
