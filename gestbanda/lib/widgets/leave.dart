import 'package:flutter/material.dart';

class Leave extends StatelessWidget {
  final DateTime date;
  final String eventName;

  const Leave({
    super.key,
    required this.date,
    required this.eventName,
  });

  @override
  Widget build(BuildContext context) {
    final String formattedDate = formatDate(date);

    return Container(
      //TODO: Cambiar el container por un boton que te lleve a los detalles de esa salida
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Theme.of(context).colorScheme.primary,
      ),
      height: 130,
      width: 100,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              formattedDate,
              style: TextStyle(
                color: Theme.of(context).colorScheme.onPrimary,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                eventName,
                style: TextStyle(
                    color: Theme.of(context).colorScheme.onPrimary,
                    fontSize: 12),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Método para formatear la fecha
  String formatDate(DateTime date) {
    final List<String> months = [
      'enero',
      'febrero',
      'marzo',
      'abril',
      'mayo',
      'junio',
      'julio',
      'agosto',
      'septiembre',
      'octubre',
      'noviembre',
      'diciembre'
    ];
    return '${date.day} de ${months[date.month - 1]}';
  }
}
