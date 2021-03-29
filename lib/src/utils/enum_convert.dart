String? enumToString<T>(T value) {
  if (value != null) {
    return value.toString().split('.').last.toUpperCase();
  } else {
    return null;
  }
}

T? stringToEnum<T>(List<T> values, String value) {
  for (var item in values) {
    if (value.toUpperCase() == enumToString(item)) {
      return item;
    }
  }
  try {
    return value as T;
  } catch (e) {
    return null;
  }
}

int? enumToInt<T>(T value) {
  return _enumToInt(value);
}

T? intToEnum<T>(List<T> values, int i) {
  if (i < values.length) {
    return values[i];
  }

  try {
    return i as T;
  } catch (e) {
    return null;
  }
}

int? _enumToInt(dynamic value) {
  try {
    return value.index;
  } catch (_) {
    return null;
  }
}
