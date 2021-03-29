// ignore: import_of_legacy_library_into_null_safe
import 'package:mysql1/mysql1.dart' as mysql1;

import 'connection.dart';

class MySQL {
  static MySQL? _instance;
  static MySQL get to {
    var instance = _instance;
    if (instance != null) {
      return instance;
    }
    throw Exception('database not started');
  }

  static MySqlConnection get connection {
    var connection = to._connection;
    if (connection != null) {
      return connection;
    }
    throw Exception('database not started');
  }

  final int characterSet;
  final String db;
  final String host;
  final int maxPacketSize;
  final String password;
  final int port;
  final Duration timeout;
  final bool useCompression;
  final bool useSSL;
  final String user;
  final bool createDbIfNotExists;
  final bool useLog;
  final bool autoCreateTable;
  //final String onConnectRun;

  MySqlConnection? _connection;

  MySQL({
    this.host = 'localhost',
    this.port = 3306,
    required this.user,
    required this.password,
    this.db = 'mydb',
    this.useCompression = false,
    this.useSSL = false,
    this.maxPacketSize = 16 * 1024 * 1024,
    this.timeout = const Duration(seconds: 30),
    this.characterSet = mysql1.CharacterSet.UTF8,
    this.createDbIfNotExists = true,
    this.useLog = true,
    this.autoCreateTable = true,
    //this.onConnectRun,
  });

  Future<void> init() async {
    if (_instance == null) {
      mysql1.ConnectionSettings settings = mysql1.ConnectionSettings(
        characterSet: characterSet,
        host: host,
        maxPacketSize: maxPacketSize,
        password: password,
        port: port,
        timeout: timeout,
        useCompression: useCompression,
        useSSL: useSSL,
        user: user,
      );

      _connection = await MySqlConnection.connect(settings, false);
      if (createDbIfNotExists) {
        await _connection?.query('CREATE DATABASE IF NOT EXISTS $db;');
      }
      await _connection?.query('USE $db;');
      _connection?.useLog = useLog;
      _instance = this;
    }
  }

  Future<void> close() async {
    await _connection?.close();
  }
}
