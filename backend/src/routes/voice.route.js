import { Router } from 'express';
import { synthesizeVoice } from '../controllers/voice.controller.js';
const router = Router();
router.post('/tts', synthesizeVoice);
export default router;
