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
      this.obscure = false,
      this.initalValue,
      this.maxLines = 1,
      this.enabled = true,
      this.prefixText = "",
      this.tooltipText = ""});

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
  final String? initalValue;
  final int? maxLines;
  final bool? enabled;
  final String? prefixText;
  final String? tooltipText;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(
            top: topPadding,
            left: leftPadding,
            right: rightPadding,
            bottom: bottomPadding),
        child: Column(children: [
          TextFormField(
            initialValue: initalValue,
            obscureText: obscure,
            keyboardType: TextInputType.text,
            inputFormatters: inputFormatters,
            validator: validator,
            maxLines: maxLines,
            enabled: enabled,
            decoration: InputDecoration(
                labelText: label, hintText: hint, prefixText: prefixText),
            onChanged: onChanged,
          ),
          if (tooltipText!.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                tooltipText!,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Colors.grey[600], // Color gris para el texto
                    ),
              ),
            ),
        ]));
  }
}
