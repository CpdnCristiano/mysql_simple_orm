import 'package:example/data/models/user.model.dart';
import 'package:mysql_simple_orm/mysql_simple_orm.dart';

class UserRepository extends Repository<User> {
  @override
  User modelDecoder(Map<String, dynamic> json) => User.fromJson(json);

  @override
  Table get table => Table(
        'users',
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
            DataTimestamp(),
            jsonProperty: 'birthDate',
            notNull: true,
          ),
          Column(
            'last_update',
            DataLastUpdate(),
            jsonProperty: 'lastUpdate',
            notNull: true,
          ),
        ],
      );
}
