
#####################################################################################################
COURSE=cs130s
ASGN=06
NAME=prolog
#####################################################################################################

test:
	(cd src; swipl -s test.pl)

turnin:
	rm -rf ./$(ASGN)-$(NAME).tgz
	tar -zcvf ../$(ASGN)-$(NAME).tgz --exclude .git ../$(ASGN)-$(NAME)
	mv ../$(ASGN)-$(NAME).tgz .
	turnin -c $(COURSE) -p $(ASGN) ./$(ASGN)-$(NAME).tgz
