import '../../core/services/memory/memory_service.dart';

class MemoryRepository {
  MemoryRepository({MemoryService? service}) : _service = service ?? MemoryService();

  final MemoryService _service;

  Future<void> save(String text) => _service.save(text);
  Future<List<String>> all() => _service.all();
}
