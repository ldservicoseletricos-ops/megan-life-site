import { localMemory } from './local.memory.js';
import { supabaseMemory } from './supabase.memory.js';

export const memoryService = {
  async save(payload = {}) {
    const content = String(payload.content || payload.text || '').trim();
    if (!content) return { ok: false, error: 'Memória vazia.' };

    const item = {
      user_id: payload.userId || 'default',
      memory_type: payload.type || 'note',
      key: payload.key || `memory_${Date.now()}`,
      content,
      metadata: payload.metadata || {},
    };

    const cloud = await supabaseMemory.save(item);
    if (cloud.ok) return cloud;

    return { ok: true, mode: 'local', data: localMemory.save(item), cloudError: cloud.error };
  },

  async search(payload = {}) {
    const query = String(payload.query || '').trim();
    const cloud = await supabaseMemory.search(query);
    if (cloud.ok) return cloud;
    return { ok: true, mode: 'local', data: localMemory.search(query), cloudError: cloud.error };
  },
};
