// Lumen · Edge Function "create-user"
// Cria um usuário (nome, e-mail, senha e nível). SÓ administradores conseguem chamar.
// Usa a chave de serviço do Supabase, que fica guardada aqui no servidor e nunca vai ao navegador.
import { createClient } from 'npm:@supabase/supabase-js@2.45.4'

const cors = {
  'Access-Control-Allow-Origin': '*',
  'Access-Control-Allow-Headers': 'authorization, x-client-info, apikey, content-type',
  'Access-Control-Allow-Methods': 'POST, OPTIONS',
}
const json = (body: unknown, status = 200) =>
  new Response(JSON.stringify(body), { status, headers: { ...cors, 'Content-Type': 'application/json' } })

// Aceita as chaves antigas (anon / service_role) e as novas (publishable / secret)
function pickKey(legacyName: string, listName: string): string {
  const legacy = Deno.env.get(legacyName)
  if (legacy) return legacy
  const list = Deno.env.get(listName)
  if (list) { try { return Object.values(JSON.parse(list))[0] as string } catch (_) { /* segue */ } }
  return ''
}

Deno.serve(async (req) => {
  if (req.method === 'OPTIONS') return new Response('ok', { headers: cors })
  if (req.method !== 'POST') return json({ error: 'Método não permitido.' }, 405)
  try {
    const url = Deno.env.get('SUPABASE_URL')!
    const anon = pickKey('SUPABASE_ANON_KEY', 'SUPABASE_PUBLISHABLE_KEYS')
    const service = pickKey('SUPABASE_SERVICE_ROLE_KEY', 'SUPABASE_SECRET_KEYS')
    if (!url || !anon || !service) return json({ error: 'Função sem as chaves do Supabase.' }, 500)

    // 1) quem está chamando? precisa estar logado e ser admin
    const caller = createClient(url, anon, {
      global: { headers: { Authorization: req.headers.get('Authorization') ?? '' } },
    })
    const { data: { user } } = await caller.auth.getUser()
    if (!user) return json({ error: 'Não autenticado.' }, 401)
    const { data: prof } = await caller.from('profiles').select('role').eq('id', user.id).single()
    if (!prof || prof.role !== 'admin') return json({ error: 'Apenas administradores podem criar usuários.' }, 403)

    // 2) valida os dados recebidos
    const body = await req.json()
    const name = String(body.name ?? '').trim()
    const email = String(body.email ?? '').trim().toLowerCase()
    const password = String(body.password ?? '')
    const role = String(body.role ?? 'starter')
    if (name.length < 2 || name.length > 100) return json({ error: 'Informe um nome válido.' }, 400)
    if (!/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email)) return json({ error: 'E-mail inválido.' }, 400)
    if (password.length < 8) return json({ error: 'A senha precisa ter pelo menos 8 caracteres.' }, 400)
    if (!['starter', 'prime', 'admin'].includes(role)) return json({ error: 'Nível inválido.' }, 400)

    // 3) cria o usuário já confirmado e define o nível
    const admin = createClient(url, service, { auth: { autoRefreshToken: false, persistSession: false } })
    const { data, error } = await admin.auth.admin.createUser({
      email, password, email_confirm: true, user_metadata: { full_name: name },
    })
    if (error) return json({ error: error.message }, 400)
    const { error: e2 } = await admin.from('profiles').update({ role, full_name: name }).eq('id', data.user.id)
    if (e2) return json({ error: 'Usuário criado, mas não foi possível definir o nível: ' + e2.message }, 500)
    return json({ ok: true, id: data.user.id })
  } catch (e) {
    return json({ error: String((e as Error)?.message ?? e) }, 500)
  }
})
