import 'package:flutter/material.dart';

class MainHeader extends StatelessWidget {
  const MainHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const CircleAvatar(
          backgroundImage: AssetImage("assets/logoBanda.png"),
          backgroundColor: Colors.transparent,
          radius: 30,
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 7.0),
            child: Text(
              "Banda Municipal de Villaejemplo",
              style: Theme.of(context).textTheme.titleSmall,
              textAlign: TextAlign.center,
            ),
          ),
        ),
        IconButton(
          icon: const Icon(Icons.settings),
          color: Theme.of(context).colorScheme.onSurface,
          onPressed: () {},
        ),
      ],
    );
  }
}
