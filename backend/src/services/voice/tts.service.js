export const ttsService = {
  async synthesize(payload = {}) {
    const text = String(payload.text || '').trim();
    if (!text) return { ok: false, error: 'Texto vazio.' };
    return {
      ok: true,
      mode: 'android-tts',
      text,
      message: 'Use o TTS nativo do Android para maior estabilidade nesta versão.',
    };
  },
};
