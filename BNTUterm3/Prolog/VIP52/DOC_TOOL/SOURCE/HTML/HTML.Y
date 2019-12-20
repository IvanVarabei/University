%{
#include "html.h"
#include "html_tag.h"
%}
%union  {
		int     num;
		LITERAL lit;
		NAME    name;
	}
%token HTML_START_TAG_BEGIN
%token HTML_END_TAG_BEGIN
%token HTML_TAG_END
%token HTML_STRING
%token HTML_WHITESPACE
%token <lit>    HTML_LITERAL
%token <name>   HTML_ATT
%token <num>    HTML_NUMERIC
%token <lit>    HTML_PROLOG
%left EQ
%start doc
%%
doc     : prolog docbody
	;
prolog  :
	| prolog prolog_element
	;
prolog_element : HTML_PROLOG
	{
		AddDocProlog ($1);
	}
;
docbody :
	| docbody tok
;
tok     : tag
	| plain
	| prolog
;
tag: start_tag | end_tag |
	error HTML_TAG_END|HTML_END_TAG_BEGIN|HTML_START_TAG_BEGIN
	{
		yyerrok;
		yyclearin;
	}
;
start_tag: start_tag_begin attlist tag_end
	{
		BeginTag ();
	}
;
end_tag: end_tag_begin HTML_ATT tag_end
	{
		EndTag ($2);
	}
;
start_tag_begin: HTML_START_TAG_BEGIN
	{
		ClearTag ();
	}
;
end_tag_begin: HTML_END_TAG_BEGIN
;
tag_end: HTML_TAG_END
;
plain: HTML_STRING
	{
		AddPlainText (yytext);
	}
;
plain: HTML_WHITESPACE
	{
		AddWhiteSpace ();
	}
;
attlist:
	| attlist attrib
;
attrib: HTML_ATT EQ HTML_LITERAL
		{
			AddAttribute ($1,attval_lit,$3,0);
		}
	| HTML_ATT EQ HTML_ATT
		{
			AddAttribute ($1,attval_atom,$3,0);
		}
	| HTML_ATT EQ HTML_NUMERIC
		{
			AddAttribute ($1,attval_num,"",$3);
		}
	| HTML_ATT
		{
			AddAttribute ($1,attval_nill,"",0);
		}
;
%%
