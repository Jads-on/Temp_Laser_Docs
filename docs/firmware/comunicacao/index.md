# Protocolos de Comunicação

> Central de Guias e Padrões de Comunicação do Time de Firmware  
> Liga Acadêmica de Sistemas Embarcados — CIn/UFPE

---

!!! tip "Dica do Pipeline 🐾"
    Comunicação robusta começa na arquitetura! Ao projetar a rede do robô, avalie a distância entre os nós, a tolerância a ruído, a latência crítica e a taxa de transferência necessária. Mantenha as linhas de sinal protegidas, garanta um GND unificado e sempre valide a integridade física do barramento antes de procurar bugs no firmware.

---

## Tabela Comparativa de Protocolos

| Protocolo | Meio / Tipo | Aplicação Principal | Guia Interno |
| :--- | :--- | :--- | :--- |
| **CAN Bus (TWAI®)** | Cabeado (Diferencial) | Rede interna do robô com alta imunidade a ruído e priorização | [Ver CAN Bus](can_bus.md) |
| **ESP-NOW** | Sem Fio (2.4 GHz P2P) | Links sem fio de baixa latência e comunicação ponto a ponto | [Ver ESP-NOW](esp_now.md) |

---

## Guia de Seleção

### **Use CAN Bus se:**
  * O canal de comunicação é cabeado e atravessa a estrutura física do robô.
  * O ambiente apresenta alto nível de interferência e ruído eletromagnético.
  * É necessária alta confiabilidade e determinismo na entrega de mensagens.

### **Use ESP-NOW se:**
  * A aplicação exige comunicação sem fio com a menor latência possível.
  * Os nós da rede precisam trocar dados sem a dependência de um roteador central.
  * A arquitetura é voltada para telemetria, controles remotos ou redes de sensores.

---

## Boas Práticas Gerais

1. **Integridade de Sinal e Terra:** Garanta o mesmo potencial de referência (GND) entre todos os nós conectados e respeite o casamento de impedância e terminação do meio físico.
2. **Compatibilidade de Níveis Lógicos:** Valide as tensões de operação das linhas de sinal antes da conexão direta para evitar danos aos componentes da placa.
3. **Tratamento de Falhas e Determinismo:** Configure timeouts e rotinas de recuperação para falhas de transmissão, impedindo que a perda de um pacote trave a CPU ou as tarefas do sistema em tempo real.
4. **Sincronismo de Configuração:** Mantenha os parâmetros de camada física e de enlace perfeitamente alinhados entre todos os participantes da rede.