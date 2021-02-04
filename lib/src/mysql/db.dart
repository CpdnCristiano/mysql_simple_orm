import 'package:mysql1/mysql1.dart' as mysql1;

import 'connection.dart';

class MySQL {
  static MySqlConnection _connection;
  int characterSet;
  String db;
  String host;
  int maxPacketSize;
  String password;
  int port;
  Duration timeout;
  bool useCompression;
  bool useSSL;
  String user;
  bool createDbIfNotExists;
  bool useLog;

  MySQL(
      {this.host = 'localhost',
      this.port = 3306,
      this.user,
      this.password,
      this.db,
      this.useCompression = false,
      this.useSSL = false,
      this.maxPacketSize = 16 * 1024 * 1024,
      this.timeout = const Duration(seconds: 30),
      this.characterSet = mysql1.CharacterSet.UTF8,
      this.createDbIfNotExists = true,
      this.useLog = true});

  Future<void> init() async {
    mysql1.ConnectionSettings settings = mysql1.ConnectionSettings(
        characterSet: characterSet,
        host: host,
        maxPacketSize: maxPacketSize,
        password: password,
        port: port,
        timeout: timeout,
        useCompression: useCompression,
        useSSL: useSSL,
        user: user);
    _connection = await MySqlConnection.connect(settings, false);
    if (createDbIfNotExists) {
      await connection.query('CREATE DATABASE IF NOT EXISTS $db;');
    }
    await connection.query('USE $db;');
    _connection.useLog = useLog;

    return connection;
  }

  Future<void> close() async {
    await _connection.close();
  }

  static MySqlConnection get connection => _connection;
}
