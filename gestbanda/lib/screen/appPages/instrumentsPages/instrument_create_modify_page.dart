import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gestbanda/widgets/user_tile.dart';
import 'package:gestbanda/widgets/widgets.dart';

import '../../../config/config.dart';
import '../../../models/Instrument.dart';
import '../../../models/User.dart';

class InstrumentCreateModifyPage extends StatefulWidget {
  final Instrument instrument;
  InstrumentCreateModifyPage({super.key, Instrument? instrument})
      : instrument = (instrument ??
            Instrument(name: "", img: "", quantity: 0, borrowedQuantity: 0));

  final List<User> users = [
    User(name: "Bob", role: "User", voz: "Corneta"),
    User(name: "Charlie Pepito Rodriguez", role: "User", voz: "Trompeta"),
    User(name: "Dave", role: "Admin", voz: "Corneta"),
    User(name: "Eve", role: "Guest", voz: "Trompeta"),
    User(name: "Usuario de ejemplo", role: "Admin", voz: "Corneta"),
    User(name: "Alice", role: "Admin", voz: "Trombon"),
    User(name: "Bob", role: "User", voz: "Trombon"),
    User(name: "Charlie Pepito Rodriguez", role: "User", voz: "Corneta"),
    User(name: "Dave", role: "Admin", voz: "Trombon"),
    User(name: "Eve", role: "Guest", voz: "Corneta"),
    User(name: "Usuario de ejemplo", role: "Admin", voz: "Corneta"),
  ];

  @override
  State<InstrumentCreateModifyPage> createState() =>
      _InstrumentCreateModifyPageState();
}

class _InstrumentCreateModifyPageState
    extends State<InstrumentCreateModifyPage> {
  String _selectedInstrument = 'Selecciona un instrumento';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              widget.instrument.img.isNotEmpty
                  ? "Modificar Instrumento"
                  : "Añadir Instrumento",
              style: Theme.of(context).textTheme.titleLarge,
            ),
            widget.instrument.img.isNotEmpty
                ? Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 20),
                    child: Text(
                      "Modificar ${widget.instrument.name}",
                      style: Theme.of(context).textTheme.labelLarge,
                      textAlign: TextAlign.center,
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: DropdownButtonHideUnderline(
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 20),
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.secondary,
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                        child: DropdownButtonFormField<String>(
                          value: _selectedInstrument,
                          icon: Icon(
                            Icons.arrow_drop_down,
                            color: Theme.of(context).colorScheme.surface,
                          ),
                          iconSize: 24,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Theme.of(context).colorScheme.secondary,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16.0),
                              borderSide: BorderSide.none,
                            ),
                          ),
                          dropdownColor:
                              Theme.of(context).colorScheme.secondary,
                          onChanged: (String? newValue) {
                            setState(() {
                              _selectedInstrument = newValue!;
                            });
                          },
                          items: <String>[
                            'Selecciona un instrumento',
                            'Trompeta Do/Sib',
                            'Trompeta Do/Reb',
                            'Corneta Do/Reb',
                            'Corneta Do/Sib',
                            'Trombon de pistones',
                            'Trombon de varas',
                            'Tambor',
                            'Caja',
                            'Tuba Do',
                            'Bombo',
                            'Bombardino Sib',
                            'Clarinete',
                            'Oboe',
                          ].map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                value,
                                style: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.surface),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ),
            CustomTextInput(
              label: "Cantidad",
              hint: "Cantidad",
              initalValue: widget.instrument.quantity.toString(),
              leftPadding: 24,
              rightPadding: 24,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              onChanged: (val) {
                setState(() {
                  val.isEmpty
                      ? widget.instrument.quantity = 0
                      : widget.instrument.quantity = int.parse(val);
                });
              },
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30, bottom: 20),
              child: CustomButton(
                width: 250,
                height: 60,
                text: "Guardar",
                color: "primary",
                br: const BorderRadius.all(Radius.circular(16)),
                onPressed: () {
                  context.read<RouterSimpleCubit>().goBack();
                },
              ),
            ),
            if (widget.instrument.img.isNotEmpty)
              CustomButton(
                width: 250,
                height: 60,
                text: "Eliminar",
                color: "error",
                br: const BorderRadius.all(Radius.circular(16)),
                onPressed: () {
                  context.read<RouterSimpleCubit>().goBack();
                },
              ),
            if (widget.instrument.img.isNotEmpty)
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: ListView.builder(
                    itemCount: 1,
                    itemBuilder: (context, index) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.only(top: 16.0, bottom: 8.0),
                            child: Text(
                              "Usuarios con ${widget.instrument.name}:",
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ),
                          ...widget.users.map((user) => Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: UserTile(user: user),
                              )),
                        ],
                      );
                    },
                  ),
                ),
              ),
          ],
        ),
      )),
    );
  }
}
