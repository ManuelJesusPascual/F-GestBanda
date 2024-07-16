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
    final String month = getMonth(date);

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Theme.of(context).colorScheme.primary,
      ),
      height: 130,
      width: 100,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Text(
                  date.day.toString(),
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.onPrimary,
                      fontWeight: FontWeight.bold,
                      fontSize: 25),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  month,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onPrimary,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            Expanded(
              // Para ocupar el espacio restante verticalmente
              child: Center(
                child: Text(
                  eventName,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onPrimary,
                    fontSize: 12,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Método para formatear la fecha
  String getMonth(DateTime date) {
    final List<String> months = [
      'Enero',
      'Febrero',
      'Marzo',
      'Abril',
      'Mayo',
      'Junio',
      'Julio',
      'Agosto',
      'Septiembre',
      'Octubre',
      'Noviembre',
      'Diciembre'
    ];
    return months[date.month - 1];
  }
}
