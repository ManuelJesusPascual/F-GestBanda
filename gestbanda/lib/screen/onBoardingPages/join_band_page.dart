import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:gestbanda/widgets/widgets.dart';

class JoinBandPage extends StatelessWidget {
  const JoinBandPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        body: SafeArea(
            child: Column(children: [
          Padding(
            padding: const EdgeInsets.only(top: 90, bottom: 30.0),
            child: Text(
              'Introduce el código',
              style: Theme.of(context).textTheme.titleLarge,
              textAlign: TextAlign.center,
            ).animate().fade(duration: 500.ms).scale(),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Text(
              "Introduce el código proporcionado por el administrador de tu banda",
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ).animate().fade(duration: 500.ms).scale(),
          ),
          CustomTextInput(
            label: 'Código',
            hint: '_    _    _    _    _    _',
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(6)
            ],
            topPadding: 30.0,
            leftPadding: 40.0,
            rightPadding: 40.0,
            bottomPadding: 50.0,
          ),
          CustomButton(
            text: 'Unirse a la banda',
            color: "primary",
            onPressed: () {},
            width: 350,
            br: BorderRadius.circular(10),
          )
        ])));
  }
}
