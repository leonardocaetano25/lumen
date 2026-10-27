-- Lumen · baralhos do sistema (Aprendiz e Companheiro)
-- Rode DEPOIS do schema.sql, uma única vez (rodar de novo duplica os baralhos).
-- No SQL Editor do Supabase (ele ignora as regras de segurança, por isso consegue inserir baralhos do sistema).
do $$
declare d uuid;
begin
  insert into public.decks(owner,name,description,is_shared) values (null,'Aprendiz','Conjunto do grau de Aprendiz',true) returning id into d;
  insert into public.cards(deck_id,position,question,answer) values
    (d,0,$lumen$Sois Maçom?$lumen$,$lumen$MCTMR (Meus Irmãos Como Tal Me Reconhecem).$lumen$),
    (d,1,$lumen$A que é consagrado o grau de Aprendiz?$lumen$,$lumen$A fraternidade humana, exemplificada na união dos irmãos.$lumen$),
    (d,2,$lumen$Como conseguistes entrar no Templo?$lumen$,$lumen$Por duas pancadas fortes na porta do templo.$lumen$),
    (d,3,$lumen$Como fostes recebido Maçom?$lumen$,$lumen$Nem nu, nem vestido. Vendaram-me os olhos, tiraram-me todos os metais que representavam o egoísmo do mundo profano, e fui conduzido à porta do Templo por um amigo, que depois conheci como irmão.$lumen$),
    (d,4,$lumen$Que fizeram para vos instruir?$lumen$,$lumen$O Venerável mestre tomou-me pela mão direita, deu-me o toque, a palavra, e toda a instrução do Grau. Fiz em seguida a primeira lição na Pedra Bruta.$lumen$),
    (d,5,$lumen$Como terminou cada uma das viagens?$lumen$,$lumen$A 1ª Viagem ao pedestal do 2º. Vigilante, representada pelo elemento Ar, símbolo da vitalidade, emblema natural e própria da vida humana.
A 2ª Viagem ao pedestal do 1º. Vigilante, representada pelo elemento Água, onde tive às mãos purificadas nas águas do Mar de Bronze;
A 3ª Viagem: Ao Altar onde tem assento o Venerável mestre, representada pelo elemento Fogo, onde também tive às mãos purificadas nas Chamas da Purificação.$lumen$),
    (d,6,$lumen$Onde se achavam situadas as portas?$lumen$,$lumen$No Ocidente, entre as colunas J e B.$lumen$),
    (d,7,$lumen$Que vos disseram quando batestes?$lumen$,$lumen$Quem vem lá? E ouvi alguém responder: Um candidato que quer ser iniciado na ordem maçônica e admitido nos seus augustos mistérios.$lumen$),
    (d,8,$lumen$Que significam as purificações?$lumen$,$lumen$Que o profano não consegue alcançar por si só, o templo da filosofia.$lumen$),
    (d,9,$lumen$Que vos deram depois?$lumen$,$lumen$Deram-me um líquido a beber, e inexplicavelmente o doce ser fez amargo, à minha revelia, pois o meu pensamento não sofrera mudança.$lumen$),
    (d,10,$lumen$Como vos ligastes à Ordem Maçônica?$lumen$,$lumen$Por um juramento e uma consagração.$lumen$),
    (d,11,$lumen$Que prometestes?$lumen$,$lumen$Nunca revelar o que ouvir ou me for comunicado, como segredo da Instituição, Senão a bom e legítimo Irmão ou dentro de Loja Justa, Perfeita e Regular de Maçons.$lumen$),
    (d,12,$lumen$Como se reconhece um Maçom?$lumen$,$lumen$Pelos sinais, toques e palavras, além dos atos que praticam.$lumen$),
    (d,13,$lumen$Como fazeis o sinal?$lumen$,$lumen$Com o corpo ereto, e os pés formando esquadria (Fazer o sinal).$lumen$),
    (d,14,$lumen$Como dais a palavra?$lumen$,$lumen$Não vos posso dar, somente soletrar, dai-me a primeira letra e vos darei a segunda (B-OO-Z).$lumen$),
    (d,15,$lumen$Que significa ela?$lumen$,$lumen$Força.$lumen$),
    (d,16,$lumen$Que é o toque?$lumen$,$lumen$É um dos meios universais de reconhecimento entre os Maçons. O Toque lembra a idade do Aprendiz Maçom.$lumen$),
    (d,17,$lumen$Como estais agora vestido?$lumen$,$lumen$Com um avental.$lumen$),
    (d,18,$lumen$Que significa o avental?$lumen$,$lumen$Significa que todo maçom tende trabalhar infatigavelmente para a descoberta da verdade e o aperfeiçoamento da humanidade.$lumen$),
    (d,19,$lumen$Qual é a idade do Aprendiz?$lumen$,$lumen$Três anos.$lumen$),
    (d,20,$lumen$Como se colocam o esquadro e o compasso?$lumen$,$lumen$O esquadro sobre o compasso na posição de grau, com as pontas do compasso para o Ocidente, em cima do livro das leis.$lumen$),
    (d,21,$lumen$Qual é o número que domina o grau de Aprendiz?$lumen$,$lumen$Três.$lumen$),
    (d,22,$lumen$Qual é o tempo de trabalho?$lumen$,$lumen$Do meio-dia à meia noite.$lumen$),
    (d,23,$lumen$Quais as ferramentas do Aprendiz?$lumen$,$lumen$O Maço e o Cinzel.$lumen$),
    (d,24,$lumen$Onde trabalham os Aprendizes?$lumen$,$lumen$Na Pedra Bruta.$lumen$),
    (d,25,$lumen$Onde fostes recebido Maçom?$lumen$,$lumen$Numa loja justa, perfeita e regular.$lumen$),
    (d,26,$lumen$Que é preciso para que uma loja seja justa e perfeita?$lumen$,$lumen$Que 3 governem, 5 componham e 7 completem.$lumen$),
    (d,27,$lumen$Que é uma loja regular?$lumen$,$lumen$Sendo justa e perfeita, que obedeça à potência regular da qual recebeu a carta constitutiva e pratique rigorosamente todos os princípios básicos da Maçonaria Universal.$lumen$),
    (d,28,$lumen$Que se faz em vossa loja?$lumen$,$lumen$Levantam-se Templos à virtude e cavam-se masmorras ao vício.$lumen$),
    (d,29,$lumen$Como é construída nossa loja?$lumen$,$lumen$Por três partes essenciais: Sala dos Passos Perdidos, Átrio e o Templo propriamente dito. Deve haver ainda a câmara das reflexões. A sua forma é de um quadrilongo ou retângulo alongado.
O comprimento é do oriente ao ocidente.
A largura é do sul ao norte.
A altura é da terra ao céu e a sua profundidade é da superfície ao centro da terra.$lumen$),
    (d,30,$lumen$Quantos degraus existem entre o piso do Ocidente e do Oriente e quantos conduzem ao trono?$lumen$,$lumen$Sobe-se ao oriente por 04 degraus (força, trabalho, ciência e virtude) e três ao trono (pureza, luz e verdade).$lumen$),
    (d,31,$lumen$Quais são os pilares da loja?$lumen$,$lumen$São Três: Sapientia, Salus e Stabilitas. (sabedoria, força e beleza).$lumen$),
    (d,32,$lumen$Que significa S. S. S.?$lumen$,$lumen$Sapientia, Salus e Stabilitas (sabedoria, força e beleza).$lumen$),
    (d,33,$lumen$Quais são os paramentos de uma loja?$lumen$,$lumen$São dois: Delta Luminoso e o Livro da Lei.$lumen$),
    (d,34,$lumen$Quais são os ornamentos de uma loja?$lumen$,$lumen$São três. Pavimento mosaico, corda de 81 nós, e o esquadro-compasso.$lumen$),
    (d,35,$lumen$Quais são as jóias móveis?$lumen$,$lumen$Esquadro, Nível e o Prumo.$lumen$),
    (d,36,$lumen$Quais são as jóias fixas?$lumen$,$lumen$Pedra Bruta, Pedra Cúbica e a Prancheta da Loja.$lumen$),
    (d,37,$lumen$Quantas são as colunas?$lumen$,$lumen$Duas: J e B.$lumen$),
    (d,38,$lumen$Que representam as quatro borlas?$lumen$,$lumen$As quatro virtudes cardeais: Temperança, Justiça, Coragem e Prudência.$lumen$),
    (d,39,$lumen$Que significa a espada flamejante?$lumen$,$lumen$É o emblema do magistério e instrumento necessário à consagração do Neófito, pois nela soa a Bateria do Grau.$lumen$),
    (d,40,$lumen$Que é o "Livro da Lei"?$lumen$,$lumen$A Bíblia Sagrada.$lumen$),
    (d,41,$lumen$Que nome damos ao Deus Criador?$lumen$,$lumen$Supremo Arquiteto do Universo.$lumen$),
    (d,42,$lumen$Onde se abre a Bíblia Sagrada?$lumen$,$lumen$No altar dos juramentos.$lumen$),
    (d,43,$lumen$Por que as lojas maçônicas são chamadas de Loja de São João?$lumen$,$lumen$São João Batista foi o último patrono das corporações de construtores ou Lojas da Idade Média.$lumen$),
    (d,44,$lumen$Qual é a virtude essencial de cada Maçom?$lumen$,$lumen$A Tolerância.$lumen$),
    (d,45,$lumen$Que exigiram para serdes Maçom?$lumen$,$lumen$Ser livre e de bons costumes.$lumen$),
    (d,46,$lumen$Qual é o laço que nos une?$lumen$,$lumen$O da Solidariedade.$lumen$),
    (d,47,$lumen$Como se quebra a cadeia da união?$lumen$,$lumen$Quando um Irmão trilhar os descaminhos do mal e da desonra, por que ao decair quebrou voluntariamente o elo da Fraternidade.$lumen$),
    (d,48,$lumen$Quais os fundamentos maçônicos da solidariedade?$lumen$,$lumen$A Justiça e a Honestidade.$lumen$),
    (d,49,$lumen$A que jurisdição pertence a nossa loja, e qual o rito que praticamos?$lumen$,$lumen$Ao Grande Oriente do Brasil, e praticamos o Rito Brasileiro.$lumen$);
  insert into public.decks(owner,name,description,is_shared) values (null,'Companheiro','Conjunto do grau de Companheiro',true) returning id into d;
  insert into public.cards(deck_id,position,question,answer) values
    (d,0,$lumen$Sois Companheiro Maçom?$lumen$,$lumen$Sim VM (EU VI A ESTRELA FLAMEJANTE)$lumen$),
    (d,1,$lumen$Onde fostes Recebido Companheiro?$lumen$,$lumen$Numa loja regular passando da “COLUNA B”, para a “COLUNA J”$lumen$),
    (d,2,$lumen$Que ferramenta CONDUZIEIS? Ainda era Aprendiz nesta passagem$lumen$,$lumen$Uma régua lisa sobre o ombro esquerdo.$lumen$),
    (d,3,$lumen$Quantas Viagens Realizastes?$lumen$,$lumen$Cinco Viagens
- Nas primeiras 4 viagens levei instrumentos de trabalho,
Que foram, o maço, o cinzel, o esquadro, o compasso, e a alavanca,
A régua foi o que mais trabalhei.$lumen$),
    (d,4,$lumen$Como fizeste a 5ª Viagem?$lumen$,$lumen$Com a espada no meu coração.$lumen$),
    (d,5,$lumen$Que significa a letra “G”?$lumen$,$lumen$Geometria, geração, gravidade, gênio e gnose.$lumen$),
    (d,6,$lumen$O que significa o Sinal de Ordem no Novo Juramento?$lumen$,$lumen$A mão direita sobre o coração,
É o compromisso de estimar os irmãos e recordar o juramento dos companheiros:
Que se fosse perjuro, seu coração seria arrancado para servir aos abutres.$lumen$),
    (d,7,$lumen$E no antigo Juramento?$lumen$,$lumen$Que o maçom preferia ter o pescoço cortado a revelar os segredos confiados.$lumen$),
    (d,8,$lumen$Que significa a PALAVRA PASSE?$lumen$,$lumen$Significa FARTURA E ABUNDÂNCIA.
Representada pela espiga de trigo.
(PALAVRA de PASSE é SCHIBOLETH )$lumen$),
    (d,9,$lumen$Daime a PALAVRA SAGRADA?$lumen$,$lumen$Não a recebi assim e assim não posso dá-la
- Dá-se silabada (JÁ-QUIM)$lumen$),
    (d,10,$lumen$Quem fundiu os Vasos Sagrados do Templo?$lumen$,$lumen$HIRAM-ABIF$lumen$),
    (d,11,$lumen$Quantas Romãs há sobre as colunas J e B?$lumen$,$lumen$3 romãs em cada coluna$lumen$),
    (d,12,$lumen$Qual é a Vossa Idade?$lumen$,$lumen$Cinco Anos$lumen$),
    (d,13,$lumen$Quem era Hiram?$lumen$,$lumen$Era o REI da cidade de TIRO
Construtor do templo de SALOMÃO$lumen$),
    (d,14,$lumen$Onde trabalhão os Companheiros?$lumen$,$lumen$Na pedra cúbica / polida$lumen$),
    (d,15,$lumen$Como tendes a Abeta do Vosso Avental?$lumen$,$lumen$Abaixada$lumen$),
    (d,16,$lumen$Daí a Bateria do Grau?$lumen$,$lumen$1.2.2 – (o – oo – oo)$lumen$),
    (d,17,$lumen$Qual a FERRAMENTA MAIS USADA PELOS COMPANHEIROS?$lumen$,$lumen$A régua.$lumen$),
    (d,18,$lumen$Onde o APRENDIZ apóia a Régua Lisa?$lumen$,$lumen$No ombro esquerdo$lumen$),
    (d,19,$lumen$Onde o COMPANHEIRO Apóia a Régua Graduada?$lumen$,$lumen$No ombro direito$lumen$),
    (d,20,$lumen$Quantas polegadas tem a Régua Graduada?$lumen$,$lumen$24 polegadas$lumen$),
    (d,21,$lumen$Que significa a RÉGUA?$lumen$,$lumen$É o EMBLEMA do juízo reto,
A linha reta que ela traça é o símbolo do infinito.
É o símbolo da correção moral e espiritual$lumen$),
    (d,22,$lumen$E o MAÇO?$lumen$,$lumen$É A FORÇA para vencer os obstáculos$lumen$),
    (d,23,$lumen$E o CINZEL?$lumen$,$lumen$É O VEÍCULO de aprimoramento
Segura-se, com a mão esquerda$lumen$),
    (d,24,$lumen$E a ALAVANCA?$lumen$,$lumen$A POTÊNCIA do trabalho
O PODER MULTIPLICADOR
É a força da vontade$lumen$),
    (d,25,$lumen$E o ESQUADRO?$lumen$,$lumen$É o controle das ações.
É o símbolo da RETIDÃO na razão de 3 por 4.
É o emblema da sabedoria e ESTÁ NA ESTOLA DO V.M.$lumen$),
    (d,26,$lumen$E o COMPASSO?$lumen$,$lumen$É A PROCURA DA JUSTIÇA.
ESTÁ NO JURAMENTO DO COMPANHEIRO, SOBRE O SEU CORAÇÃO$lumen$),
    (d,27,$lumen$Como se executa a Marcha do Companheiro?$lumen$,$lumen$(Tres passo de aprendiz e mais dois oblíquos),
(O PÉ PARA a direita com o pé direito) JUNTAR A ESTE O PÉ ESQUERDO,
(O PÉ PARA a esquerda com o pé esquerdo) JUNTAR A ESTE O PÉ DIREITO$lumen$),
    (d,28,$lumen$Que significa as seis (6) FACES DA PEDRA POLIDA ou (CÚBICA)?$lumen$,$lumen$Os 6 planos de ASCENÇÃO:
- MINERAL
- VEGETAL
- ANIMAL
- HUMANO
- PSÍQUICO
- DIVINO$lumen$),
    (d,29,$lumen$Que representa a ESTRELA RADIANTE?$lumen$,$lumen$É o SÍMBOLO MÁXIMO - O FOCO DA LUZ, com a LETRA G NO MEIO.$lumen$),
    (d,30,$lumen$A que é dedicado do Grau de Companheiro$lumen$,$lumen$Ao trabalho.
Qualquer um que seja:
- INTELECTUAL,
- MANUAL
- OU TÉCNICO.$lumen$),
    (d,31,$lumen$Onde se abre a Bíblia Sagrada?$lumen$,$lumen$NO NOVO TESTAMENTO, No ato dos apóstolos (20:34), que se faz elogio as mãos.
No Rito Brasileiro exalta-se o trabalho lendo$lumen$),
    (d,32,$lumen$Como se colocam o Esquadro e o Compasso em Loja de Companheiro?$lumen$,$lumen$O compasso com as pontas voltadas para o ocidente com a haste esquerda por cima de um dos ramos do esquadro e a haste direita, por baixo do outro.$lumen$),
    (d,33,$lumen$Que significam os Três (3) Castiçais em Torno do Altar dos Juramentos?$lumen$,$lumen$BRANCA SABEDORIA, - VERMELHA FORÇA E AZUL DA BELEZA$lumen$),
    (d,34,$lumen$A que horas é permitido aos Companheiros deixar os Trabalhos?$lumen$,$lumen$A MEIA NOITE. V ∴ M ∴$lumen$),
    (d,35,$lumen$Que valor tem os sentidos da Maçonaria?$lumen$,$lumen$Todos, nossas percepções são formadas pelos sentidos. Dentre os sentidos, saliento o tato, a visão e a audição$lumen$),
    (d,36,$lumen$Quantas ORDENS DE ARQUITETURA Conheceis?$lumen$,$lumen$5 ORDENS:
- A CORÍNTIA,
- A DÓRICA,
- A JÔNICA,
- A TOSCANA
- E A COMPÓSITA.$lumen$),
    (d,37,$lumen$Onde fica a Coluna de Origem Coríntia?$lumen$,$lumen$Na col.’. do sul próximo ao 2º vig.’.$lumen$),
    (d,38,$lumen$E a Dórica?$lumen$,$lumen$Na col.’. do norte próximo ao 1º vig.’.$lumen$),
    (d,39,$lumen$E a Jônica?$lumen$,$lumen$No oriente a esquerda do Venerável Mestre,$lumen$),
    (d,40,$lumen$Que é "PENTAGRAMA"?$lumen$,$lumen$Figura SIMBÓLICAS de 5 PONTAS$lumen$),
    (d,41,$lumen$Quantas PONTAS tem a ESTRELA RADIANTE?$lumen$,$lumen$5 PONTAS RAIDAS COM A LETRA G NO MEIO.$lumen$),
    (d,42,$lumen$Quando foi fundado o Grande Oriente do Brasil?$lumen$,$lumen$Em 17 de junho de 1822, no Rj
17 /06/1822$lumen$),
    (d,43,$lumen$A Maçonaria é Regional?$lumen$,$lumen$Não -- ela é universal.
Suas lojas ESTÃO por todos os LUGARES da terra
Sem preocupação de fronteiras, OU raça.$lumen$),
    (d,44,$lumen$Que é Rito?$lumen$,$lumen$Qualquer prática usada em culto.$lumen$),
    (d,45,$lumen$Um Rito pode ser Regional?$lumen$,$lumen$Sim, todo rito regular é universal, podendo ser praticado em qualquer país.$lumen$),
    (d,46,$lumen$Dai-me uma legenda maçônica que afirme nosso carácter Universal?$lumen$,$lumen$OS SINAIS, TOQUES E PALAVRAS$lumen$),
    (d,47,$lumen$Quantos Graus têm a Maçonaria Simbólica?$lumen$,$lumen$3 graus
- APRENDIZ (GRAU 1),
- COMPANHEIRO (GRAU 2)
- E MESTRE (GRAU 3).$lumen$),
    (d,48,$lumen$Como age um Companheiro?$lumen$,$lumen$Com TOLERÂNCIA E SOLIDARIEDADE$lumen$),
    (d,49,$lumen$Que símbolo viste quando de vossa elevação?$lumen$,$lumen$A Estrela Flamejante$lumen$);
end $$;
