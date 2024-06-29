import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gestbanda/widgets/widgets.dart';

import '../../config/config.dart';

class CreateNewBandPageTwo extends StatelessWidget {
  const CreateNewBandPageTwo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Center(
          child: Column(children: [
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
            "Selecciona el paquete que quieres comprar",
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ).animate().fade(duration: 500.ms).scale(),
        ),
        SvgPicture.asset(
          "assets/svg/create_new_band_page_two.svg",
          height: 250,
          width: 250,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 35, bottom: 35),
          child: Row(
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
                    shape: BoxShape.circle, color: Color(0xffB0E0E6)),
              ),
              Container(
                height: 10,
                width: 10,
                decoration: const BoxDecoration(
                    shape: BoxShape.circle, color: Colors.grey),
              )
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CustomButton(
              text: "Pack Mensual\n\n70€",
              color: "primary",
              br: BorderRadius.circular(10),
              onPressed: () {},
              width: 120,
              height: 200,
            ),
            CustomButton(
              text: "Pack Semestral\n\n410€",
              color: "primary",
              br: BorderRadius.circular(10),
              onPressed: () {},
              width: 120,
              height: 200,
            ),
            CustomButton(
              text: "Pack Anual\n\n820€",
              color: "primary",
              br: BorderRadius.circular(10),
              onPressed: () {},
              width: 120,
              height: 200,
            )
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(top: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                "Al comprar cualquiera de nuestros productos aceptas nuestras",
                style: Theme.of(context).textTheme.bodySmall,
              ),
              TextButton(
                onPressed: () {
                  context.read<RouterSimpleCubit>().pushRoute("/return_policy");
                },
                style: TextButton.styleFrom(
                  foregroundColor: Theme.of(context).colorScheme.primary,
                  textStyle: Theme.of(context).textTheme.bodySmall,
                  overlayColor: Colors.transparent,
                ),
                child: const Text(
                  "políticas de compras y devoluciones",
                ),
              ),
            ],
          ),
        )
      ])),
    );
  }
}
