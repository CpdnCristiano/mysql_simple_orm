import 'package:mysql_simple_orm/src/models/data_types/interface/data_type.dart';

class DataBoolean extends DataType<bool> {
  DataBoolean({bool defaulfValue}) : super(defaulfValue);

  @override
  String get string => 'BOOLEAN';
}
