import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gestbanda/widgets/main_bottom_bar.dart';
import 'package:gestbanda/widgets/main_header.dart';

import '../../../config/config.dart';
import '../../../models/User.dart';
import '../../../widgets/widgets.dart';

class UserList extends StatelessWidget {
  UserList({super.key});

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
  Widget build(BuildContext context) {
    final Map<String, List<User>> usersByVoz = {};
    for (var user in users) {
      if (!usersByVoz.containsKey(user.voz)) {
        usersByVoz[user.voz] = [];
      }
      usersByVoz[user.voz]!.add(user);
    }
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      bottomNavigationBar: const MainBottomBar(currentIndex: 2),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.read<RouterSimpleCubit>().pushRoute("/code_list");
        },
        child: const Icon(Icons.qr_code),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const MainHeader(),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 15),
                child: Text(
                  "Listado de componentes:",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: usersByVoz.length,
                  itemBuilder: (context, roleIndex) {
                    String voz = usersByVoz.keys.elementAt(roleIndex);
                    List<User> vozUsers = usersByVoz[voz]!;

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomListHeader(
                          title: voz,
                        ),
                        ...vozUsers.map((user) => CustomListTile(
                              text: user.name,
                              ca: true,
                            )),
                      ],
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
