/* import '../blob.model.dart';

enum DataType { VARCHAR, INT, DECIMAL, FLOAT, DATETIME, BLOB, BOOLEAN }

extension DataTypeExt on DataType {
  String get value {
    return toString().split('.').last;
  }

  Type get dartType {
    if (this == DataType.VARCHAR) {
      return String;
    } else if (this == DataType.INT) {
      return String;
    } else if (this == DataType.DECIMAL || this == DataType.FLOAT) {
      return double;
    } else if (this == DataType.BOOLEAN) {
      return bool;
    } else if (this == DataType.DATETIME) {
      return DateTime;
    } else if (this == DataType.BLOB) {
      return Blob;
    } else {
      return Object;
    }
  }
}
 */