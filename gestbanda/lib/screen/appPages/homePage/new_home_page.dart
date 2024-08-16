import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:gestbanda/widgets/new_main_bottom_bar.dart';

import '../../../config/config.dart';
import '../../../models/event.dart';
import '../../../utils/enums/event_type_enum.dart';
import '../../../widgets/widgets.dart';

class NewHomePage extends StatelessWidget {
  const NewHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      bottomNavigationBar: const NewMainBottomBar(
        currentIndex: 1,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const NewHeader(),
              const SizedBox(
                height: 15,
              ),
              const CircleAvatar(
                  backgroundImage: AssetImage("assets/logoBanda.png"),
                  backgroundColor: Colors.transparent,
                  radius: 50),
              Text(
                "¡Bienvenido a GestBanda!",
                style: TextStyle(
                    fontSize: 22,
                    color: Theme.of(context).colorScheme.onSurface),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                "Tu aplicación de gestión cofrade",
                style: TextStyle(
                    fontSize: 16, color: Theme.of(context).colorScheme.primary),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    NewEventItem(
                      event: Event(
                          title: "Pasacalles de primavera",
                          type: EventType.pasacalles,
                          initDate: DateTime(2024, 7, 3, 17, 30),
                          endDate: DateTime(2024, 7, 3, 20, 30),
                          imgList: [
                            ""
                          ],
                          description:
                              "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse maximus velit nec dictum mattis. Phasellus sapien neque, vulputate vitae mi eget, volutpat malesuada nisi. Sed aliquet sit amet nulla nec efficitur. Etiam quis pellentesque lacus. Maecenas iaculis nisi ultrices sapien vehicula, nec tempus lacus dictum. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Suspendisse posuere mi a nunc vestibulum consequat. Cras mattis sit amet erat non molestie.Curabitur condimentum condimentum tristique. Nunc tincidunt dictum nunc id aliquam. In efficitur posuere lorem vitae lacinia. Praesent pulvinar odio pretium ex semper, vitae blandit neque ultricies. Phasellus dignissim eros ac aliquam porta. Nam turpis nisi, tempus vel orci sed, tincidunt bibendum eros. Nunc varius turpis vel egestas dignissim. Aliquam consequat at tellus vel euismod. Aenean vestibulum facilisis risus in finibus. Quisque efficitur in tellus quis sollicitudin. Maecenas ultrices porttitor vulputate. Sed ultrices dui sed erat molestie blandit. Morbi ullamcorper elit a nisl rutrum mattis.",
                          location: "Sevilla Centro"),
                    ),
                    NewEventItem(
                      event: Event(
                          title: "Salida extraordinaria",
                          type: EventType.salidaProcesional,
                          initDate: DateTime(2024, 8, 23, 12, 24),
                          endDate: DateTime(2024, 8, 28, 20, 30),
                          imgList: [
                            "",
                            "",
                          ],
                          description:
                              "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse maximus velit nec dictum mattis. Phasellus sapien neque, vulputate vitae mi eget, volutpat malesuada nisi. Sed aliquet sit amet nulla nec efficitur. Etiam quis pellentesque lacus. Maecenas iaculis nisi ultrices sapien vehicula, nec tempus lacus dictum. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Suspendisse posuere mi a nunc vestibulum consequat. Cras mattis sit amet erat non molestie.Curabitur condimentum condimentum tristique. Nunc tincidunt dictum nunc id aliquam. In efficitur posuere lorem vitae lacinia. Praesent pulvinar odio pretium ex semper, vitae blandit neque ultricies. Phasellus dignissim eros ac aliquam porta. Nam turpis nisi, tempus vel orci sed, tincidunt bibendum eros. Nunc varius turpis vel egestas dignissim. Aliquam consequat at tellus vel euismod. Aenean vestibulum facilisis risus in finibus. Quisque efficitur in tellus quis sollicitudin. Maecenas ultrices porttitor vulputate. Sed ultrices dui sed erat molestie blandit. Morbi ullamcorper elit a nisl rutrum mattis.",
                          location: "Sanlucar de Barrameda"),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          context
                              .read<RouterSimpleCubit>()
                              .pushRoute("/instruments_list");
                        },
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.zero,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        child: Container(
                          height: 150,
                          width: 150,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(16)),
                          ),
                          child: ClipRRect(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(16)),
                            child: CachedNetworkImage(
                              imageUrl:
                                  "",
                              cacheManager: CacheManager(
                                Config(
                                  "",
                                  stalePeriod: const Duration(days: 7),
                                ),
                              ),
                              placeholder: (context, url) => const Center(
                                child: CircularProgressIndicator(),
                              ),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                              fit: BoxFit.cover,
                              width: double.infinity,
                              height: double.infinity,
                              alignment: Alignment.center,
                              fadeInDuration: Duration.zero,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      const Text(
                        "Instrumentos",
                      )
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          context
                              .read<RouterSimpleCubit>()
                              .pushRoute("/costume_list");
                        },
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.zero,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        child: Container(
                          height: 150,
                          width: 150,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(16)),
                          ),
                          child: ClipRRect(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(16)),
                            child: CachedNetworkImage(
                              imageUrl:
                                  "",
                              cacheManager: CacheManager(
                                Config(
                                  "",
                                  stalePeriod: const Duration(days: 7),
                                ),
                              ),
                              placeholder: (context, url) => const Center(
                                child: CircularProgressIndicator(),
                              ),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                              fit: BoxFit.cover,
                              width: double.infinity,
                              height: double.infinity,
                              alignment: Alignment.center,
                              fadeInDuration: Duration.zero,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      const Text(
                        "Uniforme",
                      )
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
