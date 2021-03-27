import 'package:mysql_simple_orm/src/models/data_types/interface/data_type.dart';

class DataTimestamp extends DataType<DateTime> {
  DataTimestamp({DateTime defaulfValue}) : super(defaulfValue);

  @override
  String get string => 'TIMESTAMP';
}
