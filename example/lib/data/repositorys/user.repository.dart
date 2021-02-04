import 'package:example/data/models/user.model.dart';
import 'package:simple_orm/dart_mysql_orm.dart';

class UserRepository extends Repository<User, int> {
  @override
  User modelDecoder(Map<String, dynamic> json) => User.fromJson(json);

  @override
  Table get table => Table('users_bool1', [
        Column(
          'codigo',
          DataType.INT,
          jsonProperty: 'id',
          autoIncrement: true,
          primaryKey: true,
        ),
        Column('name', DataType.VARCHAR, length: 60),
        Column('email', DataType.VARCHAR, length: 60, unique: true),
        Column('age', DataType.INT),
        Column(
          'is_active',
          DataType.BOOLEAN,
          jsonProperty: 'isActive',
          defaulfValue: true,
          notNull: true,
        ),
      ]);
}
