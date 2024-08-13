import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gestbanda/widgets/new_main_bottom_bar.dart';
import 'package:gestbanda/widgets/user_tile.dart';

import '../../../config/config.dart';
import '../../../models/User.dart';
import '../../../widgets/widgets.dart';

class NewUserList extends StatefulWidget {
  const NewUserList({super.key});

  @override
  State<NewUserList> createState() => _NewUserListState();
}

class _NewUserListState extends State<NewUserList> {
  final List<User> users = [
    User(
      name: "Bob",
      role: "User",
      voz: "Corneta",
    ),
    User(name: "Charlie Pepito Rodriguez", role: "User", voz: "Trompeta"),
    User(name: "Dave", role: "Admin", voz: "Corneta"),
    User(name: "Eve", role: "Guest", voz: "Trompeta"),
    User(name: "Usuario de ejemplo", role: "Admin", voz: "Corneta"),
    User(
        name: "Alice",
        role: "Admin",
        voz: "Trombon",
        img:
            ""),
    User(name: "Bob", role: "User", voz: "Trombon"),
    User(name: "Charlie Pepito Rodriguez", role: "User", voz: "Corneta"),
    User(name: "Dave", role: "Admin", voz: "Trombon"),
    User(name: "Eve", role: "Guest", voz: "Corneta"),
    User(name: "Usuario de ejemplo", role: "Admin", voz: "Corneta"),
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
      bottomNavigationBar: const NewMainBottomBar(currentIndex: 2),
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
              const NewHeader(),
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
