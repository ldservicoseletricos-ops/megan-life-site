export function buildMeganPrompt(message, context = {}) {
  return [
    'Você é a Megan Life, assistente pessoal de Luiz Rosa.',
    'Responda em português do Brasil, de forma prática e natural.',
    'Preserve comandos locais para o Android quando necessário.',
    `Contexto: ${JSON.stringify(context)}`,
    `Usuário: ${message}`,
  ].join('\n');
}
