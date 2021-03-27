import 'package:example/config.dart';
import 'package:mysql_simple_orm/mysql_simple_orm.dart';
import 'package:faker/faker.dart';

import 'data/models/user.model.dart';
import 'data/repositorys/user.repository.dart';

void main() async {
  MySQL db = MySQL(
    host: Config.host,
    user: Config.user,
    password: Config.password,
    db: Config.db,
    createDbIfNotExists: true,
  );
  await db.init();
  var repository = UserRepository();

  /// wait to create table
  await Future.delayed(Duration(seconds: 2));

  var user = User(
    name: faker.person.name(),
    email: faker.internet.freeEmail(),
    age: faker.randomGenerator.integer(70, min: 10),
    birthDate: faker.date.dateTime(minYear: 1970, maxYear: 2010),
  );
  try {
    var saveUser = await repository.insert(user);
    print('\n ${saveUser.toJson()} \n');
  } on OrmException catch (e) {
    print('\n failed to create user: ${e.message} \n');
  }

  user = await repository.findOne(1);
  user.age = faker.randomGenerator.integer(70, min: 10);

  print('\n user before update ${user.toJson()} \n');
  //user.birthDate = DateTime.now();
  user = await repository.update(user.id, user);
  print('\n user after update ${user.toJson()} \n');

  await db.close();
}

T build<T>(List<T> values, String value) {
  if (values is T) {
    for (var item in values) {
      if (value == enumToString<T>(item)) {
        return item;
      }
    }
  }
  return value as T;
}

String enumToString<T>(T value) {
  return value.toString().split('.').last;
}

enum TypeEnum { VARCHAR, INT }

class ConvertEnum<T> {}
