import '../interface/orm_exception.dart';

class UnknownDatabase extends OrmException {
  late String _database;

  UnknownDatabase(String message) : super(1049, message) {
    _database =
        RegExp(r"'(.*?)'").allMatches(message).toList().first.group(1) ?? '';
  }

  String get database => _database;
}
