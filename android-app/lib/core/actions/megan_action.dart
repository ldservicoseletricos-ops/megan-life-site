import '../brain/brain_context.dart';

abstract class MeganAction {
  Future<String> execute(String command, {BrainContext context});
}
