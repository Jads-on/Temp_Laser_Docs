# Git e versionamento

## Branches

| Branch | Uso |
|--------|-----|
| `main` | Código estável |
| `feature/nome` | Nova funcionalidade |
| `fix/nome` | Correção |
| `docs/nome` | Documentação |

## Commits

Padrão [Conventional Commits](https://www.conventionalcommits.org/pt-br/):

```
feat(uart): adiciona recepção por DMA
fix(pwm): corrige frequência do servo
docs(robocar): atualiza pinagem
```

## Pull Requests

- Descreva o que mudou e como testou
- Pelo menos uma revisão antes do merge

## Versões

Tags no formato `v1.0.0` (versionamento semântico).
