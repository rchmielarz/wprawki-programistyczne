all:	01_gradient
	02_ray

01_gradient: 01_gradient.o u32toascii.o
	ld -o 01_gradient 01_gradient.o u32toascii.o

01_gradient.o:
	as --gstabs+ -o 01_gradient.o 01_gradient.s

02_ray: 02_ray.o u32toascii.o
	ld -o 02_ray 02_ray.o u32toascii.o

02_ray.o:
	as --gstabs+ -o 02_ray.o 02_ray.s

03_circle: 03_circle.o u32toascii.o
	ld -o 03_circle 03_circle.o u32toascii.o

03_circle.o:
	as --gstabs+ -o 03_circle.o 03_circle.s


u32toascii.o:
	as --gstabs+ -o u32toascii.o u32toascii.s

clean:
	rm -f 01_gradient
	rm -f 02_ray
	rm -f 03_circle
	rm -f *.o

help:
	@echo "Usage: make [target]"
	@echo ""
	@echo "TARGETS:"
	@echo "   all (default)"
	@echo "   clean"
	@echo "   01_gradient"
	@echo "   02_ray"
	@echo "   03_circle"
	@echo ""
