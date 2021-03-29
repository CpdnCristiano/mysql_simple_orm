import 'package:mysql_simple_orm/src/data_types/interface/data_type.dart';

class DataDateTime extends DataType<DateTime> {
  DataDateTime({DateTime? defaulfValue}) : super(defaulfValue);

  @override
  String get string => 'DATETIME';
}
