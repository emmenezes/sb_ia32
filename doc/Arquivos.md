# Documentação reduzida sobre arquivos

## Procedimentos

### Ler aquivo

- **EAX** 3
- **EBX** descritor do arquivo (*file descriptor*)
- **ECX** ponteiro da entrada
- **EDX** tamanho do buffer

Retorna:

- **EAX** quantidade de bytes lidos ou erro


### Escrever em arquivo

- **EAX** 4
- **EBX** descritor do arquivo
- **ECX** ponteiro do buffer
- **EDX** tamanho do buffer

Retorna:

- **EAX** quantidade de bytes escritos ou erro

### Abrir arquivo

- **EAX** 5
- **EBX** nome do arquivo
- **ECX** modo de acesso
- **EDX** permissão do arquivo

Retorna:

- **EAX** descritor do arquivo ou erro

### Fechar arquivo

- **EAX** 6
- **EBX** descritor do arquivo

### Criar e abrir arquivo

- **EAX** 8
- **EBX** nome do arquivo
- **ECX** permissão do arquivo

Retorna:

- **EAX** descritor do arquivo ou erro