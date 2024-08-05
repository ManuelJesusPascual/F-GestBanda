import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:image_picker/image_picker.dart';

import 'image_placeholder.dart';

class CustomImageContainer extends StatelessWidget {
  const CustomImageContainer(
      {super.key, this.imagePath, this.onImageChanged, this.imagegUri});

  final XFile? imagePath;
  final String? imagegUri;
  final void Function(XFile image)? onImageChanged;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5.0, right: 5.0),
      child: Container(
        height: 150,
        width: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16.0),
          child: Stack(
            children: [
              if (imagePath != null)
                Image.file(
                  File(imagePath!.path),
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                )
              else if (imagegUri != null)
                CachedNetworkImage(
                  imageUrl: imagegUri!,
                  cacheManager: CacheManager(
                    Config(
                      imagegUri!,
                      stalePeriod: const Duration(days: 7),
                    ),
                  ),
                  placeholder: (context, url) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                  alignment: Alignment.center,
                  fadeInDuration: Duration.zero,
                )
              else
                ImagePlaceholder(),
              Align(
                alignment: Alignment.bottomRight,
                child: IconButton(
                  icon: Icon(
                    Icons.add_a_photo,
                    color: Theme.of(context).colorScheme.primary,
                    shadows: const [
                      Shadow(
                          color: Colors.black,
                          blurRadius: 0.2,
                          offset: Offset(1, 1))
                    ],
                  ),
                  onPressed: () async {
                    ImagePicker picker = ImagePicker();
                    final XFile? image = await picker.pickImage(
                      source: ImageSource.gallery,
                      imageQuality: 25,
                    );
                    if (image == null) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          backgroundColor:
                              Theme.of(context).colorScheme.secondary,
                          content: const Text(
                              'No se ha seleccionado ninguna imagen.')));
                    } else {
                      onImageChanged?.call(image);
                    }
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
