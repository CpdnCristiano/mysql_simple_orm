abstract class RepositoryBase<T, S> {
  Future<List<T>> findAll();

  Future<T?> findOne(S id);

  Future<List<T>> findByField(String field, dynamic value);

  Future<T?> findOneByField(String field, dynamic value);

  Future<bool> deleteAllWhere(String field, dynamic value);

  Future<bool> deleteOne(S id);

  Future<T?> insert(T object);

  Future<T?> update(S id, T object);
}
