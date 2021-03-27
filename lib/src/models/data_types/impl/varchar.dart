import 'package:mysql_simple_orm/src/models/data_types/interface/data_type.dart';

class DataVarchar extends DataType<String> {
  int length;

  @override
  String get string => 'VARCHAR($length)';
  DataVarchar({this.length = 45, String defaulfValue}) : super(defaulfValue);
}
