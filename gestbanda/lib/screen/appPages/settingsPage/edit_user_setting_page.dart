import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../config/config.dart';
import '../../../models/user.dart';

class EditUserSettingPage extends ConsumerStatefulWidget {
  final String setting;
  final User user;

  const EditUserSettingPage(
      {super.key, required this.setting, required this.user});

  @override
  ConsumerState<EditUserSettingPage> createState() =>
      _EditUserSettingPageState();
}

class _EditUserSettingPageState extends ConsumerState<EditUserSettingPage> {
  String _getInitialValue() {
    switch (widget.setting) {
      case 'Nombre':
        return widget.user.name;
      case 'Email':
        return widget.user.email;
      case 'Telefono':
        return widget.user.phone;
      case 'Contraseña':
        return '*******';
      default:
        return '';
    }
  }

  void _updateUserSetting(String newValue) {
    setState(() {
      switch (widget.setting) {
        case 'Nombre':
          widget.user.name = newValue;
          break;
        case 'Email':
          widget.user.email = newValue;
          break;
        case 'Telefono':
          widget.user.phone = newValue;
          break;
        case 'Contraseña':
          widget.user.phone = newValue;
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
                            onPressed: () {
                              ref.read(appRouterProvider).pop();
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
