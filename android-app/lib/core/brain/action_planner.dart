class ActionPlanner {
  bool requiresAndroid(String action) {
    return action.startsWith('local_') && action != 'local_time';
  }
}
