# Protocolo CAN Bus

> Guia e Padrões de Comunicação via Barramento CAN  
> Liga Acadêmica de Sistemas Embarcados — CIn/UFPE

---

!!! tip "Dica do Pipeline 🐾"
    Como o CAN é uma rede relativamente simples em componentes, cerca de 90% dos problemas na bancada são causados por curtos-circuitos nos fios do barramento ou falhas nos chips transceptores dos dispositivos. Sempre verifique o meio físico primeiro!

---

## 1. Visão Geral e Histórico

O **CAN** (*Controller Area Network* — Rede de Controle em Área) foi desenvolvido por Robert Bosch em 1980 com foco na comunicação entre módulos eletrônicos automotivos. Seu objetivo principal foi substituir os sistemas de fiação ponto a ponto, reduzindo o peso do chicote elétrico e aumentando a segurança contra falhas do sistema.

Trata-se de uma comunicação serial na qual os dados são enviados bit a bit em sequência, permitindo a conexão de múltiplos dispositivos em um único barramento sem uma relação mestre-escravo: todos os nós conectados podem enviar e receber dados.

---

## 2. Meio Físico e Níveis de Tensão

A comunicação utiliza dois fios chamados **CANH** (CAN High) e **CANL** (CAN Low). A interpretação dos bits é feita por **tensão diferencial** (diferença entre CANH e CANL) para garantir imunidade a ruídos elétricos:

* **Bit Recessivo (1):** CANH - CANL > 0.9V
* **Bit Dominante (0):** CANH - CANL < 0.5V

> !!! note "Nota: Comparador com Histerese - 🐱⚡"
     Na faixa intermediária entre 0.5V e 0.9V, o valor do bit permanece inalterado em relação ao seu estado atual, mudando apenas ao cruzar esses limites.

---

## 3. Estrutura do Frame CAN

A transferência de dados ocorre através de quadros de mensagem (*frames*) organizados na seguinte sequência:

```text
SOF -> ID -> RTR -> IDE -> R0 -> DLC -> Mensagem -> CRC -> ACK -> EOF -> IFS
```

| Campo | Nome Extenso | Descrição e Comportamento |
| :--- | :--- | :--- |
| **SOF** | *Start of Frame* | Marca o início da mensagem (sempre nível `0`). |
| **ID** | *Identification* | Define o nível de prioridade e o tipo de mensagem. Configurado pelo projetista. |
| **RTR** | *Remote Transmission Request* | Flag de requisição: `0` (leva dados) ou `1` (solicitação de dados). |
| **IDE** | *Identifier Extension* | Identifica o tamanho do ID: `0` (Standard = 11 bits) ou `1` (Extended = 29 bits). |
| **R0** | *Reserved 0* | Indica a versão: `0` (CAN Clássico) ou `1` (CAN FD / Bit FDF). |
| **DLC** | *Data Length Control* | Indica o tamanho da mensagem (quantidade de bits/bytes). |
| **Mensagem** | *Payload* | Dado ou comando transmitido. |
| **CRC** | *Cyclic Redundancy Check* | Código de verificação de integridade calculado sobre ID, dados e controle. |
| **ACK** | *Acknowledge* | Flag alterada pelo destinatário confirmando o recebimento da mensagem. |
| **EOF** | *End of Frame* | Indica o fim do frame (sempre nível `1`). |
| **IFS** | *Inter-Frame Space* | Espaço de 3 bits de intermissão entre frames consecutivos (sempre nível `1`). |

* **Tamanho total do frame:** Varia entre **112 bits** (com ID Standard) e **128 bits** (com ID Extended).
* **Função do ID:** Como todas as mensagens trafegam pelo mesmo barramento público, o campo ID garante que apenas os dispositivos configurados para aquele identificador processem a informação.

---

## 4. Normas de Barramento e Velocidade

| Norma / Tipo | Faixa de Velocidade | Observação |
| :--- | :--- | :--- |
| **CAN High Speed** (ISO 11898) | 125 kbps a 1 Mbps | **500 kbps** é a velocidade padrão mais comum para sistemas vitais. |
| **CAN Low Speed** (ISO 11519-2) | 10 kbps a 125 kbps | Voltado para aplicações de baixa velocidade. |
| **CAN FD** (Flexible Data-Rate) | Até 8 Mbps | Evolução do protocolo para maiores volumes de dados. |

---

## 5. Divisão de um Dispositivo e do Barramento

Um nó em uma rede CAN é composto por três blocos principais:

1. **Interface de Aplicação:** Executa as ações/funções do sistema (sensores, atuadores). Geralmente composta por um microcontrolador ou processador.
2. **Módulo CAN (Controlador e Transceptor):** 
   * **Controlador:** Gerencia o protocolo, montagem e arbitragem de frames.
   * **Transceptor:** Chip externo (ex: **TJA1050**, **MCP2551**) que converte o sinal digital do controlador na tensão diferencial aplicada aos dois fios do barramento.
3. **Barramento CAN:** Composto pelos fios `CANH` e `CANL` e **dois resistores de terminação de 120 Ω** instalados nas extremidades (que também podem estar integrados nas saídas dos módulos transceptores).

### Capacidade de Endereçamento e Nós
* **Endereçamento por IDs:** O protocolo suporta até **2.048 IDs** no modo Standard e até **539 milhões de IDs** no modo Extended.
* **Quantidade de Nós Físicos:** O limite físico depende do transceptor utilizado. O TJA1050 suporta até **110 nós**, mas o padrão amplamente utilizado é de até **64 nós** por barramento.

---

## 6. Arbitragem e Acesso ao Meio (CSMA/CR)

A comunicação no barramento CAN opera em modo **Half-Duplex** através do método **CSMA/CR** (*Carrier Sense Multiple Access with Collision Resolution*):

### Como funciona o processo de arbitragem:
1. Vários dispositivos podem iniciar a transmissão simultaneamente.
2. À medida que o campo **ID** é transmitido bit a bit, ocorre a sincronização pelos intervalos de subida e descida do sinal.
3. Se um nó tenta enviar um bit de menor prioridade e detecta que o barramento recebeu um bit de maior prioridade (ex: tentou enviar um bit recessivo `1` e leu um dominante `0`), ele interrompe sua transmissão imediatamente e entra em fila de espera sem corromper a mensagem em andamento.
4. Ao final da arbitragem, apenas a mensagem com o ID de maior prioridade permanece no barramento.

### Confirmação de Integridade e Liberação:
1. Durante a transmissão, o nó emissor calcula o **CRC** unindo os bits de ID, mensagem e controle através de uma divisão por escalar.
2. Ao receber o frame, o nó receptor executa o mesmo cálculo. Se os valores forem idênticos, confirma-se a integridade da mensagem.
3. O receptor então altera o bit **ACK** para confirmar o recebimento.
4. Após o frame, ocorre um tempo de intermissão (**IFS** de 3 bits) onde o barramento fica livre para a transmissão da próxima mensagem na fila.

> **Analogia:** O barramento funciona como uma placa visível a todos. Quando a mensagem enviada chega ao destinatário correto e sua integridade é confirmada via CRC, o destinatário altera a cor da placa para verde (ACK), sinalizando a todos na rede que a mensagem foi recebida com sucesso.