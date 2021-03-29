import 'package:example/config.dart';
import 'package:mysql_simple_orm/mysql_simple_orm.dart';
import 'package:faker/faker.dart';

import 'data/models/user.model.dart';
import 'data/repositorys/user.repository.dart';
import 'data/type.enum.dart';

void main() async {
  MySQL db = MySQL(
    host: Config.host,
    user: Config.user,
    password: Config.password,
    db: Config.db,
    createDbIfNotExists: true,
  );
  await db.init();
  var repository = UserRepository(name: 'user_teste_string_enum');

  // wait to create table
  await Future.delayed(Duration(seconds: 2));
  var a = Stopwatch()..start();
  // teste save
  for (var i = 0; i < 10000; i++) {
    var birthDateGenerate = faker.date.dateTime(minYear: 1950, maxYear: 2000);
    var user = User(
      name: faker.person.name(),
      email: faker.internet.freeEmail(),
      age: DateTime.now().year - birthDateGenerate.year,
      birthDate: birthDateGenerate,
    );

    try {
      var saveUser = await repository.insert(user);

      print('\n ${saveUser.toJson()} \n');
    } on OrmException catch (e) {
      print('\n failed to create user: \n${e.message} \n');
    }
  }
  a.stop();
  print('10000 em ${a.elapsed.inSeconds}');

  //test find
  var user = await repository.findOne(1);

  print('\n user before update: \n${user.toJson()} \n');
  if (user.userType == UserType.normal) {
    user.promoteToAdmin();
  }

  user.isActive = !user.isActive;

  // test update
  user = await repository.update(user.id, user);

  print('\n user after update ${user.toJson()} \n');

  await db.close();

  print('10000 em ${a.elapsed.inSeconds}');
}
