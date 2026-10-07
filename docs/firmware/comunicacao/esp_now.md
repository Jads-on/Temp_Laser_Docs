# Como usar ESP-NOW

## O que é o ESP-NOW?
**ESP-NOW** é um protocolo de comunicação sem fio definido pela Espressif, que permite o controle direto, rápido e de baixo consumo de energia de dispositivos inteligentes, sem a necessidade de um roteador. O ESP-NOW funciona com Wi-Fi e Bluetooth LE e é compatível com os microcontroladores das séries ESP8266, ESP32, ESP32-S e ESP32-C.Utilizado principalmente em projetos de eletrodomésticos inteligentes, controle remoto, sensores, etc.

---

!!! warning "Consulte Sempre a Documentação Oficial - 🐱⚡"
    O ESP-NOW possui limitações importantes de hardware e software (como o tamanho máximo da carga útil por pacote e o limite de pares pareados). Para garantir compatibilidade com as versões do ESP-IDF e evitar falhas de transmissão, **consulte o guia oficial da Espressif**.

---

## Resumo Técnico Rápido

* **Arquitetura:** Comunicação direta *Peer-to-Peer* baseada em endereços MAC físicos.
* **Velocidade & Latência:** Transmissão instantânea sem o tempo de associação de uma rede Wi-Fi convencional.
* **Tamanho de Payload:** Até **250 bytes** por pacote de dados.
* **Criptografia:** Suporte nativo a criptografia AES (CCMP) para dados seguros entre dispositivos (*Primary Master Key* / *Local Master Key*).
* **Coexistência:** Pode rodar em paralelo com conexões Wi-Fi padrão (Station / SoftAP) ou Bluetooth, compartilhando o mesmo canal do rádio.
* **Topologias Suportadas:** Unicast, Broadcast, Um-para-Muitos, Muitos-para-Um e Muitos-para-Muitos.

---

## Casos de Uso Frequentes na Liga

* **Telemetria de Baixa Latência:** Envio de dados de sensores de robôs e placas em tempo real.
* **Controle Remoto / Joysticks:** Transmissão de comandos sem a latência de roteadores externos.
* **Redes de Sensores Sem Fio (WSN):** Dispositivos alimentados por bateria que acordam do *Deep-sleep*, enviam o pacote via ESP-NOW e retornam ao modo de economia imediatamente.

---

## Documentação Oficial da Espressif Systems

Acesse a documentação da API para ver exemplos de código C/C++, tratamento de retornos e callback de envio/recebimento:

* **[ESP-NOW User Guide — ESP-IDF Documentation](https://docs.espressif.com/projects/esp-idf/en/latest/esp32/api-reference/network/esp_now.html)**  
  *Consulte para:* Funções da API em C (`esp_now_init`, `esp_now_send`), limites de *peers* cadastrados, eventos de *callback* e gerenciamento de chaves de criptografia.