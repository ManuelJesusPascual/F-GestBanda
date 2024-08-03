// event_create_modify.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../config/router/routes_config.dart';
import '../../../../widgets/widgets.dart';
import '../../../../models/Event.dart';
import '../../../../utils/enums/EventTypeEnum.dart';

class EventCreateModify extends StatefulWidget {
  final Event event;

  EventCreateModify({super.key, Event? event})
      : event = (event ??
                Event(
                  title: "",
                  type: EventType.concierto,
                  initDate: DateTime.now(),
                  endDate: DateTime.now().add(const Duration(hours: 1)),
                  imgList: [],
                  description: "",
                  location: "",
                ))
            .copyWith();

  @override
  _EventCreateModifyState createState() => _EventCreateModifyState();
}

class _EventCreateModifyState extends State<EventCreateModify> {
  late DateTimeRange dateRange;
  late TimeOfDay initTime;
  late TimeOfDay endTime;
  XFile? _image1;
  XFile? _image2;
  XFile? _image3;

  @override
  void initState() {
    super.initState();
    dateRange = DateTimeRange(
      start: widget.event.initDate,
      end: widget.event.endDate,
    );
    initTime = TimeOfDay.fromDateTime(widget.event.initDate);
    endTime = TimeOfDay.fromDateTime(widget.event.endDate);
  }

  Future<void> _selectDateTime(BuildContext context) async {
    final newDateRange = await showDateModal(context,
        initialDateRange: dateRange, isRangeSelection: true);

    if (newDateRange != null) {
      setState(() {
        dateRange = newDateRange;
        widget.event.initDate = DateTime(
          dateRange.start.year,
          dateRange.start.month,
          dateRange.start.day,
          initTime.hour,
          initTime.minute,
        );
        widget.event.endDate = DateTime(
          dateRange.end.year,
          dateRange.end.month,
          dateRange.end.day,
          endTime.hour,
          endTime.minute,
        );
      });
    }
  }

  Future<void> _selectTime(bool isStart) async {
    final picked = await showTimeModal(context, isStart ? initTime : endTime,
        isStart ? "Hora de inicio" : "Hora de fin");
    if (picked != null) {
      setState(() {
        if (isStart) {
          initTime = picked;
          widget.event.initDate = DateTime(
            dateRange.start.year,
            dateRange.start.month,
            dateRange.start.day,
            picked.hour,
            picked.minute,
          );
        } else {
          endTime = picked;
          widget.event.endDate = DateTime(
            dateRange.end.year,
            dateRange.end.month,
            dateRange.end.day,
            picked.hour,
            picked.minute,
          );
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  widget.event.title.isNotEmpty
                      ? "Modificar Evento"
                      : "Crear Evento",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 50),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      CustomImageContainer(
                        imagePath: _image1,
                        imagegUri: (widget.event.imgList != null &&
                                widget.event.imgList!.isNotEmpty)
                            ? widget.event.imgList![0]
                            : null,
                        onImageChanged: (image) {
                          setState(
                            () {
                              _image1 = image;
                            },
                          );
                        },
                      ),
                      CustomImageContainer(
                        imagePath: _image2,
                        imagegUri: (widget.event.imgList != null &&
                                widget.event.imgList!.isNotEmpty &&
                                widget.event.imgList!.length > 1)
                            ? widget.event.imgList![1]
                            : null,
                        onImageChanged: (image) {
                          setState(
                            () {
                              _image2 = image;
                            },
                          );
                        },
                      ),
                      CustomImageContainer(
                        imagePath: _image3,
                        imagegUri: (widget.event.imgList != null &&
                                widget.event.imgList!.isNotEmpty &&
                                widget.event.imgList!.length > 2)
                            ? widget.event.imgList![2]
                            : null,
                        onImageChanged: (image) {
                          setState(
                            () {
                              _image3 = image;
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
                CustomTextInput(
                  label: "Titulo",
                  hint: "Concierto de primavera",
                  initalValue: widget.event.title,
                  topPadding: 20,
                  leftPadding: 20,
                  bottomPadding: 20,
                  rightPadding: 20,
                  onChanged: (val) {
                    setState(() {
                      widget.event.title = val;
                    });
                  },
                ),
                CustomTextInput(
                  label: "Ubicación",
                  hint: "Sevilla Centro",
                  initalValue: widget.event.location,
                  topPadding: 20,
                  leftPadding: 20,
                  bottomPadding: 20,
                  rightPadding: 20,
                  onChanged: (val) {
                    setState(() {
                      widget.event.location = val;
                    });
                  },
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: DropdownButton(
                    value: widget.event.type,
                    isExpanded: true,
                    style: Theme.of(context).textTheme.bodyLarge,
                    items: const [
                      DropdownMenuItem(
                        value: EventType.pasacalles,
                        child: Text("Pasacalles"),
                      ),
                      DropdownMenuItem(
                        value: EventType.concierto,
                        child: Text("Concierto"),
                      ),
                      DropdownMenuItem(
                        value: EventType.salida_procesional,
                        child: Text("Salida Procesional"),
                      ),
                    ],
                    onChanged: (val) {
                      setState(() {
                        widget.event.type = val!;
                      });
                    },
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(16), // Bordes redondeados
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 14, vertical: 10), // Espaciado interno
                    ),
                    onPressed: () async {
                      await _selectDateTime(context);
                      await _selectTime(true);
                      await _selectTime(false);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "${dateRange.start.day}/${dateRange.start.month}/${dateRange.start.year}   ",
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              "${initTime.format(context)} ",
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 40,
                          child: VerticalDivider(
                            thickness: 0.5,
                            color: Colors.grey,
                          ),
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "${dateRange.end.day}/${dateRange.end.month}/${dateRange.end.year}   ",
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              "${endTime.format(context)} ",
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                        const Icon(Icons.calendar_month_outlined)
                      ],
                    ),
                  ),
                ),
                CustomTextInput(
                  label: "Descripcion",
                  hint:
                      "Concierto de primavera en la plaza mayor",
                  initalValue: widget.event.description,
                  topPadding: 20,
                  leftPadding: 20,
                  bottomPadding: 40,
                  rightPadding: 20,
                  maxLines: 4,
                  onChanged: (val) {
                    setState(() {
                      widget.event.description = val;
                    });
                  },
                ),
                CustomButton(
                  width: 250,
                  height: 60,
                  text: "Guardar",
                  color: "primary",
                  br: const BorderRadius.all(Radius.circular(10)),
                  onPressed: () {
                    context.read<RouterSimpleCubit>().goBack();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
