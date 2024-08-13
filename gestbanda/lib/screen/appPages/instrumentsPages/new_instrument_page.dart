import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gestbanda/widgets/instrument_tile.dart';

import '../../../config/config.dart';
import '../../../models/Instrument.dart';

class NewInstrumentPage extends StatelessWidget {
  NewInstrumentPage({super.key});

  final List<Instrument> instruments = [
    Instrument(
      img: "",
      name: "Corneta Do/Sib",
      quantity: 2,
      borrowedQuantity: 1,
    ),
    Instrument(
      img: "",
      name: "Corneta Do/Reb",
      quantity: 2,
      borrowedQuantity: 1,
    ),
    Instrument(
      img: "",
      name: "Trompeta Do",
      quantity: 2,
      borrowedQuantity: 1,
    ),
    Instrument(
      img: "",
      name: "Trompeta Si",
      quantity: 2,
      borrowedQuantity: 1,
    ),
    Instrument(
      img: "",
      name: "Trombon de varas",
      quantity: 2,
      borrowedQuantity: 1,
    ),
    Instrument(
      img: "",
      name: "Trombon de pistones",
      quantity: 2,
      borrowedQuantity: 1,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        onPressed: () {
          context
              .read<RouterSimpleCubit>()
              .pushRoute("/instrument_create_modify");
        },
        child: Icon(Icons.add, color: Theme.of(context).colorScheme.surface),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Text(
                "Listado de instrumentos",
                style: Theme.of(context).textTheme.titleLarge,
                textAlign: TextAlign.center,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 20),
                child: Text(
                  "Listado de instrumentos que posee la banda",
                  style: Theme.of(context).textTheme.labelLarge,
                  textAlign: TextAlign.center,
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: instruments.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: InstrumentTile(instrument: instruments[index]),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
