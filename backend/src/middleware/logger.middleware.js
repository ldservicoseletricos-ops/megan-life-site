export function loggerMiddleware(req, _res, next) {
  req.requestStartedAt = Date.now();
  next();
}
