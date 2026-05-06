import { createClient } from '@supabase/supabase-js';
import { env } from '../config/env.js';

export function createSupabaseClient() {
  if (!env.supabaseUrl || !env.supabaseServiceRoleKey) return null;
  return createClient(env.supabaseUrl, env.supabaseServiceRoleKey, {
    auth: { persistSession: false },
  });
}
