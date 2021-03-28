import 'package:example/data/models/user.model.dart';
import 'package:mysql_simple_orm/mysql_simple_orm.dart';

import '../models/user.model.dart';
import '../type.enum.dart';

class UserRepository extends Repository<User> {
  String name;
  @override
  User modelDecoder(Map<String, dynamic> json) => User.fromJson(json);

  @override
  Table get table => Table(
        name,
        [
          Column(
            'id',
            DataInt(),
            jsonProperty: 'id',
            autoIncrement: true,
            primaryKey: true,
          ),
          Column(
            'name',
            DataVarchar(length: 60),
          ),
          Column(
            'email',
            DataVarchar(length: 60),
            unique: true,
          ),
          Column(
            'age',
            DataInt(defaulfValue: 0),
          ),
          Column(
            'is_active',
            DataBoolean(defaulfValue: true),
            jsonProperty: 'isActive',
            notNull: true,
          ),
          Column(
            'created_at',
            DataCreatedAt(),
            jsonProperty: 'createdAt',
            notNull: true,
            immutable: true,
          ),
          Column(
            'birth_date',
            DataDateTime(),
            jsonProperty: 'birthDate',
            notNull: true,
          ),
          Column(
            'last_update',
            DataLastUpdate(),
            jsonProperty: 'lastUpdate',
            notNull: true,
          ),
          Column(
            'user_type',
            DataEnumString(
              UserType.values,
              defaulfValue: UserType.normal,
            ),
            jsonProperty: 'userType',
            notNull: true,
          ),
        ],
      );

  UserRepository({this.name = 'users'});
}
