import 'package:mysql_simple_orm/src/models/data_types/interface/data_type.dart';

import 'enums/relationship.enum.dart';

class Column {
  final String name;
  final DataType dataType;
  final bool autoIncrement;
  final bool primaryKey;
  final bool unique;
  final bool notNull;
  final String jsonProperty;
  final bool immutable;

  // String get field => jsonProperty ?? name;

  Column(
    this.name,
    this.dataType, {
    this.autoIncrement = false,
    this.primaryKey = false,
    this.notNull = false,
    this.unique = false,
    this.jsonProperty,
    this.immutable = false,
  });

  @override
  String toString() {
    String str = '$name ${dataType.string}';

    if (notNull) str += ' NOT NULL';
    if (unique) str += ' UNIQUE';
    if (dataType.defaulfValue != null) {
      str += ' DEFAULT ${dataType.defaulfValue}';
    }
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
      jsonProperty,
      this.foreignColunm})
      : super(name, dataType,
            autoIncrement: autoIncrement,
            jsonProperty: jsonProperty,
            notNull: notNull,
            primaryKey: primaryKey,
            unique: unique);
}
