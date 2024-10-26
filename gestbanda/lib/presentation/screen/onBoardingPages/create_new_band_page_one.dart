import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gestbanda/config/router/routes_config.dart';
import 'package:gestbanda/presentation/providers/registerBandProvider/register_band_provider.dart';
import 'package:gestbanda/widgets/widgets.dart';

import '../../providers/errorProvider/error_provider.dart';

class CreateNewBandPageOne extends ConsumerWidget {
  CreateNewBandPageOne({super.key});
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final errorMessage = ref.watch(errorProviderProvider);

    if (errorMessage.isNotEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(errorMessage),
            backgroundColor: Theme.of(context).colorScheme.secondary,
          ),
        );
        // Clear the error message after showing the snackbar
        ref.read(errorProviderProvider.notifier).setError("");
      });
    }
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
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
                      "Por favor introduce los datos de la banda",
                      style: Theme.of(context).textTheme.bodyMedium,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 30),
                    IconButton(
                      style: IconButton.styleFrom(
                        padding: EdgeInsets.zero,
                        fixedSize: const Size(150, 150),
                        backgroundColor:
                            Theme.of(context).colorScheme.secondary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100),
                        ),
                      ),
                      onPressed: () {
                        ref
                            .read(registerBandProviderProvider.notifier)
                            .selectImage();
                      },
                      icon:
                          ref.watch(registerBandProviderProvider).img.path != ""
                              ? CircleAvatar(
                                  radius: 100,
                                  backgroundImage: FileImage(File(ref
                                      .read(registerBandProviderProvider)
                                      .img
                                      .path)),
                                )
                              : Icon(
                                  Icons.image_outlined,
                                  color: Theme.of(context).colorScheme.surface,
                                  weight: 0.2,
                                ),
                      iconSize: 100,
                    ),
                    const SizedBox(height: 30),
                    CustomTextInput(
                      label: "Nombre de la banda",
                      hint: "Banda Municipal de Villaejemplo",
                      initalValue: ref.watch(registerBandProviderProvider).name,
                      onChanged: (val) {
                        ref
                            .watch(registerBandProviderProvider.notifier)
                            .changeName(val);
                      },
                      validator: (val) {
                        return ref
                            .read(registerBandProviderProvider.notifier)
                            .validateBandName(val);
                      },
                      topPadding: 10.0,
                      leftPadding: 20.0,
                      rightPadding: 20.0,
                      bottomPadding: 40.0,
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
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                    CustomButton(
                      text: "¡Solo unos pasos más!",
                      color: "primary",
                      icon: Icons.arrow_right_alt_rounded,
                      br: BorderRadius.circular(16),
                      width: 350,
                      onPressed: () async {
                        bool validForm = ref
                            .read(registerBandProviderProvider.notifier)
                            .validateImage();
                        if ((formKey.currentState?.validate() ?? false) &&
                            validForm) {
                          final router =
                              await ref.read(appRouterProvider.future);

                          router.push("/create_band_two");
                        }
                      },
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
