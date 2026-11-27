import 'package:flutter/material.dart';
import '../../../../widgets/widgets.dart';

import '../../../../domain/models/instrument.dart';

class UserCostumeCreatePage extends StatefulWidget {
  const UserCostumeCreatePage({super.key, Instrument? instrument});

  @override
  State<UserCostumeCreatePage> createState() => _UserCostumeCreatePageState();
}

class _UserCostumeCreatePageState extends State<UserCostumeCreatePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const PreviewBanner(),
            Text(
              "Añadir Parte del traje",
              style: Theme.of(context).textTheme.titleLarge,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 20),
              child: Text(
                "Añadir parte del traje al usuario",
                style: Theme.of(context).textTheme.labelLarge,
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
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
                    value: "Selecciona parte del traje",
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
                    onChanged: (String? newValue) {},
                    items: <String>[
                      'Selecciona parte del traje',
                      'Hombreras',
                      'Fajin',
                      'Chaqueta',
                      'Pantalon',
                      'Camisa',
                      'Corbata',
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.surface),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ),
            CustomButton(
              color: "primary",
              onPressed: null, // not implemented yet
              br: BorderRadius.circular(16),
              text: "Añadir",
            )
          ],
        ),
      )),
    );
  }
}
