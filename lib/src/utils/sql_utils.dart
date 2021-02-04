import 'functions/exists_table.dart';

class SqlUtils {
  static Future<bool> existsTableInCurrentDateBase(String name) =>
      existsTableInDatabase(name, 'DATABASE()');
  static Future<bool> existsTable(String name, String database) =>
      existsTableInDatabase(name, database);
}
