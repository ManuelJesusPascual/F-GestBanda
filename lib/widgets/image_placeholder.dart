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
          double iconSize = constraints.maxHeight * 0.5;

          return Container(
            color: const Color.fromARGB(255, 238, 238, 238),
            child: Center(
              child: Icon(
                Icons.image,
                color: const Color.fromARGB(255, 102, 102, 102),
                size: iconSize,
              ),
            ),
          );
        },
      ),
    );
  }
}
