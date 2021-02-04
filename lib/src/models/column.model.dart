import 'enums/data_type.enum.dart';
import 'enums/relationship.enum.dart';

class Column {
  final String name;
  final DataType dataType;
  final bool autoIncrement;
  final bool primaryKey;
  final bool unique;
  final bool notNull;
  final int length;
  final dynamic defaulfValue;
  final String jsonProperty;

  // String get field => jsonProperty ?? name;

  Column(this.name, this.dataType,
      {this.autoIncrement = false,
      this.primaryKey = false,
      this.notNull = false,
      this.unique = false,
      this.length = 0,
      this.defaulfValue,
      this.jsonProperty}) {
    if (defaulfValue != null) {
      if (defaulfValue.runtimeType != dataType.dartType) {}
    }
  }

  @override
  String toString() {
    String str = '$name ${dataType.value}';
    if (length != 0) {
      str += '($length)';
    } else {
      if (dataType == DataType.VARCHAR) {
        str += '(45)';
      }
    }

    if (notNull) str += ' NOT NULL';
    if (unique) str += ' UNIQUE';
    if (defaulfValue != null) str += ' DEFAULT $defaulfValue';
    if (primaryKey) str += ' PRIMARY KEY';
    if (autoIncrement) str += ' AUTO_INCREMENT';
    return str;
  }
}

class FkColumn extends Column {
  final Relationship relationship;
  final String foreignTable;
  final String foreignColunm;
  FkColumn(String name, DataType dataType, this.foreignTable, this.relationship,
      {autoIncrement = false,
      primaryKey = false,
      notNull = false,
      unique = false,
      length = 0,
      defaulfValue,
      jsonProperty,
      this.foreignColunm})
      : super(name, dataType,
            autoIncrement: autoIncrement,
            defaulfValue: defaulfValue,
            jsonProperty: jsonProperty,
            length: length,
            notNull: notNull,
            primaryKey: primaryKey,
            unique: unique);
}
