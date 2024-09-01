import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gestbanda/widgets/user_tile.dart';

import '../../../../config/config.dart';
import '../../../../domain/models/instrument.dart';
import '../../../../domain/models/user.dart';

class InstrumentCreateModifyPage extends ConsumerStatefulWidget {
  final Instrument instrument;
  InstrumentCreateModifyPage({super.key, Instrument? instrument})
      : instrument = (instrument ??
            Instrument(name: "", img: "", quantity: 0, borrowedQuantity: 0));

  final List<User> users = [
    User(
        name: "Bob",
        email: "support@gestbanda.com",
        phone: "666666666",
        role: "Componente",
        voz: "Corneta",
        instrumentList: [],
        costumeList: []),
    User(
        name: "Charlie Pepito Rodriguez",
        email: "support@gestbanda.com",
        phone: "666666666",
        role: "Componente",
        voz: "Trompeta",
        instrumentList: [],
        costumeList: []),
    User(
        name: "Dave",
        email: "support@gestbanda.com",
        phone: "666666666",
        role: "Director General",
        voz: "Corneta",
        instrumentList: [],
        costumeList: []),
    User(
        name: "Eve",
        email: "support@gestbanda.com",
        phone: "666666666",
        role: "Jefe de Voz",
        voz: "Trompeta",
        instrumentList: [],
        costumeList: []),
    User(
        name: "Usuario de ejemplo",
        email: "support@gestbanda.com",
        phone: "666666666",
        role: "Director General",
        voz: "Corneta",
        instrumentList: [],
        costumeList: []),
    User(
        name: "Alice",
        email: "support@gestbanda.com",
        phone: "666666666",
        role: "Director General",
        voz: "Trombon",
        instrumentList: [],
        costumeList: []),
    User(
        name: "Bob",
        email: "support@gestbanda.com",
        phone: "666666666",
        role: "Componente",
        voz: "Trombon",
        instrumentList: [],
        costumeList: []),
    User(
        name: "Charlie Pepito Rodriguez",
        email: "support@gestbanda.com",
        phone: "666666666",
        role: "Componente",
        voz: "Corneta",
        instrumentList: [],
        costumeList: []),
    User(
        name: "Dave",
        email: "support@gestbanda.com",
        phone: "666666666",
        role: "Director General",
        voz: "Trombon",
        instrumentList: [],
        costumeList: []),
    User(
        name: "Eve",
        email: "support@gestbanda.com",
        phone: "666666666",
        role: "Jefe de Voz",
        voz: "Corneta",
        instrumentList: [],
        costumeList: []),
    User(
        name: "Usuario de ejemplo",
        email: "support@gestbanda.com",
        phone: "666666666",
        role: "Director General",
        voz: "Corneta",
        instrumentList: [],
        costumeList: []),
  ];

  @override
  ConsumerState<InstrumentCreateModifyPage> createState() =>
      _InstrumentCreateModifyPageState();
}

class _InstrumentCreateModifyPageState
    extends ConsumerState<InstrumentCreateModifyPage> {
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
            Padding(
                padding: const EdgeInsets.only(
                  left: 24,
                  right: 24,
                ),
                child: TextFormField(
                  initialValue: widget.instrument.quantity.toString(),
                  keyboardType: TextInputType.text,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  decoration: InputDecoration(
                    suffixIcon: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextButton(
                            onPressed: () {
                              ref.read(appRouterProvider).pop();
                            },
                            style: TextButton.styleFrom(
                                padding: const EdgeInsets.all(8),
                                minimumSize: const Size(0, 0),
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                iconColor: const Color(0xFF388E3C)),
                            child: const Icon(
                              Icons.save_as_rounded,
                            )),
                        if (widget.instrument.img.isNotEmpty)
                          TextButton(
                              onPressed: () {
                                ref.read(appRouterProvider).pop();
                              },
                              style: TextButton.styleFrom(
                                  padding: const EdgeInsets.all(8),
                                  minimumSize: const Size(0, 0),
                                  tapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                  iconColor:
                                      Theme.of(context).colorScheme.error),
                              child: const Icon(
                                Icons.delete_forever,
                              )),
                      ],
                    ),
                    labelText: "Cantidad",
                    hintText: "Cantidad",
                  ),
                  onChanged: (val) {
                    setState(() {
                      val.isEmpty
                          ? widget.instrument.quantity = 0
                          : widget.instrument.quantity = int.parse(val);
                    });
                  },
                )),
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
