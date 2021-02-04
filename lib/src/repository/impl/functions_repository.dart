part of 'repository.dart';

void _createTable(Table table) {
  SqlUtils.existsTableInCurrentDateBase(table.name).then((exists) {
    if (!exists) {
      table.queryCreateTable
          .then((query) => MySQL.connection.query(query).then((value) {}));
    }
  });
}

void _replaceFielsToJson(Map<String, dynamic> fields, Table table) {
  table.columns.forEach((column) {
    if (column.dataType == DataType.BOOLEAN && fields[column.name] is int) {
      fields[column.name] = fields[column.name] == 1;
    }
    if (column.jsonProperty != null) {
      var value = fields[column.name];
      fields.remove(column.name);
      fields[column.jsonProperty] = value;
    }
  });
}

T _sqlDecode<T>(Map<String, dynamic> fields, Table table,
    T Function(Map<String, dynamic>) modelDecoder) {
  _replaceFielsToJson(fields, table);
  return modelDecoder(fields);
}

void _replaceJsonToFields(Map<String, dynamic> json, Table table) {
  table.columns.forEach((column) {
    if (column.jsonProperty != null) {
      var value = json[column.jsonProperty];
      json.remove(column.jsonProperty);
      json[column.name] = value;
    }
  });
}

Map<String, dynamic> _sqlEncode<T>(T object, Table table) {
  Map<String, dynamic> json = jsonDecode(jsonEncode(object));
  _replaceJsonToFields(json, table);
  json.forEach((key, value) {
    if (value is String) {
      json[key] = "'$value'";
    }
  });
  return json;
}

Map<String, dynamic> _toJson(object) {
  return object.toJson();
}
