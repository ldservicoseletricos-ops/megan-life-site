import { ttsService } from '../services/voice/tts.service.js';

export async function synthesizeVoice(req, res, next) {
  try {
    res.json(await ttsService.synthesize(req.body || {}));
  } catch (error) {
    next(error);
  }
}
