import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gestbanda/widgets/widgets.dart';

import '../../config/config.dart';

class CreateNewBandPageOne extends StatelessWidget {
  const CreateNewBandPageOne({super.key});

//TODO: Crear bloc para controlar el textInput (ver que es válido y meterlo en un objeto del tipo CreateBandRequest) y crear la lógica de la imagen, de cuando se setee hacer que el background de ese IconButton sea la imagen que has seleccionado

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 90, bottom: 30.0),
              child: Text(
                '¡Crea tu propia banda!',
                style: Theme.of(context).textTheme.titleLarge,
                textAlign: TextAlign.center,
              ).animate().fade(duration: 500.ms).scale(),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, bottom: 50),
              child: Text(
                "Por favor introduce los datos de la banda",
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ).animate().fade(duration: 500.ms).scale(),
            ),
            IconButton(
              style: IconButton.styleFrom(
                fixedSize: const Size(150, 150),
                backgroundColor: const Color(0xffB0E0E6),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100),
                ),
              ),
              onPressed: () {},
              icon: const Icon(
                Icons.image_outlined,
                color: Colors.black,
                weight: 0.2,
              ),
              iconSize: 90,
            ),
            const CustomTextInput(
              label: "Nombre de la banda",
              hint: "Banda Municipal de Villaejemplo",
              topPadding: 50.0,
              leftPadding: 40.0,
              rightPadding: 40.0,
              bottomPadding: 40,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 10,
                  width: 10,
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle, color: Color(0xffB0E0E6)),
                ),
                Container(
                  height: 10,
                  width: 10,
                  margin: const EdgeInsets.only(left: 15, right: 15),
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle, color: Colors.grey),
                ),
                Container(
                  height: 10,
                  width: 10,
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle, color: Colors.grey),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30),
              child: CustomButton(
                  text: "¡Solo unos pasos más!",
                  color: "primary",
                  icon: Icons.arrow_right_alt_rounded,
                  br: BorderRadius.circular(10),
                  width: 350,
                  onPressed: () {
                    context
                        .read<RouterSimpleCubit>()
                        .pushRoute("/create_band_two");
                  }),
            )
          ],
        ),
      ),
    );
  }
}
