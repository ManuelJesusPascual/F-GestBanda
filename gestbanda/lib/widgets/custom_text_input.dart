import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextInput extends StatelessWidget {
  const CustomTextInput(
      {super.key,
      required this.label,
      required this.hint,
      this.inputFormatters,
      this.validator,
      this.onChanged,
      this.topPadding = 0.0,
      this.leftPadding = 0.0,
      this.rightPadding = 0.0,
      this.bottomPadding = 0.0,
      this.keyboardType = TextInputType.text,
      this.obscure = false});

  final String label;
  final String hint;
  final double topPadding;
  final double leftPadding;
  final double rightPadding;
  final double bottomPadding;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final TextInputType keyboardType;
  final bool obscure;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(
            top: topPadding,
            left: leftPadding,
            right: rightPadding,
            bottom: bottomPadding),
        child: TextFormField(
          obscureText: obscure,
          keyboardType: TextInputType.text,
          inputFormatters: inputFormatters,
          validator: validator,
          decoration: InputDecoration(
            labelText: label,
            hintText: hint,
          ),
          onChanged: onChanged,
        ));
  }
}


/**
 *     return TextFormField(
      decoration: InputDecoration(
        floatingLabelAlignment: FloatingLabelAlignment.center,
        alignLabelWithHint: true,
        labelText: label,
        hintText: hint,
      ),
    )
 */