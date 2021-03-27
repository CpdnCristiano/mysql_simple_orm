import 'package:mysql1/mysql1.dart';

import '../../mysql_simple_orm.dart';
import 'impl/duplicate_entry.dart';
import 'impl/unknown_column.dart';
import 'impl/unknown_database.dart';

Exception exceptionHandler(MySqlException e) {
  switch (e.errorNumber) {
    case 1062:
      return DuplicateEntry(e.message);
      break;
    case 1054:
      return UnknownColumn(e.message);
      break;
    case 1049:
      return UnknownDatabase(e.message);
      break;
    default:
      return e;
  }
}
