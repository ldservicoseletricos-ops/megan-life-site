import { Router } from 'express';
import { saveMemory, searchMemory } from '../controllers/memory.controller.js';
const router = Router();
router.post('/save', saveMemory);
router.post('/search', searchMemory);
export default router;
