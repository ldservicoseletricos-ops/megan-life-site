export function optionalAuthMiddleware(req, _res, next) {
  const header = req.headers.authorization || '';
  req.authToken = header.startsWith('Bearer ') ? header.slice(7) : null;
  next();
}
