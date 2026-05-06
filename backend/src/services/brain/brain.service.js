import { detectIntent } from './intent.detector.js';
import { routeAction } from './action.router.js';
import { guardExecution } from './execution.guard.js';

export const brainService = {
  async decide(payload = {}) {
    const command = String(payload.command || payload.message || '').trim();
    if (!command) return { ok: false, error: 'Comando vazio.' };

    const intent = detectIntent(command);
    const plan = routeAction(intent, { ...payload, command });
    const guard = guardExecution(plan, payload.context || {});

    return {
      ok: true,
      brain: 'cloud',
      intent,
      plan,
      guard,
      response: plan.requiresAndroid
        ? 'Vou executar isso no celular.'
        : 'Vou responder usando o cérebro da Megan.',
    };
  },
};
