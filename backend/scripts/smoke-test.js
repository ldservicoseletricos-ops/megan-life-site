import { brainService } from '../src/services/brain/brain.service.js';

const tests = [
  'abrir youtube',
  'manda mensagem para João no whatsapp dizendo oi',
  'leia minhas notificações',
  'que horas são',
  'explique inteligência artificial',
];

for (const command of tests) {
  const result = await brainService.decide({ command });
  if (!result.ok) throw new Error(`Falhou: ${command}`);
  console.log(command, '=>', result.intent.type, '/', result.plan.action);
}

console.log('Smoke test OK');
