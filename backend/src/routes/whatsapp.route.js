import { Router } from 'express';
import { buildWhatsAppResponse } from '../services/whatsapp/whatsapp.service.js';
const router = Router();
router.post('/', (req, res) => res.json(buildWhatsAppResponse(req.body || {})));
export default router;
