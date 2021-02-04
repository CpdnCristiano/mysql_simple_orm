import 'dart:async';
import 'dart:convert';

import '../../../dart_mysql_orm.dart';
import '../../models/table.model.dart';
import '../../mysql/connection.dart';
import '../interface/repository_interface.dart';

part 'functions_repository.dart';

// Example: UserRepository extends Repository<User, int>
// Note: First parameter is the class model, and the second is the type of id
abstract class Repository<T, S> implements RepositoryBase<T, S> {
  MySqlConnection connection = MySQL.connection;
  T modelDecoder(Map<String, dynamic> json);
  Table get table;
  Repository() {
    _createTable(table);
  }

  @override
  Future<List<T>> findAll() async {
    var data = await connection.query('SELECT * FROM ${table.name}');
    var list = <T>[];
    data.forEach((element) {
      list.add(sqlDecode(element.fields));
    });
    return list;
  }

  @override
  Future<T> findOne(S id) async {
    var data = await connection
        .query('SELECT * FROM ${table.name} WHERE ${table.idField} = ?', [id]);
    if (data.isNotEmpty) {
      return sqlDecode(data.first.fields);
    }
    return null;
  }

  @override
  Future<List<T>> findByField(String field, dynamic value) async {
    var data = await connection
        .query('SELECT * FROM ${table.name} WHERE $field = ?', [value]);
    var list = <T>[];
    data.forEach((element) {
      list.add(sqlDecode(element.fields));
    });
    return list;
  }

  @override
  Future<T> insert(T object) async {
    var fields = sqlEncode(object);
    fields.removeWhere((key, value) => value == null);
    String query = 'INSERT INTO `${table.name}`(${fields.keys.join(",")}) '
        'VALUES (${fields.values.join(",")});';
    print(query);
    var data = await connection.query(query);
    return findOne(data.insertId as dynamic);
  }

  @override
  Future<T> update(S id, T object) async {
    Map<String, dynamic> map = sqlEncode(object);
    List<String> query = [];
    map.forEach((key, value) {
      query.add('$key = $value');
    });
    await MySQL.connection.query(
        'UPDATE `${table.name}` SET ${query.join(',')} WHERE ${table.idField} = ?',
        [id]);
    return findOne(map[table.idField]);
  }

  @override
  Future<void> deleteAllWhere(String field, value) async {
    return await connection
        .query('DELETE FROM `${table.name}` WHERE $field = ?', [value]);
  }

  @override
  Future<T> findOneByField(String field, value) async {
    var list = await findByField(field, value);
    if (list.length == 1) {
      return list.first;
    } else if (list.length > 1) {
      throw 'foram encontrado mais de um resultado';
    } else {
      return null;
    }
  }

  @override
  Future<void> deleteOne(S id) {
    return deleteAllWhere(table.idField, id);
  }

  T sqlDecode(Map<String, dynamic> fields) =>
      _sqlDecode<T>(fields, table, modelDecoder);

  Map<String, dynamic> sqlEncode(T object) => _sqlEncode<T>(object, table);
}
