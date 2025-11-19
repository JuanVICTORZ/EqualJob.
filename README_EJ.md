EqualJob – Recrutamento Ético e Inclusivo
Aplicativo desenvolvido para a Global Solution 2 – FIAP

Autores:
- JUAN VICTOR  | 
- GUSTAVO GOULART  | 


------------------------------------------------------
1. Sobre o Projeto
------------------------------------------------------

EqualJob é um aplicativo mobile de recrutamento ético e inclusivo,
focado em aproximar candidatos e empresas com base em competências
e valores, reduzindo vieses inconscientes comuns em processos seletivos.

A plataforma prioriza:
- Anonimização do perfil do candidato (sem foto, idade ou gênero)
- Matching baseado somente em skills e objetivos profissionais
- Chatbot ético orientado por IA para ajudar candidatos e recrutadores
- Vagas inclusivas com políticas reais de diversidade

O objetivo principal é promover diversidade, inclusão, equidade e
transparência no mercado de trabalho.

------------------------------------------------------
2. Tecnologias Adotadas e Benefícios
------------------------------------------------------

A seguir estão as tecnologias utilizadas no projeto e os motivos
pelos quais foram escolhidas.

------------------------------------------------------
2.1 React Native (Frontend Mobile)
------------------------------------------------------

O aplicativo foi desenvolvido em **React Native** devido aos seguintes benefícios:

✓ Desenvolvimento multiplataforma (Android e iOS)  
✓ Grande ecossistema e comunidade consolidada  
✓ Hot Reload, acelerando o desenvolvimento  
✓ UI nativa com excelente desempenho  
✓ Integração facilitada com APIs REST e Firebase  
✓ Baixo custo de manutenção  

O uso do React Native permite que o EqualJob seja acessível em grande
escala, mantendo alta performance e experiência fluida.

------------------------------------------------------
2.2 Oracle Database + PL/SQL
------------------------------------------------------

O banco de dados utiliza **Oracle 19c** com rotinas escritas em **PL/SQL**.

Benefícios:

✓ Alta confiabilidade e robustez  
✓ Suporte nativo a transações ACID  
✓ Excelente escalabilidade para sistemas corporativos  
✓ Ferramentas avançadas de auditoria e segurança  
✓ Linguagem PL/SQL permite automação de negócios no próprio banco  

No EqualJob, o Oracle é usado para:

- Registro de candidaturas  
- Logs de interações do chatbot  
- Captura de snapshots anonimizados de perfis  
- Auditoria e rastreabilidade (APP_LOG e CHAT_LOG)  

As rotinas PL/SQL implementadas incluem:
- `sp_log_chat_interaction`  
- `sp_register_application`  
- `fn_get_application_summary`  

------------------------------------------------------
2.3 Firebase (Autenticação + IA no Chatbot)
------------------------------------------------------

O Firebase foi utilizado como componente auxiliar em:

- Autenticação de usuários (Firebase Auth)
- Armazenamento de mensagens do chatbot
- Treinamento leve do modelo de recomendação
- Notificações push para status das candidaturas

Benefícios:

✓ Configuração rápida  
✓ Alta disponibilidade  
✓ Gerenciamento automático de usuários  
✓ Segurança integrada  
✓ Conexão fácil com React Native  

------------------------------------------------------
2.4 Node.js/Express (API Backend — opcional)
------------------------------------------------------

Foi utilizado um backend simples em Node.js para:

- Servir endpoints REST do EqualJob
- Intermediar comunicação entre app, Oracle e chatbot
- Gerenciar logs e autenticações

Benefícios:

✓ Alta velocidade para I/O  
✓ Fácil integração com Oracle e Firebase  
✓ Código limpo e modular  
✓ Grande ecossistema NPM  

------------------------------------------------------
3. Arquitetura Geral da Solução
------------------------------------------------------

Frontend (React Native)
   ↳
API Backend (Node.js)
   ↳
Oracle Database (Jobs, Users, Logs)
   ↳
Firebase (Auth + Chatbot Layer)

------------------------------------------------------
4. Instruções de Execução do Projeto
------------------------------------------------------

Backend:
1. Instale dependências:
   npm install
2. Inicie o servidor:
   npm run dev

Mobile (React Native):
1. Instale dependências:
   npm install
2. Executar no Android:
   npx react-native run-android

Banco de Dados Oracle:
1. Executar os arquivos na seguinte ordem:
   - create_sequences.sql
   - create_tables.sql
   - plsql_procedures.sql

------------------------------------------------------
5. Benefícios Gerais da Solução
------------------------------------------------------

- Redução de vieses inconscientes em recrutamento  
- Promoção ativa de diversidade e inclusão  
- Candidaturas anonimizadas aumentam a equidade  
- Chatbot educa candidatos e recrutadores  
- Processo seletivo mais transparente, justo e humano  
- Uso de IA para apoiar (não substituir) decisões  

------------------------------------------------------
6. Links Obrigatórios para Entrega
------------------------------------------------------

Pitch Comercial (YouTube – não listado):
<COLOCAR LINK>

Pitch Técnico (YouTube – não listado):
<COLOCAR LINK>

Repositório GitHub:
<COLOCAR LINK>
