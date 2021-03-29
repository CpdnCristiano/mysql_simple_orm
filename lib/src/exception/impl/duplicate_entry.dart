import '../interface/orm_exception.dart';

class DuplicateEntry extends OrmException {
  late String _column;
  late String _tableName;
  late String _columnName;

  DuplicateEntry(String message) : super(1062, message) {
    _column =
        RegExp(r"'(.*?)'").allMatches(message).toList().last.group(1) ?? '';
    _columnName = _column.split('.').last;
    _tableName = _column.split('.').first;
  }

  String get column => _column;
  String get tableName => _tableName;
  String get columnName => _columnName;
}
