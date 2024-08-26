import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../config/config.dart';
import '../../../models/costume.dart';
import '../../../models/instrument.dart';
import '../../../models/user.dart';
import '../../../widgets/widgets.dart';

class UserList extends StatefulWidget {
  const UserList({super.key});

  @override
  State<UserList> createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  final List<User> users = [
    User(
        name: "Bob",
        email: "support@gestbanda.com",
        phone: "666666666",
        role: "Componente",
        voz: "Corneta",
        instrumentList: [
          Instrument(
            img: "",
            name: "Corneta Do/Sib",
            quantity: 5,
            borrowedQuantity: 3,
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
        ],
        costumeList: []),
    User(
        name: "Charlie Pepito Rodriguez",
        email: "support@gestbanda.com",
        phone: "666666666",
        role: "Componente",
        voz: "Trompeta",
        instrumentList: [],
        costumeList: [
          Costume(
            img:
                "",
            name: "Fajin",
            quantity: 2,
            borrowedQuantity: 1,
          ),
          Costume(
            img:
                "",
            name: "Cinturon",
            quantity: 2,
            borrowedQuantity: 1,
          ),
          Costume(
            img:
                "",
            name: "Chaqueta",
            quantity: 2,
            borrowedQuantity: 1,
          ),
          Costume(
            img:
                "",
            name: "Pantalon",
            quantity: 2,
            borrowedQuantity: 1,
          ),
          Costume(
            img:
                "",
            name: "Hombreras",
            quantity: 2,
            borrowedQuantity: 1,
          ),
          Costume(
            img:
                "",
            name: "Zapatos",
            quantity: 2,
            borrowedQuantity: 1,
          ),
        ]),
    User(
        name: "Dave",
        email: "support@gestbanda.com",
        phone: "666666666",
        role: "Director General",
        voz: "Corneta",
        instrumentList: [
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
        ],
        costumeList: [
          Costume(
            img:
                "",
            name: "Fajin",
            quantity: 2,
            borrowedQuantity: 1,
          ),
          Costume(
            img:
                "",
            name: "Cinturon",
            quantity: 2,
            borrowedQuantity: 1,
          ),
          Costume(
            img:
                "",
            name: "Chaqueta",
            quantity: 2,
            borrowedQuantity: 1,
          ),
          Costume(
            img:
                "",
            name: "Pantalon",
            quantity: 2,
            borrowedQuantity: 1,
          ),
          Costume(
            img:
                "",
            name: "Hombreras",
            quantity: 2,
            borrowedQuantity: 1,
          ),
          Costume(
            img:
                "",
            name: "Zapatos",
            quantity: 2,
            borrowedQuantity: 1,
          ),
        ]),
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
        img:
            "",
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

  String _selectedInstrument = 'Seleccionar Voz';

  @override
  Widget build(BuildContext context) {
    List<User> filteredUsers = _selectedInstrument == 'Seleccionar Voz'
        ? users
        : users.where((user) => user.voz == _selectedInstrument).toList();

    if (_selectedInstrument == 'Seleccionar Voz') {
      filteredUsers.sort((a, b) => a.voz.compareTo(b.voz));
    }

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      bottomNavigationBar: const MainBottomBar(currentIndex: 2),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).colorScheme.onSurface,
        onPressed: () {
          context.read<RouterSimpleCubit>().pushRoute("/code_list");
        },
        child: Icon(
          Icons.qr_code,
          color: Theme.of(context).colorScheme.surface,
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Header(),
              DropdownButtonHideUnderline(
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
                    dropdownColor: Theme.of(context).colorScheme.secondary,
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedInstrument = newValue!;
                      });
                    },
                    items: <String>[
                      'Seleccionar Voz',
                      'Trompeta',
                      'Corneta',
                      'Trombon'
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.surface,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: filteredUsers.length,
                  itemBuilder: (context, index) {
                    User user = filteredUsers[index];
                    return Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: UserTile(user: user),
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
