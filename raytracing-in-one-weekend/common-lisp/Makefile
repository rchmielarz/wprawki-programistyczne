LISP ?= sbcl

all:	01_gradient 02_vector

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

clean:
	rm -f 01_gradient
	rm -f 02_vector

help:
	@echo "Usage: make [target]"
	@echo ""
	@echo "TARGETS:"
	@echo "   all (default)"
	@echo "   clean"
	@echo "   01_gradient"
	@echo "   02_vector"
	@echo ""
