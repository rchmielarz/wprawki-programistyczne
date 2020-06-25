all:	gcd

gcd: gcd.o
	riscv64-linux-gnu-ld -o gcd gcd.o

gcd.o:
	riscv64-linux-gnu-as --gstabs+ -o gcd.o gcd.S

clean:
	rm -f gcd
	rm -f *.o

help:
	@echo "Usage: make [target]"
	@echo ""
	@echo "TARGETS:"
	@echo "   all (default)"
	@echo "   clean"
	@echo "   gcd"
	@echo ""
