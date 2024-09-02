import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../config/config.dart';
import '../../../../domain/models/costume.dart';
import '../../../../domain/models/user.dart';
import '../../../../widgets/widgets.dart';

class CostumeCreateModifyPage extends ConsumerStatefulWidget {
  final Costume costume;
  CostumeCreateModifyPage({super.key, Costume? costume})
      : costume = (costume ??
            Costume(name: "", img: "", quantity: 0, borrowedQuantity: 0));

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
  ConsumerState<CostumeCreateModifyPage> createState() =>
      _CostumeCreateModifyPageState();
}

class _CostumeCreateModifyPageState
    extends ConsumerState<CostumeCreateModifyPage> {
  String _selectedCostume = 'Selecciona una parte del traje';

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
              widget.costume.img.isNotEmpty
                  ? "Modificar parte del traje"
                  : "Añadir parte del traje",
              style: Theme.of(context).textTheme.titleLarge,
            ),
            widget.costume.img.isNotEmpty
                ? Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 20),
                    child: Text(
                      "Modificar ${widget.costume.name}",
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
                          value: _selectedCostume,
                          icon: Icon(
                            Icons.arrow_drop_down,
                            color: Theme.of(context).colorScheme.surface,
                          ),
                          iconSize: 20,
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
                              _selectedCostume = newValue!;
                            });
                          },
                          items: <String>[
                            'Selecciona una parte del traje',
                            'Chaqueta',
                            'Pantalon',
                            'Cinturon',
                            'Camisa',
                            'Camisa de verano',
                            'Corbata',
                            'Hombreras',
                            'Fajin',
                            'Zapatos',
                            'Pines',
                            'Galas',
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
                  initialValue: widget.costume.quantity.toString(),
                  keyboardType: TextInputType.text,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  decoration: InputDecoration(
                    suffixIcon: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextButton(
                            onPressed: () async {
                              final router =
                                  await ref.read(appRouterProvider.future);
                              router.pop();
                            },
                            style: TextButton.styleFrom(
                                padding: const EdgeInsets.all(8),
                                minimumSize: const Size(0, 0),
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                iconColor: const Color(0xFF388E3C)),
                            child: const Icon(
                              Icons.save_as_rounded,
                            )),
                        if (widget.costume.img.isNotEmpty)
                          TextButton(
                              onPressed: () async {
                                final router =
                                    await ref.read(appRouterProvider.future);
                                router.pop();
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
                          ? widget.costume.quantity = 0
                          : widget.costume.quantity = int.parse(val);
                    });
                  },
                )),
            Padding(
              padding: const EdgeInsets.only(top: 30, bottom: 20),
              child: CustomButton(
                width: 250,
                height: 60,
                text: "Guardar",
                color: "primary",
                br: const BorderRadius.all(Radius.circular(16)),
                onPressed: () async {
                  final router = await ref.read(appRouterProvider.future);

                  router.pop();
                },
              ),
            ),
            if (widget.costume.img.isNotEmpty)
              CustomButton(
                width: 250,
                height: 60,
                text: "Eliminar",
                color: "error",
                br: const BorderRadius.all(Radius.circular(16)),
                onPressed: () async {
                  final router = await ref.read(appRouterProvider.future);

                  router.pop();
                },
              ),
            if (widget.costume.img.isNotEmpty)
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
                              "Usuarios con ${widget.costume.name}:",
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
