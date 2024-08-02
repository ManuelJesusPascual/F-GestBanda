import 'package:intl/intl.dart';

String getInitials(String name) {
  List<String> words = name.split(' ');
  if (words.length > 2) {
    words = words.sublist(0, 2);
  }
  String initials = '';
  for (var word in words) {
    if (word.isNotEmpty) {
      initials += word[0];
    }
  }
  return initials.toUpperCase();
}

String formatDateTime(DateTime dateTime, String pattern) {
  final DateFormat dateFormat = DateFormat(pattern);
  return dateFormat.format(dateTime);
}
