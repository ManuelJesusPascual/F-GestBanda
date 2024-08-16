import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../config/config.dart';

class NewHeader extends StatelessWidget {
  const NewHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
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
            onPressed: () {
              context.read<RouterSimpleCubit>().pushRoute("/settings");
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
