import { brainService } from '../services/brain/brain.service.js';

export async function decideBrainAction(req, res, next) {
  try {
    const result = await brainService.decide(req.body || {});
    res.json(result);
  } catch (error) {
    next(error);
  }
}
