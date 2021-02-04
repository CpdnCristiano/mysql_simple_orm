abstract class OrmException implements Exception {
  int code;
  String message;
  OrmException(this.code, this.message);
  @override
  String toString() => 'Error $code: $message';
}
