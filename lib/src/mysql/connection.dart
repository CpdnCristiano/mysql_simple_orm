import 'dart:async';

import 'package:mysql1/mysql1.dart' as mysql1;

import '../exception/handler.dart';
import '../utils/functions/logs/log.dart';

class MySqlConnection {
  bool useLog;
  final mysql1.MySqlConnection _conn;
  MySqlConnection(this._conn, this.useLog);

  Future close() async {
    try {
      if (useLog) ormLog('close conncection');
      return await _conn.close();
    } on mysql1.MySqlException catch (e) {
      throw exceptionHandler(e);
    } catch (e) {
      rethrow;
    }
  }

  Future<mysql1.Results> query(String sql,
      [List<Object> values = const []]) async {
    try {
      if (useLog) ormLog('execute query "$sql"', values);
      return await _conn.query(sql, values);
    } on mysql1.MySqlException catch (e) {
      throw exceptionHandler(e);
    } catch (e) {
      rethrow;
    }
  }

  Future<List<mysql1.Results>> queryMulti(
      String sql, Iterable<List<Object>> values) async {
    try {
      return await _conn.queryMulti(sql, values);
    } on mysql1.MySqlException catch (e) {
      throw exceptionHandler(e);
    } catch (e) {
      rethrow;
    }
  }

  Future transaction(Function queryBlock) async {
    try {
      return await _conn.transaction(queryBlock);
    } on mysql1.MySqlException catch (e) {
      throw exceptionHandler(e);
    } catch (e) {
      rethrow;
    }
  }

  static FutureOr<MySqlConnection> connect(
      mysql1.ConnectionSettings c, bool log) async {
    var connect = await mysql1.MySqlConnection.connect(c);
    return MySqlConnection(connect, log);
  }

  Future<void> addFila(String to) async {}
}
