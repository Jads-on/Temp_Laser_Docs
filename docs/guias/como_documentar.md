# 📄 Guia de Estilo e Padrões de Documentação 

Este guia estabelece os padrões técnicos, organizacionais e visuais para a escrita e manutenção de documentações da LASER. O objetivo é garantir um acervo uniforme, legível, fácil de consultar e integrado à filosofia *Docs-as-Code*.

---

## 1. Filosofia *Docs-as-Code*

Na LASER, tratamos a documentação com o mesmo rigor aplicado ao firmware e aos esquemáticos de hardware:

* **Versionamento:** Toda documentação reside no repositório Git junto com o código/projeto.
* **Revisão por Pares:** Alterações em páginas passam por Pull Request (PR) e aprovação da equipe técnica.
* **Manutenção Contínua:** Código sem documentação é considerado código incompleto. Atualize a documentação na mesma branch da funcionalidade desenvolvida.

---

## 2. Estrutura de Arquivos e Organização

### Nomenclatura de Pastas e Arquivos
* Use **`snake_case`** (letras minúsculas separadas por underline `_`) para todos os arquivos `.md` e pastas.
* Nunca utilize espaços, caracteres especiais ou acentos em nomes de arquivos.
* Toda subpasta principal deve conter um arquivo `index.md` que serve como página de entrada do módulo.

```text
docs/
├── firmware/
│   ├── index.md                 # Página inicial de Firmware
│   ├── configuracao_esp32.md    # Guia específico em snake_case
│   └── protocolos/
│       ├── index.md
│       └── can_bus.md
└── assets/
    └── firmware/
        └── esp32_pinout.png     # Assets organizados por subárea
```

### Organização de Mídias e Imagens
* Guarde imagens, diagramas e anexos na pasta **`docs/assets/<subarea>/`**.
* Dê nomes descritivos aos arquivos de mídia: `placa-fonte-v1.2-top.png` em vez de `imagem1.png`.

---

## 3. Padrões de Formatação Markdown

### Hierarquia de Títulos
Utilize a hierarquia lógica de cabeçalhos. **Nunca pule níveis** (por exemplo, de `#` direto para `###`).

* `# Titulo Principal`: Reservado apenas para o título da página (utilizado uma única vez por arquivo no topo).
* `## Seção Principal`: Para os tópicos fundamentais da página.
* `### Subseção`: Para subdivisões dentro de uma seção.
* `#### Detalhe Específico`: Usado com moderação para itens pontuais.

---

### Caixas de Aviso (*Admonitions*)

As caixas de aviso do **Material for MkDocs** devem ser usadas para destacar informações críticas. Certifique-se de **recuar o conteúdo em 4 espaços**.

#### Tipos Recomendados:

```markdown
!!! tip "Dica do Pipeline 🐾"
    Aponte boas práticas, atalhos de desenvolvimento e truques de depuração.

!!! info "Informação Geral"
    Contexto adicional, pré-requisitos ou links relevantes.

!!! warning "Atenção"
    Alertas sobre limitações de hardware, conflito de pinos ou versões incompatíveis.

!!! danger "Perigo / Cuidados de Bancada"
    Alertas críticos de segurança (ex: risco de curto-circuito, inversão de polaridade ou queima de componentes).
```

---

### Tabelas
Utilize tabelas para mapeamento de pinos (*pinouts*), especificações técnicas, comparações de componentes e registradores.

```markdown
| Pino MCU | Função | Periférico Conectado | Tensão de Operação | Observações |
| :--- | :--- | :--- | :--- | :--- |
| `GPIO21` | I2C SDA | Sensor MPU6050 | 3.3V | Requer resistor de pull-up externo (4.7kΩ) |
| `GPIO22` | I2C SCL | Sensor MPU6050 | 3.3V | — |
| `GPIO34` | ADC1_CH6 | Divisor de Tensão Bateria | Max 3.3V | Pino apenas de entrada (Input Only) |
```

---
