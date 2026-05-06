import { GoogleGenAI } from '@google/genai';
import { env } from '../../config/env.js';
import { buildMeganPrompt } from './prompt.builder.js';

export const geminiService = {
  async generate(message, context = {}) {
    if (!env.geminiApiKey) {
      return { ok: false, error: 'GEMINI_API_KEY não configurada.' };
    }

    const ai = new GoogleGenAI({ apiKey: env.geminiApiKey });
    const response = await ai.models.generateContent({
      model: env.geminiModel,
      contents: buildMeganPrompt(message, context),
    });

    return {
      ok: true,
      provider: 'gemini',
      text: response.text || 'Não consegui gerar uma resposta agora.',
    };
  },
};
