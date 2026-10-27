# Lumen · flashcards de estudo

Site estático (um único `index.html`). Sem build, sem dependências.

## Colocar online agora (mais rápido, 2 minutos)
1. Acesse https://app.netlify.com/drop (entre com sua conta Netlify).
2. Arraste a **pasta inteira** `lumen-projeto` para a página.
3. A Netlify devolve um link `https://nome-aleatorio.netlify.app`. Pode trocar o nome em *Site configuration > Change site name*.

## Com GitHub (recomendado: cada alteração publica sozinha)
1. Crie um repositório vazio no GitHub, por exemplo `lumen`.
2. Na pasta do projeto, rode:
   ```
   git init && git add . && git commit -m "Lumen: primeira versão"
   git branch -M main
   git remote add origin https://github.com/SEU_USUARIO/lumen.git
   git push -u origin main
   ```
3. Na Netlify: *Add new site > Import an existing project > GitHub* > escolha `lumen`. Deixe o build command vazio e o publish directory como `.` (já está no `netlify.toml`).
4. Daí em diante, todo `git push` publica a nova versão.

## iPhone: ícone e tela cheia
Com o site no ar, abra o link no Safari > Compartilhar > **Adicionar à Tela de Início**. O ícone do Lumen (`apple-touch-icon.png`) é usado automaticamente e o app abre em tela cheia.
Num site próprio o navegador guarda o progresso de forma bem mais confiável do que dentro do Claude.

## Supabase (próxima etapa)
`supabase/schema.sql` tem as tabelas de conjuntos, cartas e progresso, com segurança por usuário. Ele só será usado depois que o app for ligado ao Supabase (login, conteúdos na nuvem e progresso sincronizado).
