# Estudo de Assembly IA-32

## Como rodar

Para compilar:
```
nasm -f elf -o arquivo.o arquivo.asm
```

Para ligar:
```
ld -m elf_i286 -o arquivo arquivo.o
```

## Lista de Programas 

|Arquivo|Função|
|-------|------|
|hello|Imprime Hello World|
|kangaroo|Imprime KANGAROO e depois imprime kangaroo|
|welcome|Recebe nome e número n, imprime apresentação e n vezes a mensagem de boas-vindas|
|calculadora|Faz uma calculadora que realiza operações de +-*/ simples entre dois operandos|