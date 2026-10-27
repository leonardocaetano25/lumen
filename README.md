# Lumen · flashcards de estudo

Site estático (um `index.html` + `config.js`). Sem build, sem dependências para instalar.
Sem Supabase configurado, o app funciona só no navegador (sem login), com os conjuntos Aprendiz e Companheiro embutidos.

## Níveis de acesso (quando o Supabase está ligado)
Ninguém cria conta sozinho: **só o administrador cadastra usuários**, dentro do app (nome, e-mail, senha e nível).

| Nível | Pode |
|---|---|
| **Starter** | Estudar os baralhos já cadastrados (do sistema). Não cria nem exclui baralhos. |
| **Prime** | Estudar, criar baralhos, adicionar cartas e excluir **os seus** baralhos. Os baralhos do Prime são privados: só ele os vê e nada muda na conta de outra pessoa. |
| **Admin** | Controla tudo: todos os baralhos, baralhos do sistema, cadastro de usuários e o nível de cada um (aba **Admin**). |

O progresso de estudo (acertos, erros, dificuldade) é sempre individual, de cada conta.

## 1. Colocar o site no ar (Netlify)
Arraste a pasta `lumen-projeto` (descompactada) em https://app.netlify.com/drop, ou ligue o repositório do GitHub à Netlify (publicação automática a cada alteração).
Guarde o endereço do site, por exemplo `https://lumen.netlify.app`.

## 2. Banco e login (Supabase)
1. Crie um projeto em https://supabase.com/dashboard.
2. **SQL Editor > New query**: cole `supabase/schema.sql` e clique **Run**.
3. Nova query: cole `supabase/seed.sql` e **Run** (cria Aprendiz e Companheiro como baralhos do sistema). Rode uma vez só.
4. **Desligue o cadastro público** (importante: sem isso qualquer pessoa com a chave pública conseguiria criar conta mesmo sem o botão no app). Em **Authentication**, na configuração do provedor **Email** (Sign In / Providers), desative a opção de permitir que novos usuários se cadastrem ("Allow new users to sign up"). O administrador continua criando usuários normalmente, porque isso é feito pela função do passo 6.
5. **Authentication > Users > Add user**: crie o **seu** usuário (e-mail e senha, marcando para confirmar o e-mail automaticamente). Esse será o primeiro administrador.
6. **SQL Editor**, torne-o administrador (troque o e-mail):
   `update public.profiles set role = 'admin', full_name = 'Seu Nome' where email = 'SEU_EMAIL@exemplo.com';`

## 3. Função que cria usuários (Edge Function)
É ela que permite ao admin cadastrar usuários pelo app, sem expor nenhuma chave secreta no navegador.
1. No painel do Supabase: **Edge Functions > Deploy a new function** (opção de criar pelo editor do painel).
2. Nome da função: **`create-user`** (exatamente assim).
3. Apague o código de exemplo, cole o conteúdo de `supabase/functions/create-user/index.ts` e clique em **Deploy**.
4. Não é preciso configurar chaves: o Supabase já entrega `SUPABASE_URL` e as chaves à função.
5. Se, ao criar um usuário pelo app, aparecer erro "Invalid JWT" ou 401, abra as configurações da função e desmarque **Verify JWT**. A própria função já confere quem está chamando e se é administrador.

## 4. Ligar o site ao Supabase
Em **Project Settings > API Keys**, copie a **Project URL** e a chave **publishable** (ou anon). Cole no `config.js`:
```js
window.LUMEN_CONFIG = { SUPABASE_URL: "https://xxxx.supabase.co", SUPABASE_KEY: "sb_publishable_..." };
```
Nunca use a chave `secret` / `service_role` aí. Publique o site de novo (Netlify Drop ou `git push`). Pronto: o app pede login.

## Cadastrar e gerenciar usuários
Entre como admin > aba **Admin**:
- **＋ Novo usuário**: nome, e-mail, senha inicial (mínimo 8 caracteres) e nível. Passe a senha à pessoa por um canal seguro.
- Na lista, mude o nível de qualquer usuário (Starter, Prime, Admin).

## Adicionar conteúdo novo
Prime e Admin: aba **Meus conteúdos > ＋ Novo conteúdo**. Uma carta por linha: `Pergunta | Resposta` (também aceita colar de planilha ou carregar um .txt/.csv). Admin pode marcar "Baralho do sistema" para todos verem.

## iPhone
Com o site no ar: Safari > Compartilhar > **Adicionar à Tela de Início**. O ícone do Lumen é usado automaticamente.
