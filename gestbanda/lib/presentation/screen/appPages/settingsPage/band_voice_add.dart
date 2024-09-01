import 'package:flutter/material.dart';

import '../../../../widgets/custom_button.dart';

class BandVoiceAddPage extends StatelessWidget {
  const BandVoiceAddPage({super.key});

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
              "Añadir Voz",
              style: Theme.of(context).textTheme.titleLarge,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 20),
              child: Text(
                "Añadir voces a la banda",
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
                    value: "Nueva Voz",
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
                      'Nueva Voz',
                      'Trombon 1º Fuerte',
                      'Trombon 1º Piano',
                      'Trombon 2º Fuerte',
                      'Trombon 2º Piano',
                      'Tuba',
                      'Percusion',
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
              onPressed: () {},
              br: BorderRadius.circular(16),
              text: "Guardar",
            )
          ],
        ),
      )),
    );
  }
}
