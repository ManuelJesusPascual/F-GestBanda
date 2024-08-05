//1 por fila
/*
import 'package:flutter/material.dart';

class InstrumentItem extends StatelessWidget {
  final String imagePath;
  final String instrumentName;
  final String quantity;
  final String borrowedQuantity;
  final Function()? onPressed;

  const InstrumentItem({
    super.key,
    required this.imagePath,
    required this.instrumentName,
    required this.quantity,
    required this.borrowedQuantity,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        backgroundColor: Theme.of(context).colorScheme.primary,
        padding: EdgeInsets.all(16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            imagePath,
            height: 70,
            width: 70,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  instrumentName,
                  style: Theme.of(context)
                      .textTheme
                      .labelLarge!
                      .copyWith(color: Theme.of(context).colorScheme.onPrimary),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Cantidad",
                          style: TextStyle(
                              fontSize: 10,
                              color: Theme.of(context).colorScheme.onPrimary),
                        ),
                        Text(
                          quantity,
                          style: TextStyle(
                              fontSize: 10,
                              color: Theme.of(context).colorScheme.onPrimary),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Prestados",
                          style: TextStyle(
                              fontSize: 10,
                              color: Theme.of(context).colorScheme.onPrimary),
                        ),
                        Text(
                          borrowedQuantity,
                          style: TextStyle(
                              fontSize: 10,
                              color: Theme.of(context).colorScheme.onPrimary),
                        ),
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
*/

//2 por fila

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../config/config.dart';
import '../models/Instrument.dart';

class InstrumentItem extends StatelessWidget {
  final Instrument instrument;

  const InstrumentItem({super.key, required this.instrument});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        context
            .read<RouterSimpleCubit>()
            .pushRoute("/instrument_create_modify", extra: instrument);
      },
      style: TextButton.styleFrom(
        backgroundColor: Theme.of(context).colorScheme.primary,
        fixedSize: const Size(150, 130),
        padding: const EdgeInsets.all(5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            instrument.img,
            height: 70,
            width: 70,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  instrument.name,
                  style: Theme.of(context)
                      .textTheme
                      .labelLarge!
                      .copyWith(color: Theme.of(context).colorScheme.onPrimary),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 4),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Cantidad",
                      style: TextStyle(
                          fontSize: 10,
                          color: Theme.of(context).colorScheme.onPrimary),
                    ),
                    Text(
                      instrument.quantity.toString(),
                      style: TextStyle(
                          fontSize: 10,
                          color: Theme.of(context).colorScheme.onPrimary),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Prestados",
                      style: TextStyle(
                          fontSize: 10,
                          color: Theme.of(context).colorScheme.onPrimary),
                    ),
                    Text(
                      instrument.borrowedQuantity.toString(),
                      style: TextStyle(
                          fontSize: 10,
                          color: Theme.of(context).colorScheme.onPrimary),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
