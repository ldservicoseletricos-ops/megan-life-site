export function guardExecution(plan, context = {}) {
  const mediaActive = Boolean(context.mediaActive);
  const voiceCaptureActive = Boolean(context.voiceCaptureActive);

  if (mediaActive && plan.action === 'cloud_ai_chat') {
    return { allowed: true, mode: 'quiet_ai', reason: 'Mídia ativa; evitar captura agressiva.' };
  }

  if (voiceCaptureActive && plan.requiresAndroid) {
    return { allowed: true, mode: 'local_priority', reason: 'Ação local prioritária.' };
  }

  return { allowed: true, mode: 'normal', reason: 'Execução segura.' };
}
