import '../interface/orm_exception.dart';

class UnknownColumn extends OrmException {
  late String _column;

  UnknownColumn(String message) : super(1054, message) {
    _column =
        RegExp(r"'(.*?)'").allMatches(message).toList().first.group(1) ?? '';
  }

  String get column => _column;
}
