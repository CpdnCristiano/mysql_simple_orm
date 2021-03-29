import 'package:mysql_simple_orm/src/mysql/db.dart';

Future<String?> getPrimarykeyFromTable(String table) async {
  try {
    return (await MySQL.connection
            .query("SHOW keys FROM $table WHERE Key_name = 'PRIMARY'"))
        .first
        .fields['Column_name'];
  } catch (e) {
    return null;
  }
}
