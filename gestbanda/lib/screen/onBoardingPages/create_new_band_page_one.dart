import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gestbanda/blocs/blocs.dart';
import 'package:gestbanda/widgets/widgets.dart';
import 'package:image_picker/image_picker.dart';

import '../../config/config.dart';
import '../../models/BlocFormItem.dart';

class CreateNewBandPageOne extends StatelessWidget {
  const CreateNewBandPageOne({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: BlocListener<RegisterBandFormBloc, RegisterBandFormState>(
        listener: (context, state) => {
          if (state.submitStatus)
            {context.read<RouterSimpleCubit>().pushRoute("/create_band_two")}
        },
        child: BlocBuilder<RegisterBandFormBloc, RegisterBandFormState>(
            builder: (context, state) {
          return Center(
            heightFactor: 1.3,
            child: Form(
              key: state.formKey,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 30.0),
                      child: Text(
                        '¡Crea tu propia banda!',
                        style: Theme.of(context).textTheme.titleLarge,
                        textAlign: TextAlign.center,
                      ).animate().fade(duration: 500.ms).scale(),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 20, right: 20, bottom: 50),
                      child: Text(
                        "Por favor introduce los datos de la banda",
                        style: Theme.of(context).textTheme.bodyMedium,
                        textAlign: TextAlign.center,
                      ).animate().fade(duration: 500.ms).scale(),
                    ),
                    IconButton(
                      //TODO: Añadir texto error la imagen no puede estar vacía
                      style: IconButton.styleFrom(
                        padding: EdgeInsets.zero,
                        fixedSize: const Size(150, 150),
                        backgroundColor: const Color(0xffB0E0E6),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100),
                        ),
                      ),
                      onPressed: () {
                        BlocProvider.of<RegisterBandFormBloc>(context)
                            .add(const RegisterBandFormImgChangedEvent());
                      },
                      icon: state.img != null
                          ? CircleAvatar(
                              radius: 100,
                              backgroundImage: FileImage(state.img!),
                            )
                          : const Icon(
                              Icons.image_outlined,
                              color: Colors.black,
                              weight: 0.2,
                            ),
                      iconSize: 100,
                    ),
                    CustomTextInput(
                      label: state.name.labelText,
                      hint: state.name.hintText,
                      onChanged: (val) {
                        BlocProvider.of<RegisterBandFormBloc>(context).add(
                            RegisterBandFormNameChangedEvent(
                                name: BlocFormItem(
                                    value: val,
                                    labelText: state.name.labelText)));
                      },
                      validator: (val) {
                        return state.name.error;
                      },
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
                            //TODO: Tras que todo este ok y navegues a la siguiente página, cuando vuelves, submitstatus sigue a true y hace cosas raras, ver como solucionar eso
                            BlocProvider.of<RegisterBandFormBloc>(context)
                                .add(const RegisterBandFromSubmitEvent());
                          }),
                    )
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
