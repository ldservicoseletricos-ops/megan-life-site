import { geminiService } from '../services/gemini/gemini.service.js';
import { localResponseService } from '../services/gemini/local-response.service.js';

export async function sendChatMessage(req, res, next) {
  try {
    const message = String(req.body?.message || '').trim();
    if (!message) return res.status(400).json({ ok: false, error: 'Mensagem vazia.' });

    const ai = await geminiService.generate(message, req.body?.context || {});
    if (ai.ok) return res.json(ai);

    return res.json(localResponseService.answer(message));
  } catch (error) {
    next(error);
  }
}
