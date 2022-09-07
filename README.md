# Estudo de Assembly IA-32

## Como rodar

### Para compilar:

```console
nasm -f elf -o teste.o arquivo.asm
```

### Para ligar:

```console
ld -m elf_i386 -o teste teste.o
```

Se for feito uso do módulo io.mac, é importante incluí-lo.

```console
ld -m elf_i386 -o teste teste.o io.o
```

### Para usar o  gdb:

```console
gbd arquivo
```

Para usar o gdb, é importante de não esquecer de  adicionar labels para criar os breakpoints durante a execução pelo terminal.

Comandos usados:
```
b label     // seta breakpoint
r           // run
i r         // informações sobre todos os registradores
c           // continue
display %r  // configura para mostrar o registrador r a cada passo
```

## Lista de Programas

|Arquivo|Feito|Função|
|-------|-----|------|
|numeros|X|Converte string para int um número de até 4 dígitos|
|calculadora||Faz uma calculadora que realiza operações de +-*/ simples entre dois operandos|
|haikai||Editor de haikais, que são poesias de três frases. É possível reescrever cada linha feita, e quando estiver pronto, o haikai é impresso na tela|
|cal_polinomial||Calculadora de equações polinomiais, é inserido os coeficientes, e a calculadora mostra a equação e imprime o valor da equação para x = 0, x = 1, x = 2|
|string reversa|X|Programa que reverte uma string|
|divisao|X|Exemplo simples de uso da função de idiv (divisão com sinal)|
|carry|X|Exemplo do uso do jump condicional do carry com multiplicação|

### Questões dos slides

|Arquivo|Slide|Feito|Função|
|-------|-----|-----|------|
|hello|Aula 13 - Slide 23|X|Imprime Hello World|
|kangaroo|Aula 13 - Slide 24|X|Imprime KANGAROO e depois imprime kangaroo|
|welcome|Aula 13 - Slide 25,26|X|Recebe nome e número n, imprime apresentação e n vezes a mensagem de boas-vindas|
|matrix|Aula 14 - Slide 35|||
|iomac|Aula 15 - Slide 12||Execução básica com io.mac|
|soma64bits|Aula 15 - Slide 42||Soma de 64 bits com registradores dde 32|
|condicional_aninhado|Aula 16 - Slide 14|||
||Aula 16 - Slide 16||Exemplo com loop|
||Aula 16 - Slide 16||While usando loop|
||Aula 16 - Slide 20||Exemplo com break|
||Aula 16 - Slide 23||Exemplo com continue|
|sum_func|Aula 17 - Slide 4|X|Exemplo com chamada de procedimento|
||Aula 17 - Slide 10||Exemplo com procedimento passando parâmetros como registradores|
||Aula 17 - Slide 18,19,20||Exemplo com procedimento passando parâmetros pela pilha|
||Aula 17 - Slide 29||Exemplo com fibonacci usando funções e pilhas|
