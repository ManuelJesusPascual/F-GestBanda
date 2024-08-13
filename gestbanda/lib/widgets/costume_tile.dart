import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import '../config/config.dart';
import '../models/Costume.dart';
import '../utils/string_utilites.dart';

class CostumeTile extends StatelessWidget {
  const CostumeTile({super.key, required this.costume});

  final Costume costume;

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
          onPressed: () {
            context
                .read<RouterSimpleCubit>()
                .pushRoute("/costume_create_modify", extra: costume);
          },
          child: Container(
            padding: const EdgeInsets.all(8.0),
            margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 4),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  foregroundColor: Theme.of(context).colorScheme.onPrimary,
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  backgroundImage: costume.img != null
                      ? CachedNetworkImageProvider(
                          costume.img!,
                          cacheManager: CacheManager(
                            Config(
                              costume.img!,
                              stalePeriod: const Duration(days: 7),
                            ),
                          ),
                        )
                      : null,
                  radius: 25,
                  child: costume.img != null
                      ? null
                      : Text(getInitials(costume.name)),
                ),
                const SizedBox(width: 16.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        costume.name,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onSurface,
                          fontSize: 16.0,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Text(
                        "Cantidad: ${costume.quantity}  - Prestados: ${costume.borrowedQuantity}",
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
