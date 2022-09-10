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

### Lista de questões
### Questões simples

|   |Arquivo    |Função |
|-  |-          |-      |
|X  |[numeros](./simples/numeros.asm)|Converte string para int um número de até 4 dígitos|
|X  |[string_reversa](./simples/string_reversa.asm)|Programa que reverte uma string, por [@gss214](https://github.com/gss214)|
|X  |[divisao](./simples/divisao.asm)|Exemplo simples de uso da função de idiv (divisão com sinal)|
|X  |[carry](./simples/carry.asm)|Exemplo do uso do jump condicional do carry com multiplicação|

### Questões complexas
|   |Arquivo    |Função |
|-  |-          |-      |
|X  |matrix_mult|Multiplicação de duas matrizes, 1x10 e 10x10, com uso de passagem de ponteiros para a função|
|   |calculadora|Faz uma calculadora que realiza operações de +-*/ simples entre dois operandos|
|   |haikai|Editor de haikais, que são poesias de três frases. É possível reescrever cada linha feita, e quando estiver pronto, o haikai é impresso na tela|
|   |cal_polinomial|Calculadora de equações polinomiais, é inserido os coeficientes, e a calculadora mostra a equação e imprime o valor da equação para x = 0, x = 1, x = 2|
|   |matrix_mult|Multiplicação de matrizes|

### Questões dos slides
As questões podem ser encontradas na pasta [slides](./slides/)

|   |Arquivo    |Slide  |Função |
|-  |-          |-      |-      |
|X  |[hello](./slides/hello.asm)|Aula 13 - Slide 23|Imprime Hello World|
|X  |[kangaroo](./slides/kangaroo.asm)|Aula 13 - Slide 24|Imprime KANGAROO e depois imprime kangaroo|
|X  |[welcome](./slides/welcome.asm)|Aula 13 - Slide 25,26|Recebe nome e número n, imprime apresentação e n vezes a mensagem de boas-vindas|
|X  |[matrix](./slides/matrix.asm)|Aula 14 - Slide 35|Faz soma de duas matrizes|
|X  |[iomac](./slides/iomac.asm)|Aula 15 - Slide 12|Execução básica com io.mac|
|X  |[soma64bits](./slides/soma64bits.asm)|Aula 15 - Slide 42|Soma de 64 bits com registradores dde 32|
|X  |[condicional_aninhado](./slides/condicional_aninhado.asm)|Aula 16 - Slide 14|Recebe número em binário e retorna número por escrito|
|X  |[loop](./slides/loop.asm)|Aula 16 - Slide 18|Exemplo com loop|
|X  |[while](./slides/while.asm)|Aula 16 - Slide 19|While usando loop|
|X  |[loop_in_loop](./slides/loop_in_loop.asm)|Aula 16 - Slide 20|Loops dentro de loop|
|X  |[break](./slides/break.asm)|Aula 16 - Slide 22|Exemplo com break|
|X  |[continue](./slides/continue.asm)|Aula 16 - Slide 23|Exemplo com continue|
|X  |[soma_funcao](./slides/soma_funcao.asm)|Aula 17 - Slide 4|Exemplo com chamada de procedimento|
|X  |[soma_funcao_pilha](./slides/soma_funcao_pilha.asm)|Aula 17 - Slide 18,19,20|Exemplo com procedimento passando parâmetros pela pilha|
|X  |[fibonacci_pilha](./slides/fibonacci_pilha.asm)|Aula 17 - Slide 29|Exemplo com fibonacci usando funções e pilhas|
