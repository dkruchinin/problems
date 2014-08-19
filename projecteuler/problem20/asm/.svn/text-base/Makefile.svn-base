AS=as
LD=ld

all: problem20

problem20: problem20.o
	$(LD) -dynamic-linker /lib/ld-linux-x86-64.so.2 -lc $< -o $@

problem20.o: problem20.s
	$(AS) -g --64 $< -o $@

clean:
	rm -f *.o problem20