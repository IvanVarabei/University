%{
#include "rtf.h"
#include "rtf_mem.h"
#include "rtf_stmt.h"
#include "rtf_proc.h"
%}
%token	RTF_TOKEN RTF_PLAIN_TEXT LBOW RBOW
%%
token_list:	/* [] */
 | token_list rtf_token
 ;
rtf_token: stmt
 | RTF_TOKEN
	{
		if(!process_Token(yytext)) YYABORT;
	}
 ;
 | RTF_PLAIN_TEXT
	{
		if(!AddStrToParaBuff(yytext))
		{
			yyerror ("current paragraph is to big");
			YYABORT;
		}
	}
;
stmt: begin_stmt token_list end_stmt
;
begin_stmt: LBOW
	{stmt_nest++; stmt_Begin ();}
;
end_stmt: RBOW
	{
		if (stmt_nest==0)
		{
			yyerror ("misplaced brace");
			YYABORT;
		}
		else
		{
			stmt_nest--;
			stmt_End ();
		}
	}
;
/********** End of Grammar **************/
%%

