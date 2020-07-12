all: gcd primes easter

gcd: gcd.o
	riscv64-linux-gnu-ld -o gcd gcd.o

gcd.o:
	riscv64-linux-gnu-as --gstabs+ -o gcd.o gcd.S

easter: easter.o numberToAscii.o
	riscv64-linux-gnu-ld -o easter easter.o numberToAscii.o

easter.o:
	riscv64-linux-gnu-as --gstabs+ -o easter.o easter.S

numberToAscii.o:
	riscv64-linux-gnu-as --gstabs+ -o numberToAscii.o numberToAscii.S

primes: primes.o
	riscv64-linux-gnu-ld -o primes primes.o

primes.o:
	riscv64-linux-gnu-as --gstabs+ -o primes.o primes.S

clean:
	rm -f gcd
	rm -f primes
	rm -f easter
	rm -f *.o

help:
	@echo "Usage: make [target]"
	@echo ""
	@echo "TARGETS:"
	@echo "   all (default)"
	@echo "   clean"
	@echo "   gcd"
	@echo "   primes"
	@echo "   easter"
	@echo ""
