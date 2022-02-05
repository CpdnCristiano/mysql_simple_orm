import '../interface/data_type.dart';

class DataDouble extends DataType<double> {
  final int length;
  final bool zeroFill;

  DataDouble({this.length = 4, this.zeroFill = false, double? defaulfValue})
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
