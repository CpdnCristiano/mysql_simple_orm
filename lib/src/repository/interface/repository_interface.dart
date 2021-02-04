abstract class RepositoryBase<T, S> {
  Future<List<T>> findAll();

  Future<T> findOne(S id);

  Future<List<T>> findByField(String field, dynamic value);

  Future<T> findOneByField(String field, dynamic value);

  Future<void> deleteAllWhere(String field, dynamic value);

  Future<void> deleteOne(S id);

  Future<T> insert(T object);

  Future<T> update(S id, T object);
}
