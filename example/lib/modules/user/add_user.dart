import 'dart:async';

import 'package:example/services/user.service.dart';
import 'package:example/widgets/error_widget.dart';
import 'package:get_server/get_server.dart';
import 'package:simple_orm/dart_mysql_orm.dart';

class AddUser extends GetView {
  UserService userService = UserService();

  @override
  FutureOr<Widget> build(Context context) async {
    try {
      Map<String, dynamic> json = await context.payload();
      return Json(await userService.createUser(json));
    } on OrmException catch (e) {
      return ErrorWidget(e.message, 500);
    } on NoSuchMethodError catch (_) {
      //throw ApiException('erro', 400);
      return ErrorWidget('request body is invalid', 400);
    } catch (e) {
      print(e);
      return ErrorWidget('an unexpected error occurred', 500);
    }
  }
}
