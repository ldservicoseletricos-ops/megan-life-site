export function buildWhatsAppResponse(payload = {}) {
  return {
    ok: true,
    action: 'local_send_whatsapp',
    contact: payload.contact || null,
    message: payload.message || '',
    note: 'O envio real deve ser feito no Android via intent + accessibility quando necessário.',
  };
}
