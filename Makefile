all:
ifdef file
	nasm -f elf -o teste.o $(file)
	ld -m elf_i386 -o teste teste.o io.o
else
	@echo "Passe o arquivo como parametro: 'make file=test.asm'"
endif
ifndef gdb
	./teste
else 
ifeq ($(gdb), 1)
	gdb teste
else
	./teste
endif
endif