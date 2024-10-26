import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gestbanda/widgets/widgets.dart';

import '../../../config/config.dart';

class JoinBandPage extends ConsumerWidget {
  const JoinBandPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
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
                topPadding: 10.0,
                leftPadding: 40.0,
                rightPadding: 40.0,
                bottomPadding: 10.0,
              ),
              const SizedBox(height: 20),
              CustomButton(
                text: 'Unirse a la banda',
                color: "primary",
                onPressed: () async {
                  ref
                      .read(appRouterProvider.notifier)
                      .changeRouter(directorRouter);
                  final router = await ref.read(appRouterProvider.future);

                  router.push("/");
                },
                width: 350,
                br: BorderRadius.circular(16),
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
