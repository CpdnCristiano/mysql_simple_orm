# ORM_MYSQL DART
This is an attempt to develop an ORM in dart, I haven't seen any yet ...
** is an alpha version use only in tests do not use in production **
## First steps
- add the dependency in your pubspec.yaml

```yaml
dependencies:
    mysql_simple_orm: 
        git: https://github.com/CpdnCristiano/mysql_simple_orm.git
```
- Create your model class
```dart


class User {
  int id;
  String name;
  int age;
  String email;
  bool isActive;

  User({this.id, this.name, this.age, this.email, this.isActive});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    age = json['age'];
    email = json['email'];
    isActive = json['isActive'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['age'] = age;
    data['email'] = email;
    data['isActive'] = isActive;
    return data;
  }
}
```
- Create your repository:
```dart
// NOTE: the First parameter is your model class
// the second is the type of id in case an int
class UserRepository extends Repository<User, int> {
  /// 
  @override
  User modelDecoder(Map<String, dynamic> json) => User.fromJson(json);
///Declare your table
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
```
in the repository there are the following methods
- findOne(id);
fetch object by id;
- finAll();
return all table objects.
- deleteOne(id);
delete an object
- insert(object)
creates a new object
- update(id, object) 
updates an object
- findByField(String field, dynamic value);
fetch List<Object> by field;


#### start the database connection to the database

in main.dart
```dart
void main() async {
  MySQL db = MySQL(
    host: "localhost",
    user: "admin",
    password: "1234",
    db: "teste",
  );
  await db.init();
```
#### TODO:
- Custom query
- Foreign key support(1:1,N:N,1:N)

observations: In the future, the ORM will have a relationship between the wait

###### Example projects
[User registration API](https://github.com/CpdnCristiano/orm_mysql/tree/master/example)
