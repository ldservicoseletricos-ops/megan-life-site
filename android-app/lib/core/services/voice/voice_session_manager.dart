import 'dart:async';
import '../../config/megan_constants.dart';

class VoiceSessionManager {
  Timer? _idleTimer;

  void startIdleTimer(void Function() onTimeout) {
    _idleTimer?.cancel();
    _idleTimer = Timer(const Duration(seconds: MeganConstants.idleSessionSeconds), onTimeout);
  }

  void cancel() {
    _idleTimer?.cancel();
  }
}
