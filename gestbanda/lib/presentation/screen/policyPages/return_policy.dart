import 'package:flutter/material.dart';

class ReturnPolicy extends StatelessWidget {
  const ReturnPolicy({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(top: 20, bottom: 30),
          child: Padding(
            padding: const EdgeInsets.only(right: 10.0, left: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Politica de devoluciones",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
                  child: Text(
                    "1. General",
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ),
                const Text(
                  "Nuestra política de devoluciones está diseñada para ofrecer a nuestros usuarios claridad y seguridad respecto a la posibilidad de reembolsos en caso de insatisfacción con nuestros servicios.",
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
                  child: Text(
                    "2. Condiciones para Devoluciones",
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ),
                const Text(
                  "Ofrecemos devoluciones bajo las siguientes condiciones:",
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 15.0, top: 10.0),
                  child: Text(
                    "• Periodo de gracia: Si no está satisfecho con nuestro servicio dentro de los primeros 14 días de su suscripción inicial, puede solicitar un reembolso completo.",
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 15.0, top: 10.0),
                  child: Text(
                      "• Problemas técnicos: Si experimenta problemas técnicos persistentes que no podamos resolver, puede solicitar un reembolso proporcional al tiempo no utilizado de su suscripción."),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
                  child: Text(
                    "3. Proceso de devolución",
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ),
                const Text(
                  "Para solicitar una devolución, siga estos pasos:",
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 15.0, top: 10.0),
                  child: Text(
                      "1.- Contacte a nuestro equipo de soporte a través de support@gestbanda.com explicando el motivo de su solicitud."),
                ),
                const Padding(
                    padding: EdgeInsets.only(left: 15.0, top: 10.0),
                    child: Text(
                        "2.- Proporcione cualquier documentación o evidencia relevante que respalde su solicitud (ej. capturas de pantalla de errores técnicos).")),
                Padding(
                  padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
                  child: Text(
                    "4. Evaluación y Resolución",
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ),
                const Text(
                    "Evaluaremos su solicitud y le notificaremos nuestra decisión en un plazo de 7 días hábiles. Si su solicitud es aprobada, el reembolso se procesará y el dinero será devuelto a su método de pago original en un plazo de 14 días hábiles."),
                Padding(
                  padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
                  child: Text(
                    "5. Excepciones",
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ),
                const Text(
                    "No se concederán reembolsos en los siguientes casos:"),
                const Padding(
                  padding: EdgeInsets.only(left: 15.0, top: 10.0),
                  child: Text(
                      "• Solicitudes hechas después del periodo de gracia de 14 días."),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 15.0, top: 10.0),
                  child: Text(
                      "• Si la cuenta ha sido utilizada en violación de nuestros términos de servicio."),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
                  child: Text(
                    "6. Contacto",
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ),
                const Text(
                    "Para cualquier pregunta sobre nuestra Política de Devoluciones, puede contactarnos a través de: support@gestbanda.com")
              ],
            ),
          ),
        ),
      ),
    );
  }
}
