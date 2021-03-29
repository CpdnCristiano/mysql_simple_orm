import 'dart:async';

import 'package:mysql_simple_orm/src/exception/impl/table_not_exists.dart';
import 'package:mysql_simple_orm/src/models/enums/relationship.enum.dart';
import 'package:mysql_simple_orm/src/utils/functions/get_colunm_primary.dart';

import 'column.model.dart';

class Table {
  String name;
  List<Column> columns;
  String after;
  Table(this.name, this.columns,
      {this.after = 'ENGINE=InnoDB DEFAULT CHARSET=utf8mb4'});

  Future<String> get queryCreateTable async {
    String query = 'CREATE TABLE $name (\n';

    var list = columns.join(',,').split(',,');
    for (var c in columns) {
      if (c is FkColumn) {
        String? id =
            c.foreignColunm ?? await getPrimarykeyFromTable(c.foreignTable);
        if (id != null) {
          if (c.relationship != Relationship.OneToMany) {
            try {
              list.add(
                  'FOREIGN KEY(${c.name}) REFERENCES ${c.foreignTable}($id)');
            } on Exception catch (_) {
              throw TableNotExists(c.foreignTable);
            }
          }
        }
      }
    }
    query += columns.join(', \n');
    query += '\n) $after;';
    return query;
  }

  String get idField {
    var list = columns.where((element) => element.primaryKey);
    if (list.isNotEmpty) {
      return list.first.name;
    }
    return '';
  }
}
