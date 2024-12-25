import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gestbanda/presentation/providers/registerBandProvider/register_band_provider.dart';
import 'package:gestbanda/widgets/widgets.dart';

import '../../../config/config.dart';
import '../../providers/errorProvider/error_provider.dart';

class CreateNewBandPageTwo extends ConsumerWidget {
  const CreateNewBandPageTwo({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final registerBandProvider =
        ref.watch(registerBandProviderProvider.notifier);

    final errorMessage = ref.watch(errorProviderProvider);
    if (errorMessage.isNotEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              errorMessage,
              locale: const Locale('es', 'ES'),
            ),
            backgroundColor: Theme.of(context).colorScheme.secondary,
          ),
        );
        // Clear the error message after showing the snackbar
        ref.read(errorProviderProvider.notifier).setError("");
      });
    }

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Stack(children: [
        Padding(
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
                ),
                const SizedBox(height: 30),
                Text(
                  "Selecciona el paquete que quieres comprar",
                  style: Theme.of(context).textTheme.bodyMedium,
                  textAlign: TextAlign.center,
                ),
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
                      br: BorderRadius.circular(16),
                      onPressed: () async {
                        ref
                            .read(registerBandProviderProvider.notifier)
                            .registerBand();
                      },
                      width: 110,
                      height: 150,
                    ),
                    CustomButton(
                      text: "Pack\nSemestral\n\n410€",
                      color: "primary",
                      br: BorderRadius.circular(16),
                      onPressed: () async {
                        ref
                            .read(registerBandProviderProvider.notifier)
                            .registerBand();
                      },
                      width: 110,
                      height: 150,
                    ),
                    CustomButton(
                      text: "Pack\nAnual\n\n820€",
                      color: "primary",
                      br: BorderRadius.circular(16),
                      onPressed: () async {
                        ref
                            .read(registerBandProviderProvider.notifier)
                            .registerBand();
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
                      onPressed: () async {
                        final router = await ref.read(appRouterProvider.future);

                        router.push("/return_policy");
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
        if (registerBandProvider.isLoading)
          Container(
            color: Colors.black54,
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          ),
      ]),
    );
  }
}
