import 'package:flutter/material.dart';

class ImagePlaceholder extends StatelessWidget {
  const ImagePlaceholder({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Placeholder(
      child: Container(
        color: const Color.fromARGB(255, 238, 238, 238),
        child: const Center(
            child: Icon(
          Icons.image,
          color: Color.fromARGB(255, 102, 102, 102),
          size: 50,
        )),
      ),
    );
  }
}
