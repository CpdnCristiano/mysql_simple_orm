import 'package:mysql_simple_orm/src/models/data_types/impl/timestamp.dart';

class DataLastUpdate extends DataTimestamp {
  DataLastUpdate();
  @override
  String get string =>
      'DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP';
}
