// ignore: import_of_legacy_library_into_null_safe
import 'package:mysql1/mysql1.dart';

import '../../mysql_simple_orm.dart';
import 'impl/duplicate_entry.dart';
import 'impl/unknown_column.dart';
import 'impl/unknown_database.dart';

Exception exceptionHandler(MySqlException e) {
  switch (e.errorNumber) {
    case 1062:
      return DuplicateEntry(e.message);
    case 1054:
      return UnknownColumn(e.message);
    case 1049:
      return UnknownDatabase(e.message);
    default:
      return e;
  }
}
