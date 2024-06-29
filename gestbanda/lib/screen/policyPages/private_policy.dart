import 'package:flutter/material.dart';

class PrivatePolicy extends StatelessWidget {
  const PrivatePolicy({super.key});

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
                    "Politica de privacidad",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
                  child: Text(
                    "1. Información General",
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ),
                const Text(
                    "Esta Política de Privacidad describe cómo GestBanda recopila, utiliza y protege la información personal que usted proporciona al usar nuestra aplicación."),
                Padding(
                  padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
                  child: Text(
                    "2. Información Recopilada",
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ),
                const Text("Recopilamos la siguiente información personal:"),
                const Padding(
                  padding: EdgeInsets.only(left: 15.0, top: 10.0),
                  child: Text(
                      "• Datos de registro: nombre, dirección de correo electrónico, número de teléfono."),
                ),
                const Padding(
                    padding: EdgeInsets.only(left: 15.0, top: 10.0),
                    child: Text(
                        "• Información de pago: detalles de la tarjeta de crédito/débito u otros métodos de pago.")),
                const Padding(
                    padding: EdgeInsets.only(left: 15.0, top: 10.0),
                    child: Text(
                        "• Datos de uso: información sobre cómo usa nuestra aplicación, como características utilizadas, tiempo de uso, etc.")),
                const Padding(
                    padding: EdgeInsets.only(left: 15.0, top: 10.0),
                    child: Text(
                        "• Información de comunicación: cualquier correspondencia que tengamos con usted.")),
                Padding(
                  padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
                  child: Text(
                    "3. Uso de la información",
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ),
                const Text(
                  "Utilizamos la información recopilada para:",
                ),
                const Padding(
                    padding: EdgeInsets.only(left: 15.0, top: 10.0),
                    child: Text("• Proveer y mejorar nuestros servicios.")),
                const Padding(
                    padding: EdgeInsets.only(left: 15.0, top: 10.0),
                    child: Text(
                        "• Procesar sus pagos y gestionar su suscripción.")),
                const Padding(
                    padding: EdgeInsets.only(left: 15.0, top: 10.0),
                    child: Text(
                        "• Comunicarnos con usted sobre su cuenta, actualizaciones y soporte.")),
                const Padding(
                    padding: EdgeInsets.only(left: 15.0, top: 10.0),
                    child: Text(
                        "• Cumplir con las leyes aplicables y resolver disputas.")),
                Padding(
                  padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
                  child: Text(
                    "4. Compartir Información",
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ),
                const Text(
                    "No compartimos su información personal con terceros, excepto:"),
                const Padding(
                    padding: EdgeInsets.only(left: 15.0, top: 10.0),
                    child: Text(
                        "• Para cumplir con la ley, reglamentos o procesos legales.")),
                const Padding(
                    padding: EdgeInsets.only(left: 15.0, top: 10.0),
                    child: Text(
                        "• Para proteger los derechos, propiedad y seguridad de nuestra empresa, usuarios u otros.")),
                const Padding(
                    padding: EdgeInsets.only(left: 15.0, top: 10.0),
                    child: Text(
                        "• Con proveedores de servicios externos que nos ayudan a operar nuestra aplicación y procesar pagos.")),
                Padding(
                  padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
                  child: Text(
                    "5. Seguridad de la información",
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ),
                const Text(
                    "Adoptamos medidas razonables para proteger la información personal contra pérdida, robo, uso indebido y acceso no autorizado, divulgación, alteración y destrucción."),
                Padding(
                  padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
                  child: Text(
                    "6. Derechos del usuario.",
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ),
                const Text("Usted tiene derecho a: "),
                const Padding(
                  padding: EdgeInsets.only(left: 15.0, top: 10.0),
                  child: Text(
                      "• Acceder, rectificar o borrar su información personal."),
                ),
                const Padding(
                    padding: EdgeInsets.only(left: 15.0, top: 10.0),
                    child: Text(
                        "• Oponerse al procesamiento de su información personal.")),
                const Padding(
                    padding: EdgeInsets.only(left: 15.0, top: 10.0),
                    child: Text(
                        "• Solicitar la limitación del procesamiento de su información personal.")),
                const Padding(
                    padding: EdgeInsets.only(left: 15.0, top: 10.0),
                    child: Text("• Portar su información personal.")),
                Padding(
                  padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
                  child: Text(
                    "7. Cambios en la Política de Privacidad",
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ),
                const Text(
                    "Nos reservamos el derecho de modificar esta Política de Privacidad en cualquier momento. Cualquier cambio será notificado a través de nuestra aplicación y/o por correo electrónico."),
                Padding(
                  padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
                  child: Text(
                    "8. Contacto",
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ),
                const Text(
                    "Para cualquier pregunta sobre esta Política de Privacidad, puede contactarnos a través de: support@gestbanda.com")
              ],
            ),
          ),
        ),
      ),
    );
  }
}
