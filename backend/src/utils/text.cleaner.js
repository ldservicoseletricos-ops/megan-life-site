export function normalizeText(text = '') {
  return String(text)
    .normalize('NFD')
    .replace(/[\u0300-\u036f]/g, '')
    .toLowerCase()
    .trim();
}

export function cleanHumanText(text = '') {
  return String(text).replace(/\s+/g, ' ').trim();
}
