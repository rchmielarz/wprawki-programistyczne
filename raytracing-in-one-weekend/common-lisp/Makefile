LISP ?= sbcl

all:	01_gradient 02_vector 03_ray

01_gradient:
	$(LISP) --eval '(push (uiop:getcwd) asdf:*central-registry*)' \
		--eval '(asdf:clear-configuration)' \
		--eval '(asdf:make "01_gradient")' \
		--eval '(quit)'

02_vector:
	$(LISP) --eval '(push (uiop:getcwd) asdf:*central-registry*)' \
		--eval '(asdf:clear-configuration)' \
		--eval '(asdf:make "02_vector")' \
		--eval '(quit)'

03_ray:
	$(LISP) --eval '(push (uiop:getcwd) asdf:*central-registry*)' \
		--eval '(asdf:clear-configuration)' \
		--eval '(asdf:make "03_ray")' \
		--eval '(quit)'

clean:
	rm -f 01_gradient
	rm -f 02_vector
	rm -f 03_ray

help:
	@echo "Usage: make [target]"
	@echo ""
	@echo "TARGETS:"
	@echo "   all (default)"
	@echo "   clean"
	@echo "   01_gradient"
	@echo "   02_vector"
	@echo "   03_ray"
	@echo ""
