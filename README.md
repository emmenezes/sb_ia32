# Estudo de Assembly IA-32

## Como rodar

### Para compilar:
```
nasm -f elf -o teste.o arquivo.asm
```

### Para ligar:
```
ld -m elf_i386 -o teste teste.o
```

Se for feito uso do módulo io.mac, é importante incluí-lo.
```
ld -m elf_i386 -o teste teste.o io.o
```

### Para usar o  gdb:
```
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
|hello|X|Imprime Hello World|
|kangaroo|X|Imprime KANGAROO e depois imprime kangaroo|
|welcome|X|Recebe nome e número n, imprime apresentação e n vezes a mensagem de boas-vindas|
|numeros|X|Converte string para int um número de até 4 dígitos|
|calculadora||Faz uma calculadora que realiza operações de +-*/ simples entre dois operandos|
|haikai||Editor de haikais, que são poesias de três frases. É possível reescrever cada linha feita, e quando estiver pronto, o haikai é impresso na tela|
|cal_polinomial||Calculadora de equações polinomiais, é inserido os coeficientes, e a calculadora mostra a equação e imprime o valor da equação para x = 0, x = 1, x = 2|
|string reversa|X|Programa que reverte uma string|

## Dúvidas

- Qual a diferença entre ecx e ECX?