# Documentação de Firmware — Liga de Sistemas Embarcados

Site feito com [MkDocs Material](https://squidfunk.github.io/mkdocs-material/).

## Rodando localmente

```bash
pip install -r requirements.txt
mkdocs serve
```

Abra http://127.0.0.1:8000.

## Publicando

Push na `main` publica no GitHub Pages via GitHub Actions
(*Settings → Pages → Branch: gh-pages*).

## Contribuindo

1. Crie uma branch: `git checkout -b docs/nome-da-alteracao`
2. Edite ou crie arquivos `.md` em `docs/`
3. Página nova? Adicione em `nav` no `mkdocs.yml`
4. Abra um Pull Request

## Onde colocar cada coisa

- **Conhecimento reaproveitável** (como usar a UART, como estruturar um driver): `docs/firmware/`
- **Específico do Robocar** (pinagem do carro, protocolo, ajustes): `docs/robocar/`
- **Padrões da liga** (estilo de código, Git): `docs/guias/`
