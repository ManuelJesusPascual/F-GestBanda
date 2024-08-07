import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
    User("Alice", "Admin", "Corneta"),
    User("Bob", "User", "Corneta"),
    User("Charlie Pepito Rodriguez", "User", "Trompeta"),
    User("Dave", "Admin", "Corneta"),
    User("Eve", "Guest", "Trompeta"),
    User("Usuario de ejemplo", "Admin", "Corneta"),
    User("Alice", "Admin", "Trombon"),
    User("Bob", "User", "Trombon"),
    User("Charlie Pepito Rodriguez", "User", "Corneta"),
    User("Dave", "Admin", "Trombon"),
    User("Eve", "Guest", "Corneta"),
    User("Usuario de ejemplo", "Admin", "Corneta"),
  ];

  @override
  State<InstrumentCreateModifyPage> createState() =>
      _InstrumentCreateModifyPageState();
}

class _InstrumentCreateModifyPageState
    extends State<InstrumentCreateModifyPage> {
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
                    padding: const EdgeInsets.symmetric(
                        horizontal: 50.0, vertical: 20.0),
                    child: DropdownButton(
                      value: widget.instrument.name.isNotEmpty
                          ? widget.instrument.name
                          : "Selecciona un instrumento",
                      isExpanded: true,
                      style: Theme.of(context).textTheme.bodyLarge,
                      items: const [
                        DropdownMenuItem(
                          value: "Selecciona un instrumento",
                          enabled: false,
                          child: Text("Selecciona un instrumento"),
                        ),
                        DropdownMenuItem(
                          value: "Corneta Do/Reb",
                          child: Text("Corneta Do/Reb"),
                        ),
                        DropdownMenuItem(
                          value: "Corneta Do/Sib",
                          child: Text("Corneta Do/Sib"),
                        ),
                        DropdownMenuItem(
                          value: "Trompeta Do",
                          child: Text("Trompeta do"),
                        ),
                        DropdownMenuItem(
                          value: "Trompeta Si",
                          child: Text("Corneta Do/Reb"),
                        ),
                        DropdownMenuItem(
                          value: "Trombon Do",
                          child: Text("Corneta Do/Sib"),
                        ),
                        DropdownMenuItem(
                          value: "Trombon Si",
                          child: Text("Trompeta do"),
                        ),
                        DropdownMenuItem(
                          value: "Tuba Do",
                          child: Text("Tuba Do"),
                        ),
                        DropdownMenuItem(
                          value: "Tuba Si",
                          child: Text("Tuba Si"),
                        ),
                        DropdownMenuItem(
                          value: "Oboe",
                          child: Text("Oboe"),
                        ),
                        DropdownMenuItem(
                          value: "Tambor",
                          child: Text("Tambor"),
                        ),
                        DropdownMenuItem(
                          value: "Caja",
                          child: Text("Caja"),
                        ),
                        DropdownMenuItem(
                          value: "Bombo",
                          child: Text("Bombo"),
                        ),
                      ],
                      onChanged: (val) {
                        setState(() {
                          widget.instrument.name = val!;
                        });
                      },
                    ),
                  ),
            CustomTextInput(
              label: "Cantidad",
              hint: "Cantidad",
              initalValue: widget.instrument.quantity.toString(),
              leftPadding: 50,
              rightPadding: 50,
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
              padding: const EdgeInsets.only(top: 50, bottom: 30),
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
                          CustomListHeader(
                            title: "Usuarios con ${widget.instrument.name}",
                          ),
                          ...widget.users.map((user) => CustomListTile(
                                text: user.name,
                                ca: true,
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
