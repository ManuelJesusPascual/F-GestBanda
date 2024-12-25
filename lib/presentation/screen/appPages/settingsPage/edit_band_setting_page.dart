import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gestbanda/domain/newmodels/bandModels/band_dto.dart';

import '../../../../config/config.dart';

class EditBandSettingPage extends ConsumerStatefulWidget {
  final String setting;
  final BandDTO band;

  const EditBandSettingPage(
      {super.key, required this.setting, required this.band});

  @override
  ConsumerState<EditBandSettingPage> createState() =>
      _EditBandSettingPageState();
}

class _EditBandSettingPageState extends ConsumerState<EditBandSettingPage> {
  String _getInitialValue() {
    switch (widget.setting) {
      case 'Nombre':
        return widget.band.name;

      default:
        return '';
    }
  }

  void _updateUserSetting(String newValue) {
    setState(() {
      switch (widget.setting) {
        case 'Nombre':
          widget.band.name = newValue;
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              "Modificar ${widget.setting}",
              style: Theme.of(context).textTheme.titleLarge,
            ),
            Padding(
                padding: const EdgeInsets.only(
                  top: 25,
                  left: 24,
                  right: 24,
                ),
                child: TextFormField(
                  initialValue: _getInitialValue(),
                  keyboardType: TextInputType.text,
                  obscureText: widget.setting == 'Contraseña' ? true : false,
                  decoration: InputDecoration(
                    suffixIcon: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextButton(
                            onPressed: () async {
                              final router =
                                  await ref.read(appRouterProvider.future);

                              router.pop();
                            },
                            style: TextButton.styleFrom(
                                padding: const EdgeInsets.all(8),
                                minimumSize: const Size(0, 0),
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                iconColor: const Color(0xFF388E3C)),
                            child: const Icon(
                              Icons.save_as_rounded,
                            )),
                      ],
                    ),
                    labelText: widget.setting,
                    hintText: _getInitialValue(),
                  ),
                  onChanged: (val) {
                    setState(() {
                      val.isEmpty
                          ? _updateUserSetting(val)
                          : _updateUserSetting("");
                    });
                  },
                )),
          ],
        ),
      )),
    );
  }
}
