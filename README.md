# Banco-de-Dados
Repositório do Banco de Dados da atividade da cadeira de Banco de Dados II - Faculdade Senac PE

# 🎵 Banco de Dados: Escola de Música

Este projeto modela o banco de dados de uma **escola de música**, com informações sobre orquestras, músicos, sinfonias, instrumentos e suas funções.

---

## 🧱 Estrutura do Banco de Dados

### Tabelas Principais

- **Orquestra**  
  Armazena as orquestras registradas.
  - **id_orquestra** (PK)
  - **nome**, **cidade**, **pais**, **data_criacao**

- **Sinfonia**  
  Representa uma sinfonia executada por uma orquestra.  
  - **id_sinfonia** (PK)  
  - FK → `Orquestra(id_orquestra)`  
  - **nome**, **compositor**, **data_criacao**

- **Músico**  
  Armazena informações pessoais dos músicos e sua orquestra.  
  - **id_musico** (PK)  
  - FK → `Orquestra(id_orquestra)`  
  - **nome**, **identidade**, **nacionalidade**, **data_nascimento**

- **Função**  
  Define o papel do músico em determinada sinfonia.  
  - **id_funcao** (PK)  
  - **nome_funcao**

- **Instrumento**  
  Lista de instrumentos musicais disponíveis.  
  - **id_instrumento** (PK)  
  - **nome_instrumento**

---

## 🔗 Tabelas Associativas

- **Musico_Instrumento**  
  Representa a relação N:N entre músicos e instrumentos.  
  - (PK) **id_musico**, **id_instrumento**  
  - FK → `Musico(id_musico)`  
  - FK → `Instrumento(id_instrumento)`

- **Musico_Funcao_Sinfonia**  
  Relaciona músicos, sinfonias, funções e instrumentos em execuções.  
  - (PK) **id_musico**, **id_sinfonia**, **id_funcao**  
  - FKs → `Musico`, `Sinfonia`, `Funcao`, `Instrumento`  
  - **data_assumicao**

---

## 🧭 Relacionamentos Principais

| Relação | Tipo | Descrição |
|----------|------|-----------|
| Orquestra — Sinfonia | 1:N | Uma orquestra executa várias sinfonias |
| Orquestra — Músico | 1:N | Uma orquestra possui vários músicos |
| Músico — Instrumento | N:N | Um músico pode tocar vários instrumentos |
| Músico — Função — Sinfonia | N:N:N | Um músico pode assumir diferentes funções em diferentes sinfonias |
| Instrumento — Musico_Funcao_Sinfonia | 1:N | Define o instrumento usado por um músico em determinada sinfonia |

---

## 🖼️ Diagrama Lógico (Exemplo)

```mermaid
erDiagram
    ORQUESTRA ||--o{ SINFONIA : "executa"
    ORQUESTRA ||--o{ MUSICO : "possui"
    MUSICO ||--o{ MUSICO_INSTRUMENTO : "toca"
    INSTRUMENTO ||--o{ MUSICO_INSTRUMENTO : "é tocado por"
    MUSICO ||--o{ MUSICO_FUNCAO_SINFONIA : "atua em"
    SINFONIA ||--o{ MUSICO_FUNCAO_SINFONIA : "possui"
    FUNCAO ||--o{ MUSICO_FUNCAO_SINFONIA : "define"
    INSTRUMENTO ||--o{ MUSICO_FUNCAO_SINFONIA : "utiliza"
