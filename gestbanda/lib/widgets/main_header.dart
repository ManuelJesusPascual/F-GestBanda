import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../config/config.dart';

class Header extends ConsumerWidget {
  const Header({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      children: [
        const CircleAvatar(
          backgroundImage: AssetImage("assets/logoBanda.png"),
          backgroundColor: Colors.transparent,
          radius: 20,
        ),
        const Expanded(
          child: Text(
            "Banda Municipal de Villaejemplo",
            textAlign: TextAlign.center,
            softWrap: true,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        SizedBox(
          width: 24,
          height: 24,
          child: IconButton(
            padding: EdgeInsets.zero,
            onPressed: () async {
              final router = await ref.read(appRouterProvider.future);

              router.push("/settings");
            },
            icon: Icon(
              Icons.settings,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
        ),
      ],
    );
  }
}
