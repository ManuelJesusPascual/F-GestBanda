import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:gestbanda/widgets/widgets.dart';

class CreateNewBandPageOne extends StatelessWidget {
  const CreateNewBandPageOne({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Form(
              key: GlobalKey<FormState>(),
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
                    ).animate().fade(duration: 500.ms).scale(),
                    const SizedBox(height: 30),
                    Text(
                      "Por favor introduce los datos de la banda",
                      style: Theme.of(context).textTheme.bodyMedium,
                      textAlign: TextAlign.center,
                    ).animate().fade(duration: 500.ms).scale(),
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
                      onPressed: () {},
                      icon: /* state.img != null
                          ? CircleAvatar(
                              radius: 100,
                              backgroundImage: FileImage(state.img!),
                            )
                          : */
                          Icon(
                        Icons.image_outlined,
                        color: Theme.of(context).colorScheme.surface,
                        weight: 0.2,
                      ),
                      iconSize: 100,
                    ),
                    /*if (state.imgSelected == false)
                      Padding(
                        padding: const EdgeInsets.only(top: 25),
                        child: Text(
                          "Debes introducir una imagen",
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.error,
                          ),
                        ),
                      ),*/
                    const SizedBox(height: 30),
                    CustomTextInput(
                      label: "Nombre de la banda",
                      hint: "Banda Municipal de Villaejemplo",
                      onChanged: (val) {},
                      validator: (val) {
                        return null;
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
                      onPressed: () {},
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
