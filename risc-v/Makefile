all:	gcd primes

gcd: gcd.o
	riscv64-linux-gnu-ld -o gcd gcd.o

gcd.o:
	riscv64-linux-gnu-as --gstabs+ -o gcd.o gcd.S

primes: primes.o
	riscv64-linux-gnu-ld -o primes primes.o

primes.o:
	riscv64-linux-gnu-as --gstabs+ -o primes.o primes.S

clean:
	rm -f gcd
	rm -f primes
	rm -f *.o

help:
	@echo "Usage: make [target]"
	@echo ""
	@echo "TARGETS:"
	@echo "   all (default)"
	@echo "   clean"
	@echo "   gcd"
	@echo "   primes"
	@echo ""
