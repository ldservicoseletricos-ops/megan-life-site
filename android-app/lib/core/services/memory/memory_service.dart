import 'local_memory_store.dart';

class MemoryService {
  MemoryService({LocalMemoryStore? local}) : _local = local ?? LocalMemoryStore();

  final LocalMemoryStore _local;

  Future<void> save(String text) => _local.save(text);
  Future<List<String>> all() => _local.all();
}
