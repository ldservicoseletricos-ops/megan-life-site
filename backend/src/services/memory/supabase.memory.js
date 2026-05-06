import { createSupabaseClient } from '../../database/supabase.js';

export const supabaseMemory = {
  async save(item) {
    const supabase = createSupabaseClient();
    if (!supabase) return { ok: false, error: 'Supabase não configurado.' };
    const { data, error } = await supabase.from('megan_memories').insert(item).select().single();
    if (error) return { ok: false, error: error.message };
    return { ok: true, data };
  },
  async search(query) {
    const supabase = createSupabaseClient();
    if (!supabase) return { ok: false, error: 'Supabase não configurado.' };
    const { data, error } = await supabase
      .from('megan_memories')
      .select('*')
      .ilike('content', `%${query}%`)
      .limit(20);
    if (error) return { ok: false, error: error.message };
    return { ok: true, data };
  },
};
