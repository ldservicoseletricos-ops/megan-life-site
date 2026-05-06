import { Router } from 'express';
import { systemStatus } from '../controllers/system.controller.js';
const router = Router();
router.post('/status', systemStatus);
export default router;
