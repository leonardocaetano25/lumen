# Lumen · flashcards de estudo

Site estático (um `index.html` + `config.js`). Sem build, sem dependências para instalar.
Sem Supabase configurado, o app funciona só no navegador (sem login), com os conjuntos Aprendiz e Companheiro embutidos.

## Níveis de acesso (quando o Supabase está ligado)
| Nível | Pode |
|---|---|
| **Starter** (padrão de quem cria conta) | Estudar os baralhos já cadastrados (do sistema). Não cria nem exclui baralhos. |
| **Prime** | Estudar, criar baralhos, adicionar cartas e excluir **os seus** baralhos. Os baralhos do Prime são privados: só ele os vê e as alterações afetam só a conta dele. |
| **Admin** | Controla tudo: todos os baralhos, baralhos do sistema e o nível de cada usuário (aba **Admin**). |

O progresso de estudo (acertos, erros, dificuldade) é sempre individual, de cada conta.

## 1. Colocar o site no ar (Netlify)
Arraste a pasta `lumen-projeto` (descompactada) em https://app.netlify.com/drop, ou ligue o repositório do GitHub à Netlify (publicação automática a cada alteração).
Guarde o endereço do site, por exemplo `https://lumen.netlify.app`.

## 2. Ligar o banco e o login (Supabase)
1. Crie um projeto em https://supabase.com/dashboard.
2. **SQL Editor > New query**: cole `supabase/schema.sql` e clique **Run**.
3. Nova query: cole `supabase/seed.sql` e **Run** (cria os baralhos Aprendiz e Companheiro como baralhos do sistema). Rode uma vez só.
4. **Authentication > URL Configuration**: em *Site URL*, coloque o endereço do seu site (Netlify). Isso faz o link do e-mail de confirmação abrir o Lumen.
5. Abra o site, toque em **Criar conta** e confirme o e-mail.
6. De volta ao SQL Editor, torne-se administrador (troque o e-mail):
   `update public.profiles set role = 'admin' where email = 'SEU_EMAIL@exemplo.com';`
7. Em **Project Settings > API Keys**, copie a **Project URL** e a chave **publishable** (ou anon). Cole no `config.js`:
   ```js
   window.LUMEN_CONFIG = { SUPABASE_URL: "https://xxxx.supabase.co", SUPABASE_KEY: "sb_publishable_..." };
   ```
   Nunca use a chave `secret` / `service_role` aí.
8. Publique de novo (Netlify Drop ou `git push`). Pronto: o app pede login.

Dica: o login funciona antes do passo 7 só se o `config.js` estiver preenchido; sem ele o app roda em modo local.

## Gerenciar usuários
Como admin, abra a aba **Admin** para mudar o nível de cada pessoa (Starter, Prime, Admin). Quem cria conta entra como Starter.

## Adicionar conteúdo novo
Prime e Admin: aba **Meus conteúdos > ＋ Novo conteúdo**. Uma carta por linha: `Pergunta | Resposta` (também aceita colar de planilha ou carregar um .txt/.csv). Admin pode marcar "Baralho do sistema" para todos verem.

## iPhone
Com o site no ar: Safari > Compartilhar > **Adicionar à Tela de Início**. O ícone do Lumen é usado automaticamente.
