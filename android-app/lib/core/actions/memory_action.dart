import '../brain/brain_context.dart';
import '../services/memory/memory_service.dart';
import 'megan_action.dart';

class MemoryAction implements MeganAction {
  MemoryAction(this._memoryService);

  final MemoryService _memoryService;

  @override
  Future<String> execute(String command, {BrainContext context = const BrainContext()}) async {
    await _memoryService.save(command);
    return 'Memória salva.';
  }
}
