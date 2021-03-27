import 'package:mysql_simple_orm/src/models/data_types/interface/data_type.dart';

class DataInt extends DataType<int> {
  final int length;
  final bool zeroFill;

  DataInt({this.length = 4, this.zeroFill = false, int defaulfValue})
      : super(defaulfValue);
  @override
  String get string {
    var str = 'INT($length)';
    if (zeroFill) {
      str += ' ZEROFILL';
    }
    return str;
  }
}
