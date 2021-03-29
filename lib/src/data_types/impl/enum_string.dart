import 'package:mysql_simple_orm/src/data_types/impl/enum.dart';
import 'package:mysql_simple_orm/src/utils/enum_convert.dart';

class DataEnumString<T> extends DataEnum<T, String> {
  DataEnumString(List<T> values, {T? defaulfValue})
      : super(values,
            defaulfValue == null ? null : enumToString<T>(defaulfValue));

  @override
  String get string => 'VARCHAR(255)';

  @override
  String? toValue(T value) => enumToString<T>(value);

  @override
  T? toEnum(String value) => stringToEnum<T>(values, value);
}
