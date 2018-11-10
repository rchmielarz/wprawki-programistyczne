all: 01_gradient

01_gradient: 01_gradient.o u32toascii.o
	ld -o 01_gradient 01_gradient.o u32toascii.o

01_gradient.o:
	as --gstabs+ -o 01_gradient.o 01_gradient.s

u32toascii.o:
	as --gstabs+ -o u32toascii.o u32toascii.s

clean:
	rm 01_gradient
	rm *.o

help:
	@echo "Usage: make [target]"
	@echo ""
	@echo "TARGETS:"
	@echo "   all (default)"
	@echo "   clean"
	@echo "   01_gradient"
	@echo ""
