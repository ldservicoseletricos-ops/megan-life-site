import { normalizeText } from '../../utils/text.cleaner.js';

export function detectIntent(command = '') {
  const text = normalizeText(command);

  if (/\b(abrir|abra|abre)\b/.test(text)) return { type: 'open_app', confidence: 0.92 };
  if (/\b(whatsapp|zap|mensagem|mande|enviar)\b/.test(text)) return { type: 'send_whatsapp', confidence: 0.88 };
  if (/\b(leia|ler|notificacoes|mensagens recebidas)\b/.test(text)) return { type: 'read_notifications', confidence: 0.84 };
  if (/\b(waze|maps|rota|navegar|ir para)\b/.test(text)) return { type: 'navigation', confidence: 0.82 };
  if (/\b(horas|hora atual|que horas)\b/.test(text)) return { type: 'local_time', confidence: 0.95 };
  return { type: 'ai_chat', confidence: 0.65 };
}
