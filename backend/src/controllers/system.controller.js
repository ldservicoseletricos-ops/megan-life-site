export async function systemStatus(req, res) {
  res.json({
    ok: true,
    android: req.body?.android || null,
    backend: 'online',
    receivedAt: new Date().toISOString(),
  });
}
