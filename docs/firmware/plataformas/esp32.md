# ESP32 — Visão Geral & Fontes Oficiais

O **ESP32** é uma série de SoCs (*System on a Chip*) de baixo custo e alto desempenho desenvolvida pela **Espressif Systems**. Ele combina conectividade sem fio e alto poder de processamento em um único circuito integrado, sendo a uma das principal plataformas para projetos de IoT e de sistemas embarcados.

---

!!! tip "Consulte Sempre a Documentação Oficial - 🐱⚡"
    Para evitar informações desatualizadas, divergências entre revisões de silício (*silicon revisions*) ou dados elétricos incorretos, **recomenda-se fortemente consultar os manuais e datasheets oficiais da Espressif** antes de desenhar placas ou implementar drivers.

---

## Resumo Técnico Rápido

* **Processador:** Xtensa® Dual-Core 32-bit LX6 (até 240 MHz, 600 DMIPS) + Coprocessador ULP (*Ultra-Low-Power*).
* **Conectividade:** Wi-Fi 2.4 GHz (802.11 b/g/n) + Bluetooth 4.2 (BR/EDR e BLE).
* **Memória Interna:** 520 KB SRAM + 448 KB ROM.
* **Segurança por Hardware:** Criptografia de Flash, *Secure Boot*, aceleradores AES/SHA/RSA e RNG.
* **Periféricos:** GPIO, ADC, DAC, UART, SPI, I2C, PWM, Touch Capacitivo, CAN Bus (TWAI®) e Ethernet MAC.
* **Framework Oficial:** **ESP-IDF** (baseado em FreeRTOS).

---

## Documentação Oficial da Espressif Systems

Acesse os links oficiais para obter informações exatas sobre limites elétricos, registradores e APIs atualizadas:

* **[ESP32 Datasheet (PDF)](https://documentation.espressif.com/esp32_datasheet_en.html)**  
  *Consulte para:* Mapeamento de pinos (*pinouts*), especificações elétricas, consumo por modo de energia e diagramas de encapsulamento.

* **[ESP32 Technical Reference Manual (PDF)](https://www.espressif.com/sites/default/files/documentation/esp32_technical_reference_manual_en.pdf)**  
  *Consulte para:* Detalhamento avançado de registradores, funcionamento interno dos periféricos, interrupções e mapa de memória.

* **[ESP-IDF Programming Guide](https://docs.espressif.com/projects/esp-idf/en/latest/esp32/)**  
  *Consulte para:* Documentação oficial de software, guias de APIs em C/C++, gerenciamento de *tasks* no FreeRTOS e exemplos de código.

  ---

!!! tip "Site extraoficial com informações auxiliares desenvolvido por Lucas Rayan Guerra 🐾 "
    * **[ESPDocs](https://espdocs.cienciaembarcada.com.br/)**  
    *Consulte para: Comparação entre 12 séries de chips, erros comuns de firmware, descubrir o ESP32 ideal para o seu projeto e consultar pinouts.*

