export function routeAction(intent, payload = {}) {
  const command = payload.command || payload.message || '';

  switch (intent.type) {
    case 'open_app':
      return { action: 'local_open_app', requiresAndroid: true, command };
    case 'send_whatsapp':
      return { action: 'local_send_whatsapp', requiresAndroid: true, command };
    case 'read_notifications':
      return { action: 'local_read_notifications', requiresAndroid: true, command };
    case 'navigation':
      return { action: 'local_navigation', requiresAndroid: true, command };
    case 'local_time':
      return { action: 'local_time', requiresAndroid: false, command };
    default:
      return { action: 'cloud_ai_chat', requiresAndroid: false, command };
  }
}
