import 'dart:convert';

void ormLog(String message, [List<Object> values = const []]) {
  message = LineSplitter().convert(message).join('\n\t');
  values.forEach((element) {
    message = message.replaceFirst('?', element.toString());
  });
  print('[SIMPLE ORM]: $message');
}
