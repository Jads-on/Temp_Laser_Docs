# Plataformas e Microcontroladores

> Central de Guias e Arquiteturas de Hardware do Time de Firmware  
> Liga Acadêmica de Sistemas Embarcados — CIn/UFPE

---

!!! tip "Dica do Pipeline 🐾"
    Escolha a plataforma de processamento com base nos requisitos do sistema, não na familiaridade! Avalie o consumo energético, o determinismo de tempo real, a matriz de periféricos dedicados e a quantidade de E/S necessárias. Selecionar o circuito integrado correto na fase de projeto evita contornos complexos em software no futuro.

---

## Tabela Comparativa de Plataformas

| Plataforma | Arquitetura | Aplicação Principal | Guia Interno |
| :--- | :--- | :--- | :--- |
| **ESP32** | Xtensa 32-bit | Módulos com conectividade sem fio nativa e processamento paralelo | [Ver ESP32](esp32.md) |
| **STM32** | ARM Cortex-M | Controle de precisão, sistemas de tempo real estrito e amostragem rápida | [Ver STM32](stm32.md) |

---

## Guia de Seleção

### **Use ESP32 se:**
  * O sistema exige suporte nativo a protocolos sem fio (Wi-Fi, Bluetooth ou ESP-NOW).
  * Houver necessidade de paralelismo para separar tarefas de rádio e aplicação em núcleos dedicados.
  * O foco for prototipagem rápida e ecossistema integrado de software.

### **Use STM32 se:**
  * A aplicação exigir determinismo temporal rígido, como controle de motores em malha fechada.
  * O projeto demandar periféricos avançados de temporização ou alta taxa de conversão analógica.
  * A prioridade for o gerenciamento fino de energia e baixíssimo consumo em modo de espera.

---

## Boas Práticas Gerais

1. **Respeito aos Limites Elétricos:** Consulte sempre os limites de tensão e corrente máxima por pino e por encapsulamento total antes de realizar o projeto elétrico.
2. **Gerenciamento dos Pinos de Inicialização:** Evite conectar periféricos que alterem o estado lógico de pinos responsáveis pelo modo de boot do circuito durante a energização.
3. **Estabilidade de Alimentação:** Garanta capacitores de desacoplamento próximos a cada pino de alimentação do microcontrolador para mitigar ruídos e transientes de corrente.
4. **Arquitetura de Software Modular:** Separe a camada de abstração de hardware (HAL/Drivers) da lógica de aplicação para facilitar a portabilidade do código entre diferentes plataformas.