export function errorMiddleware(err, _req, res, _next) {
  console.error('[Megan Backend Error]', err);
  res.status(err.statusCode || 500).json({
    ok: false,
    error: err.message || 'Erro interno no backend da Megan Life',
  });
}
