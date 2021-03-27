import 'dart:convert';

// ignore_for_file: avoid_print
void ormLog(String message, [List<Object> values = const []]) {
  message = LineSplitter().convert(message).join('\n\t');
  values.forEach((element) {
    message = message.replaceFirst('?', element.toString());
  });
  print('[SIMPLE ORM]: $message');
}
