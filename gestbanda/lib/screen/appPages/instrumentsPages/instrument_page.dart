import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gestbanda/widgets/widgets.dart';

import '../../../config/config.dart';
import '../../../models/Instrument.dart';

class InstrumentPage extends StatelessWidget {
  const InstrumentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context
              .read<RouterSimpleCubit>()
              .pushRoute("/instrument_create_modify");
        },
        child: const Icon(Icons.add),
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
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Wrap(
                      spacing: 10.0,
                      runSpacing: 20.0,
                      children: [
                        InstrumentItem(
                          instrument: Instrument(
                            img: "assets/camisa.png",
                            name: "Corneta Do/Sib",
                            quantity: 2,
                            borrowedQuantity: 1,
                          ),
                        ),
                        InstrumentItem(
                          instrument: Instrument(
                            img: "assets/camisa.png",
                            name: "Corneta Do/Reb",
                            quantity: 2,
                            borrowedQuantity: 1,
                          ),
                        ),
                        InstrumentItem(
                          instrument: Instrument(
                            img: "assets/camisa.png",
                            name: "Trompeta Do",
                            quantity: 2,
                            borrowedQuantity: 1,
                          ),
                        ),
                        InstrumentItem(
                          instrument: Instrument(
                            img: "assets/camisa.png",
                            name: "Trompeta Si",
                            quantity: 2,
                            borrowedQuantity: 1,
                          ),
                        ),
                        InstrumentItem(
                          instrument: Instrument(
                            img: "assets/camisa.png",
                            name: "Trombon de varas",
                            quantity: 2,
                            borrowedQuantity: 1,
                          ),
                        ),
                        InstrumentItem(
                          instrument: Instrument(
                            img: "assets/camisa.png",
                            name: "Trombon de pistones",
                            quantity: 2,
                            borrowedQuantity: 1,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
