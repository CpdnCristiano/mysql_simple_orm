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
    _convertValueToDartType(fields, column);
    if (column.jsonProperty != null) {
      var value = fields[column.name];
      fields.remove(column.name);
      fields[column.jsonProperty as String] = value;
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
    _convertValueToMyqlType(json, column);
  });
}

Map<String, dynamic> _sqlEncode<T>(T object, Table table, isUpdate) {
  Map<String, dynamic> json = _toJson(object);

  _replaceJsonToFields(json, table);
  if (isUpdate) {
    _removeImmutable(json, table);
  }
  json.forEach((key, value) {
    if (value is String) {
      value = _preventInjection(value);
      json[key] = "'$value'";
    }
  });
  return json;
}

void _removeImmutable(Map<String, dynamic> json, Table table) {
  table.columns.forEach((column) {
    if (column.immutable ||
        column.dataType is DataLastUpdate ||
        column.dataType is DataCreatedAt) {
      json.removeWhere((key, value) => key == column.name);
    }
  });
}

Map<String, dynamic> _toJson(object) {
  return object.toJson();
}

String _preventInjection(String value) {
  return value.replaceAll("'", "\\'");
}

void _convertValueToMyqlType(Map<String, dynamic> fields, Column column) {
  if (column.dataType is DataEnum) {
    fields[column.name] =
        (column.dataType as DataEnum).toValue(fields[column.name]);
  } else if (column.dataType is DataTimestamp) {
    if (fields[column.name] != null && fields[column.name] is DateTime) {
      fields[column.name] =
          (fields[column.name] as DateTime).toUtc().toString().split('.').first;
    }
  } else if (column.dataType is DataDateTime) {
    if (fields[column.name] != null && fields[column.name] is DateTime) {
      fields[column.name] =
          (fields[column.name] as DateTime).toString().split('.').first;
    }
  }
}

void _convertValueToDartType(Map<String, dynamic> fields, Column column) {
  if (column.dataType is DataBoolean && fields[column.name] is int) {
    fields[column.name] = fields[column.name] == 1;
  } else if (column.dataType is DataEnum) {
    fields[column.name] =
        (column.dataType as DataEnum).toEnum(fields[column.name]);
  } else if (column.dataType is DataTimestamp) {
    if (fields[column.name] != null && fields[column.name] is DateTime) {
      fields[column.name] = (fields[column.name] as DateTime).toLocal();
    }
  } else if (column.dataType is DataDateTime) {
    if (fields[column.name] != null && fields[column.name] is DateTime) {
      var value = fields[column.name] as DateTime;
      fields[column.name] = DateTime(
        value.year,
        value.month,
        value.day,
        value.hour,
        value.minute,
        value.second,
        value.millisecond,
        value.microsecond,
      );
    }
  }
}
