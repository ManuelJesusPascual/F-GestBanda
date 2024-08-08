import 'package:flutter/material.dart';

class ImagePlaceholder extends StatelessWidget {
  const ImagePlaceholder({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Placeholder(
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          // Aquí calculamos el tamaño del icono basado en el tamaño del padre
          double iconSize = constraints.maxHeight *
              0.5; // Ajusta el porcentaje según tus necesidades

          return Container(
            color: const Color.fromARGB(255, 238, 238, 238),
            child: Center(
              child: Icon(
                Icons.image,
                color: const Color.fromARGB(255, 102, 102, 102),
                size:
                    iconSize, // Tamaño del icono basado en el height del padre
              ),
            ),
          );
        },
      ),
    );
  }
}
