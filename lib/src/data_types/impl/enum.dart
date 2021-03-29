import 'package:mysql_simple_orm/src/data_types/interface/data_type.dart';

abstract class DataEnum<T, S> extends DataType<S> {
  List<T> values;
  DataEnum(this.values, S? defaulfValue) : super(defaulfValue);

  S? toValue(T value);

  T? toEnum(S value);
}
