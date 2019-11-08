LISP ?= sbcl

all:	01_gradient

01_gradient:	
	$(LISP) --eval '(push (uiop:getcwd) asdf:*central-registry*)' \
		--eval '(asdf:clear-configuration)' \
		--eval '(asdf:make "01_gradient")' \
		--eval '(quit)'

clean:
	rm -f 01_gradient

help:
	@echo "Usage: make [target]"
	@echo ""
	@echo "TARGETS:"
	@echo "   all (default)"
	@echo "   clean"
	@echo "   01_gradient"
	@echo ""
