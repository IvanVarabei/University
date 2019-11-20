%{
#include "ipf.h"
#include "ipf_tag.h"
%}
%union  {
		int	num;
		LITERAL	lit;
		NAME	name;
	}
%token IPF_START_TAG_BEGIN
%token IPF_END_TAG_BEGIN
%token IPF_TAG_END
%token IPF_TAG_TERMINATE
%token IPF_STRING
%token IPF_ERROR
%token <lit> 	IPF_LITERAL
%token <name> 	IPF_ATT
%token <num>	IPF_NUMERIC
%left EQ
%start doc
%%
doc	: 
	| doc tok
;
tok	: tag
	| plain
;
tag: start_tag | end_tag |
	error IPF_TAG_END
;
start_tag: start_tag_begin attlist tag_end
	{
		ipf_BeginTag ();
	}
	| start_tag_begin attlist term_tag
;
end_tag: end_tag_begin IPF_ATT tag_end
	{
		ipf_EndTag ($2);
	}
;
start_tag_begin: IPF_START_TAG_BEGIN
	{
		ipf_ClearTag ();
	}
;
end_tag_begin: IPF_END_TAG_BEGIN
;
tag_end: IPF_TAG_END
;                                         
term_tag: IPF_TAG_TERMINATE
;
plain: IPF_STRING
	{
		ipf_AddPlainText (yytext);
	}
;
attlist:
	| attlist attrib
;
attrib: IPF_ATT EQ IPF_LITERAL
		{
			ipf_AddAttribute ($1,attval_lit,$3,0);
		}
	| IPF_ATT EQ IPF_ATT
		{
			ipf_AddAttribute ($1,attval_atom,$3,0);
		}
	| IPF_ATT EQ IPF_NUMERIC
		{
			ipf_AddAttribute ($1,attval_num,"",$3);
		}
	| IPF_ATT
		{
			ipf_AddAttribute ($1,attval_nill,"",0);
		}
	| error
;
%%
