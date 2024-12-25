import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../../config/router/routes_config.dart';
import '../../../../../widgets/widgets.dart';
import '../../../../../domain/models/event.dart';
import '../../../../../utils/enums/event_type_enum.dart';

class EventCreateModify extends ConsumerStatefulWidget {
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
  EventCreateModifyState createState() => EventCreateModifyState();
}

class EventCreateModifyState extends ConsumerState<EventCreateModify> {
  late DateTimeRange dateRange;
  late TimeOfDay initTime;
  late TimeOfDay endTime;
  XFile? _image1;
  XFile? _image2;
  XFile? _image3;
  bool? edit;

  @override
  void initState() {
    super.initState();
    dateRange = DateTimeRange(
      start: widget.event.initDate,
      end: widget.event.endDate,
    );
    initTime = TimeOfDay.fromDateTime(widget.event.initDate);
    endTime = TimeOfDay.fromDateTime(widget.event.endDate);
    edit = widget.event.title.isNotEmpty ? true : false;
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
                  edit! ? "Modificar Evento" : "Crear Evento",
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
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: DropdownButtonHideUnderline(
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 20),
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.secondary,
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      child: DropdownButtonFormField<EventType>(
                        value: widget.event.type,
                        icon: Icon(
                          Icons.arrow_drop_down,
                          color: Theme.of(context).colorScheme.surface,
                        ),
                        iconSize: 24,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Theme.of(context).colorScheme.secondary,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16.0),
                            borderSide: BorderSide.none,
                          ),
                        ),
                        dropdownColor: Theme.of(context).colorScheme.secondary,
                        onChanged: (EventType? newValue) {
                          setState(() {
                            widget.event.type = newValue!;
                          });
                        },
                        items: [
                          DropdownMenuItem(
                            value: EventType.pasacalles,
                            child: Text(
                              "Pasacalles",
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.surface,
                              ),
                            ),
                          ),
                          DropdownMenuItem(
                            value: EventType.concierto,
                            child: Text(
                              "Concierto",
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.surface,
                              ),
                            ),
                          ),
                          DropdownMenuItem(
                            value: EventType.salidaProcesional,
                            child: Text(
                              "Salida Procesional",
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.surface,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                CustomTextInput(
                  label: "Titulo",
                  hint: "Concierto de primavera",
                  initalValue: widget.event.title,
                  leftPadding: 20,
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
                  rightPadding: 20,
                  onChanged: (val) {
                    setState(() {
                      widget.event.location = val;
                    });
                  },
                ),
                CustomTextInput(
                  label: "Descripcion",
                  hint:
                      "Concierto de primavera en la plaza mayor",
                  initalValue: widget.event.description,
                  topPadding: 20,
                  leftPadding: 20,
                  bottomPadding: 20,
                  rightPadding: 20,
                  maxLines: 4,
                  onChanged: (val) {
                    setState(() {
                      widget.event.description = val;
                    });
                  },
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 14, vertical: 10),
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
                              style: TextStyle(
                                  color:
                                      Theme.of(context).colorScheme.onPrimary),
                            ),
                            Text(
                              "${initTime.format(context)} ",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color:
                                      Theme.of(context).colorScheme.onPrimary),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 40,
                          child: VerticalDivider(
                            thickness: 0.5,
                            color: Theme.of(context).colorScheme.onPrimary,
                          ),
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "${dateRange.end.day}/${dateRange.end.month}/${dateRange.end.year}   ",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color:
                                      Theme.of(context).colorScheme.onPrimary),
                            ),
                            Text(
                              "${endTime.format(context)} ",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color:
                                      Theme.of(context).colorScheme.onPrimary),
                            ),
                          ],
                        ),
                        Icon(
                          Icons.calendar_month_outlined,
                          color: Theme.of(context).colorScheme.onPrimary,
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomButton(
                      width: 150,
                      height: 60,
                      text: "Guardar",
                      color: "primary",
                      br: const BorderRadius.all(Radius.circular(16)),
                      onPressed: () async {
                        final router = await ref.read(appRouterProvider.future);

                        router.pop();
                      },
                    ),
                    if (edit!)
                      const SizedBox(
                        width: 20,
                      ),
                    if (edit!)
                      CustomButton(
                        width: 150,
                        height: 60,
                        text: "Eliminar",
                        color: "error",
                        br: const BorderRadius.all(Radius.circular(16)),
                        onPressed: () async {
                          final router =
                              await ref.read(appRouterProvider.future);

                          router.pop();
                        },
                      ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
