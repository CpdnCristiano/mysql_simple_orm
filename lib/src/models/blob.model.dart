import 'dart:convert' show utf8;

// ignore: import_of_legacy_library_into_null_safe
import 'package:mysql1/mysql1.dart' as mysql1;

class Blob extends mysql1.Blob {
  Blob.fromBytes(List<int> codeUnits) : super.fromBytes(codeUnits);
  factory Blob.fromString(String string) => Blob.fromBytes(utf8.encode(string));
}
