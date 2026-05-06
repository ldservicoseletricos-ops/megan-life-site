import { memoryService } from '../services/memory/memory.service.js';

export async function saveMemory(req, res, next) {
  try {
    res.json(await memoryService.save(req.body || {}));
  } catch (error) {
    next(error);
  }
}

export async function searchMemory(req, res, next) {
  try {
    res.json(await memoryService.search(req.body || {}));
  } catch (error) {
    next(error);
  }
}
