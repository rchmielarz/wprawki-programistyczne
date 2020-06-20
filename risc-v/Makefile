all:	hello

hello: hello.o
	riscv64-linux-gnu-ld -o hello hello.o

hello.o:
	riscv64-linux-gnu-as --gstabs+ -o hello.o hello.S

clean:
	rm -f hello
	rm -f *.o

help:
	@echo "Usage: make [target]"
	@echo ""
	@echo "TARGETS:"
	@echo "   all (default)"
	@echo "   clean"
	@echo "   hello"
	@echo ""
