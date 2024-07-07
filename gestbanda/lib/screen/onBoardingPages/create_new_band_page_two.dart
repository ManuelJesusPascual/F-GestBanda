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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 40),
              Text(
                '¡Crea tu propia banda!',
                style: Theme.of(context).textTheme.titleLarge,
                textAlign: TextAlign.center,
              ).animate().fade(duration: 500.ms).scale(),
              const SizedBox(height: 30),
              Text(
                "Selecciona el paquete que quieres comprar",
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ).animate().fade(duration: 500.ms).scale(),
              const SizedBox(height: 30),
              SvgPicture.asset(
                "assets/svg/create_new_band_page_two.svg",
                height: 250,
                width: 250,
              ),
              const SizedBox(height: 10),
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
                        shape: BoxShape.circle, color: Color(0xffB0E0E6)),
                  ),
                  Container(
                    height: 10,
                    width: 10,
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle, color: Colors.grey),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CustomButton(
                    text: "Pack\nMensual\n\n70€",
                    color: "primary",
                    br: BorderRadius.circular(10),
                    onPressed: () {
                      context
                          .read<RouterSimpleCubit>()
                          .changeRouter(directorRouter);
                      context.read<RouterSimpleCubit>().pushRoute("/");
                    },
                    width: 110,
                    height: 150,
                  ),
                  CustomButton(
                    text: "Pack\nSemestral\n\n410€",
                    color: "primary",
                    br: BorderRadius.circular(10),
                    onPressed: () {
                      context
                          .read<RouterSimpleCubit>()
                          .changeRouter(directorRouter);
                      context.read<RouterSimpleCubit>().pushRoute("/");
                    },
                    width: 110,
                    height: 150,
                  ),
                  CustomButton(
                    text: "Pack\nAnual\n\n820€",
                    color: "primary",
                    br: BorderRadius.circular(10),
                    onPressed: () {
                      context
                          .read<RouterSimpleCubit>()
                          .changeRouter(directorRouter);
                      context.read<RouterSimpleCubit>().pushRoute("/");
                    },
                    width: 110,
                    height: 150,
                  ),
                ],
              ),
              const SizedBox(height: 30),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "Al comprar cualquiera de nuestros productos aceptas nuestras",
                    style: Theme.of(context).textTheme.bodySmall,
                    textAlign: TextAlign.center,
                  ),
                  TextButton(
                    onPressed: () {
                      context
                          .read<RouterSimpleCubit>()
                          .pushRoute("/return_policy");
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
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
