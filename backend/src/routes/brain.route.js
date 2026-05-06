import { Router } from 'express';
import { decideBrainAction } from '../controllers/brain.controller.js';
const router = Router();
router.post('/', decideBrainAction);
export default router;
