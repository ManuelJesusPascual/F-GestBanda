import 'dart:async';
import 'package:flutter/services.dart';
import 'package:properties/properties.dart';

Future<String> loadFromProperties(String key) async {
  final configString = await rootBundle
      .loadString('lib/config/properties/properties.properties');

  final properties = Properties.fromString(configString);

  return properties[key] ?? '';
}
