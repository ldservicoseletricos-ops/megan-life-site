import 'brain_context.dart';

class ExecutionGuard {
  bool canExecute(String action, BrainContext context) {
    if (context.mediaActive && action == 'cloud_ai_chat') {
      return true;
    }
    return true;
  }
}
