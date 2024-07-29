// time_modal.dart

import 'package:flutter/material.dart';

Future<TimeOfDay?> showTimeModal(
    BuildContext context, TimeOfDay initialTime, String text) async {
  return await showTimePicker(
      context: context,
      initialTime: initialTime,
      helpText: text,
      cancelText: "Cancelar",
      confirmText: "Aceptar",
      hourLabelText: "Hora",
      minuteLabelText: "Minutos",
      errorInvalidText: "Introduce una hora válida");
}
