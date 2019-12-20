/******************************************************************************

	       Copyright (c) 1984 - 2000 Prolog Development Center A/S

			    

 ModuleName:	OBJECT & CLASSES
 FileName:	Account.PRO
 PURPOSE:	OOP examples for inheritance
 Writen By :	Audun Toennesen
******************************************************************************/

/* Utility domains and predicates:  */

DOMAINS
	PURPOSE, DATE,  MOVEMENT, FIRSTNAME, LASTNAME, COMPANY_NAME = SYMBOL
	AMOUNT = REAL
PREDICATES
	get_date(DATE)	
CLAUSES
	get_date(DATE):-date(Y,M,D),format(DATE,"%/%/%",D,M,Y).
	
	
/* Class hierarchy:  A bankaccount implements book-keeping and transactions.
		     A personaccount inherits from bankaccount, implements a person name only,
		     A companyaccount inherits from personaccount, implements a company name only */

CLASS bankaccount	% interface to outside world

	PREDICATES	
		transaction(MOVEMENT,PURPOSE,AMOUNT) -(i,i,i)
		show_saldo()
		printout()
		procedure new()
	
ENDCLASS bankaccount



IMPLEMENT bankaccount			% everything here private!

	FACTS - bookeeping
		nondeterm datafile(DATE,MOVEMENT,PURPOSE,AMOUNT)
		determ saldo(AMOUNT)
	
	PREDICATES
		update_saldo(MOVEMENT,AMOUNT)

	CLAUSES
		new():-assert(saldo(0.0),bookeeping).

		transaction(MOVEMENT,PURPOSE,AMOUNT):-get_date(DATE),
					assert(datafile(DATE,MOVEMENT,PURPOSE,AMOUNT),bookeeping),
					update_saldo(MOVEMENT,AMOUNT).
					
		update_saldo(in,AMOUNT):-retract(saldo(X),bookeeping),
				 NEWSALDO=X+AMOUNT,
				 assert(saldo(NEWSALDO),bookeeping).
				 
		update_saldo(out,AMOUNT):-retract(saldo(X),bookeeping),
				 NEWSALDO=X-AMOUNT,
				 assert(saldo(NEWSALDO),bookeeping).	
				 
		show_saldo():-saldo(AMOUNT),nl,write("Saldo is:\t\t\t\t\t",AMOUNT),nl,nl.
	
		printout():-datafile(DATE,MOVEMENT,PURPOSE,AMOUNT),
		    writef("%\t%\t%\t\t%\n",DATE,MOVEMENT,PURPOSE,AMOUNT),
			    fail.
		printout():-show_saldo().
	
ENDCLASS bankaccount


CLASS personaccount : bankaccount	% interface to the outside world

	PREDICATES
		procedure new(FIRSTNAME,LASTNAME) -(i,i)
		print_name()
	
ENDCLASS personaccount


IMPLEMENT personaccount			% Strictly private!

	FACTS - namedb
		determ p_name(FIRSTNAME,LASTNAME)
	CLAUSES
		new(F,L):-bankaccount::new(),
			assert(p_name(F,L),namedb).
	
		print_name():-p_name(F,L),writef("Account responsible: % %\n\n",F,L).
	
ENDCLASS personaccount	


CLASS companyaccount : personaccount		% Public
			
	PREDICATES
		procedure new(COMPANY_NAME,FIRSTNAME,LASTNAME)
		print_company()
			    			
ENDCLASS companyaccount

IMPLEMENT companyaccount			% Private!

	FACTS - cmp_db
		determ comp_name(COMPANY_NAME)
	CLAUSES
		new(CMP,F,L):-personaccount::new(F,L),
		      	assert(comp_name(CMP),cmp_db).
		      		
		print_company():-comp_name(CMP),nl,write(CMP),nl,
		         	personaccount::print_name().	
		         
ENDCLASS companyaccount

		         	
GOAL
	ACC = companyaccount::new("Dubious Holdings Inc.","Mickey","McDuck"),
	ACC:transaction(in,"Salary",3000.0),
	ACC:transaction(in,"Lottery",1000.0),
	ACC:transaction(in,"Drugs",2000.0),
	ACC:transaction(in,"Cards",500.0),
	ACC:transaction(in,"Dames",900.0),
	ACC:transaction(out,"Taxes",400.0),
	ACC:transaction(in,"Secret",900.0),
	ACC:transaction(out,"Drinks",450.0),
	write("(Calling print_company for the company-object:)"),nl,
	ACC:print_company(),
	ACC:printout(),
	write("(Calling print_name, defined in class personaccount, for the company-object:)"),nl,
	ACC:print_name(),
	ACC:delete().
				 	