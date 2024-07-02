import 'package:flutter/material.dart';

class Instrument extends StatelessWidget {
  final String imagePath;
  final String instrumentName;
  final String quantity;

  const Instrument({
    //TODO: Renombrar esto porque lo uso tambien para la ropa
    super.key,
    required this.imagePath,
    required this.instrumentName,
    required this.quantity,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          imagePath,
          height: 100,
          width: 100,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Text(
            instrumentName,
            style: Theme.of(context).textTheme.labelLarge,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 4.0),
          child: Text(
            quantity,
          ),
        ),
      ],
    );
  }
}
