com : 
	(cd hdl; make com)

sim :
	(cd hdl; make sim)

dve : 
	(cd hdl; make dve)

verdi :
	(cd hdl; make verdi)

clean :
	(cd hdl; make clean)

help :
	@echo "compile	 : make com"
	@echo "simulate : make sim"
	@echo "dve	 : make dve"
	@echo "verdi	 : make verdi"
	@echo "clean	 : make clean"
	@echo "To pass comiple time agrs : CFLAGS=+<arg>" 
