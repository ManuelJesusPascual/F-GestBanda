import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import '../domain/models/instrument.dart';
import '../utils/string_utilites.dart';

class InstrumentTile extends StatelessWidget {
  const InstrumentTile(
      {super.key, required this.instrument, required this.onPressed});

  final Instrument instrument;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.zero,
            backgroundColor: Theme.of(context).colorScheme.surface,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 2,
          ),
          onPressed: onPressed,
          child: Container(
            padding: const EdgeInsets.all(8.0),
            margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 4),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  foregroundColor: Theme.of(context).colorScheme.onPrimary,
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  backgroundImage: instrument.img.isNotEmpty
                      ? CachedNetworkImageProvider(
                          instrument.img,
                          cacheManager: CacheManager(
                            Config(
                              instrument.img,
                              stalePeriod: const Duration(days: 7),
                            ),
                          ),
                        )
                      : null,
                  radius: 25,
                  child: instrument.img.isNotEmpty
                      ? null
                      : Text(getInitials(instrument.name)),
                ),
                const SizedBox(width: 16.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        instrument.name,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onSurface,
                          fontSize: 16.0,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Text(
                        "Cantidad: ${instrument.quantity}  - Prestados: ${instrument.borrowedQuantity}",
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontSize: 14.0,
                          fontWeight: FontWeight.w400,
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
          ),
        ),
      ],
    );
  }
}
