import '../../mysql/db.dart';

Future<bool> existsTableInDatabase(String name, String database) async {
  database = database.contains('()') ? database : "'$database'";

  var useLog = MySQL.connection.useLog;
  MySQL.connection.useLog = false;

  var exists = (await MySQL.connection.query('''SELECT COUNT(*) count
FROM information_schema.tables 
WHERE table_schema = $database
AND table_name = ?;''', [name])).first.fields['count'] != 0;
  MySQL.connection.useLog = useLog;
  return exists;
}
