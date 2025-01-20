CC = gcc
ASM = nasm
LINKER = ld

ALL_DIRS = obj bin src

C_SRC = $(wildcard src/*.c)
C_OBJS = $(patsubst %.c, %.o, $(C_SRC))

ASM_SRC = $(wildcard src/*.asm)
ASM_OBJS = $(patsubst %.asm, %.o, $(ASM_SRC))

build: link
run: build
	qemu-system-i386 -kernel bin/kernel

$(C_OBJS): %.o: %.c $(ALL_DIRS)
	$(CC) -m32 -c $< -o $(patsubst src/%.o, obj/%.o, $@)

$(ASM_OBJS): %.o: %.asm $(ALL_DIRS)
	$(ASM) -f elf32 $< -o $(patsubst src/%.o, obj/%.o, $@)

link: $(C_OBJS) $(ASM_OBJS)
	$(LINKER) -m elf_i386 -T link.ld -o bin/kernel $(patsubst src/%.o, obj/%.o, $(ASM_OBJS)) $(patsubst src/%.o, obj/%.o, $(C_OBJS))

$(ALL_DIRS): %:
	mkdir $@

clean:
	rm -r bin obj