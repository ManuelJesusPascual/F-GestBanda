import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gestbanda/presentation/providers/joinBandProvider/join_band_provider.dart';
import 'package:gestbanda/widgets/widgets.dart';

import '../../providers/errorProvider/error_provider.dart';

class JoinBandPage extends ConsumerWidget {
  JoinBandPage({super.key});
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final joinBandProvider = ref.watch(joinBandProviderProvider.notifier);
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
        child: Stack(children: [
          Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 40, bottom: 30.0),
                    child: Text(
                      'Introduce el código',
                      style: Theme.of(context).textTheme.titleLarge,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Text(
                      "Introduce el código proporcionado por el administrador de tu banda",
                      style: Theme.of(context).textTheme.bodyMedium,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 30),
                  CustomTextInput(
                    label: 'Código',
                    hint: '_    _    _    _    _    _',
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(6),
                    ],
                    initalValue: ref.watch(joinBandProviderProvider).code,
                    onChanged: (val) {
                      ref
                          .watch(joinBandProviderProvider.notifier)
                          .changeCode(val);
                    },
                    validator: (val) {
                      return ref
                          .read(joinBandProviderProvider.notifier)
                          .validateCode(val);
                    },
                    topPadding: 10.0,
                    leftPadding: 40.0,
                    rightPadding: 40.0,
                    bottomPadding: 10.0,
                  ),
                  const SizedBox(height: 20),
                  CustomButton(
                    text: 'Unirse a la banda',
                    color: "primary",
                    onPressed: () {
                      ref
                          .read(joinBandProviderProvider.notifier)
                          .joinBandByCode();
                    },
                    width: 350,
                    br: BorderRadius.circular(16),
                  ),
                  const Spacer(),
                ],
              ),
            ),
          ),
          if (joinBandProvider.isLoading)
            Container(
              color: Colors.black54,
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
        ]),
      ),
    );
  }
}
