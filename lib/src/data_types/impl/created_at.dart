import 'package:mysql_simple_orm/src/data_types/impl/timestamp.dart';

class DataCreatedAt extends DataTimestamp {
  DataCreatedAt();

  @override
  String get string => 'TIMESTAMP DEFAULT CURRENT_TIMESTAMP';
}
