import 'package:flutter/material.dart';
import 'package:gestbanda/models/Event.dart';
import 'package:gestbanda/utils/enums/EventTypeEnum.dart';
import '../../../widgets/widgets.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 70),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              EventItem(
                event: Event(
                    title: "Pasacalles de primavera",
                    type: EventType.pasacalles,
                    initDate: DateTime(2024, 7, 3, 17, 30),
                    endDate: DateTime(2024, 7, 3, 20, 30),
                    description:
                        "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse maximus velit nec dictum mattis. Phasellus sapien neque, vulputate vitae mi eget, volutpat malesuada nisi. Sed aliquet sit amet nulla nec efficitur. Etiam quis pellentesque lacus. Maecenas iaculis nisi ultrices sapien vehicula, nec tempus lacus dictum. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Suspendisse posuere mi a nunc vestibulum consequat. Cras mattis sit amet erat non molestie.Curabitur condimentum condimentum tristique. Nunc tincidunt dictum nunc id aliquam. In efficitur posuere lorem vitae lacinia. Praesent pulvinar odio pretium ex semper, vitae blandit neque ultricies. Phasellus dignissim eros ac aliquam porta. Nam turpis nisi, tempus vel orci sed, tincidunt bibendum eros. Nunc varius turpis vel egestas dignissim. Aliquam consequat at tellus vel euismod. Aenean vestibulum facilisis risus in finibus. Quisque efficitur in tellus quis sollicitudin. Maecenas ultrices porttitor vulputate. Sed ultrices dui sed erat molestie blandit. Morbi ullamcorper elit a nisl rutrum mattis.",
                    location: "Sevilla Centro"),
              ),
              EventItem(
                event: Event(
                    title: "Salida extraordinaria",
                    type: EventType.salida_procesional,
                    initDate: DateTime(2024, 8, 23, 12, 24),
                    endDate: DateTime(2024, 8, 23, 20, 30),
                    imgList: [
                      "",
                      "",
                      "",
                      ""
                    ],
                    description:
                        "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse maximus velit nec dictum mattis. Phasellus sapien neque, vulputate vitae mi eget, volutpat malesuada nisi. Sed aliquet sit amet nulla nec efficitur. Etiam quis pellentesque lacus. Maecenas iaculis nisi ultrices sapien vehicula, nec tempus lacus dictum. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Suspendisse posuere mi a nunc vestibulum consequat. Cras mattis sit amet erat non molestie.Curabitur condimentum condimentum tristique. Nunc tincidunt dictum nunc id aliquam. In efficitur posuere lorem vitae lacinia. Praesent pulvinar odio pretium ex semper, vitae blandit neque ultricies. Phasellus dignissim eros ac aliquam porta. Nam turpis nisi, tempus vel orci sed, tincidunt bibendum eros. Nunc varius turpis vel egestas dignissim. Aliquam consequat at tellus vel euismod. Aenean vestibulum facilisis risus in finibus. Quisque efficitur in tellus quis sollicitudin. Maecenas ultrices porttitor vulputate. Sed ultrices dui sed erat molestie blandit. Morbi ullamcorper elit a nisl rutrum mattis.",
                    location: "Sanlucar de Barrameda"),
              ),
              EventItem(
                event: Event(
                    title: "Concierto Andex",
                    type: EventType.concierto,
                    initDate: DateTime(2024, 9, 14, 19, 00),
                    endDate: DateTime(2024, 9, 14, 20, 30),
                    description:
                        "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse maximus velit nec dictum mattis. Phasellus sapien neque, vulputate vitae mi eget, volutpat malesuada nisi. Sed aliquet sit amet nulla nec efficitur. Etiam quis pellentesque lacus. Maecenas iaculis nisi ultrices sapien vehicula, nec tempus lacus dictum. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Suspendisse posuere mi a nunc vestibulum consequat. Cras mattis sit amet erat non molestie.Curabitur condimentum condimentum tristique. Nunc tincidunt dictum nunc id aliquam. In efficitur posuere lorem vitae lacinia. Praesent pulvinar odio pretium ex semper, vitae blandit neque ultricies. Phasellus dignissim eros ac aliquam porta. Nam turpis nisi, tempus vel orci sed, tincidunt bibendum eros. Nunc varius turpis vel egestas dignissim. Aliquam consequat at tellus vel euismod. Aenean vestibulum facilisis risus in finibus. Quisque efficitur in tellus quis sollicitudin. Maecenas ultrices porttitor vulputate. Sed ultrices dui sed erat molestie blandit. Morbi ullamcorper elit a nisl rutrum mattis.",
                    location: "Iglesia Capuchinos"),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomButton(
                text: "Instrumentos",
                color: "primary",
                imgSvgAsset: "assets/svg/instruments_page.svg",
                imgHeight: 100,
                imgWidth: 100,
                onPressed: () {
                  // Implementar la navegación a la página de instrumentos
                },
                br: BorderRadius.circular(10),
                width: 150,
                height: 200,
              ),
              CustomButton(
                text: "Ropa",
                color: "primary",
                imgSvgAsset: "assets/svg/clothes_page.svg",
                imgHeight: 100,
                imgWidth: 100,
                onPressed: () {
                  // Implementar la navegación a la página de ropa
                },
                br: BorderRadius.circular(10),
                width: 150,
                height: 200,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
