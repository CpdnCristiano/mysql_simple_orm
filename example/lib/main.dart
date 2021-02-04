import 'package:example/config.dart';
import 'package:example/routes/app_pages.dart';
import 'package:get_server/get_server.dart';
import 'package:simple_orm/dart_mysql_orm.dart';

void main() async {
  MySQL db = MySQL(
    host: Config.host,
    user: Config.user,
    password: Config.password,
    db: Config.db,
  );
  await db.init();
  await runApp(GetServer(
    getPages: AppPages.routes,
  ));
}
