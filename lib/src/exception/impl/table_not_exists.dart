import 'package:simple_orm/dart_mysql_orm.dart';

class TableNotExists extends OrmException {
  final String _table;

  TableNotExists(this._table) : super(1054, '') {
    message =
        'The table $table used as a reference for a foreign key does not exist';
  }

  String get table => _table;
}
