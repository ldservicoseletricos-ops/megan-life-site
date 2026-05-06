export const localResponseService = {
  answer(message = '') {
    return {
      ok: true,
      provider: 'local-fallback',
      text: `Recebi: ${message}. Configure a GEMINI_API_KEY no Render para respostas inteligentes completas.`,
    };
  },
};
