import 'package:mysql_simple_orm/src/data_types/impl/timestamp.dart';

class DataLastUpdate extends DataTimestamp {
  DataLastUpdate();
  @override
  String get string =>
      'TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP';
}
