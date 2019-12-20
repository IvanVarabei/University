%{
#include "ipf.h"
#include "ipf_tab.h"
#include "ipf_key.h"
#include "ipf_tag.h"
#include "ipf_sym.h"
#include "../common/misc.h"

#define YY_PROLOG_FROM_STRING 1

#define MAX_INCLUDE_DEPTH 16
YY_BUFFER_STATE include_stack [MAX_INCLUDE_DEPTH];
int include_stack_ptr=0;

extern IO_RdFile (char *FN, char **pStr);

void ipf_IncludeFile (char *FN)
{
	char  *pStr;

	if (include_stack_ptr >= MAX_INCLUDE_DEPTH)
        	yyerror ("Includes nested too deeply");
        else
        {
		if (!RUN_StackTrap())
		{
			IO_RdFile (FN, &pStr);

                	include_stack[include_stack_ptr++]=YY_CURRENT_BUFFER;
			yy_scan_string (pStr);
		}
		else
		{
			char Msg[128];
			sprintf (Msg,"Include file %s not found",FN);
			yyerror (Msg);
		}
        }
}

#define INVALID_FIRST_TAG	0
#define VALID_FIRST_TAG		1
#define VALID_OTHER_TAG		2

static TagCount = -1;

int ipf_ValidTag (char *Name)
{
	TagCount++;

	if (TagCount==0)
	{
		char Temp[128];
                strcpy_tolower (Temp,Name);
                if ( ipf_GetTagValue(Temp)==tag_Common )
                {
			return INVALID_FIRST_TAG;
		}
        	else return VALID_FIRST_TAG;
        }
        else return VALID_OTHER_TAG;
}


%}
WS	[ \t\n]
b	[bB]
r	[rR]
i	[iI]
m	[mM]
%start	INTAG INFILE
%array
%%
<INITIAL>\.\*[^\n]*	; /* eat comments	*/
<INITIAL>\.{b}{r}	{
			ipf_AddLineBreak();
		};
<INITIAL>\.{i}{m}	{
			BEGIN INFILE;
		};
<INITIAL>\.	{
                        return IPF_STRING;
		};
<INITIAL>\:	{
			BEGIN INTAG;
			TagCount = -1;
			return IPF_START_TAG_BEGIN;
		};
<INITIAL>\:e	{
			BEGIN INTAG;
			TagCount = -1;
			return IPF_END_TAG_BEGIN;
		};
<INTAG>\.	{
			BEGIN INITIAL;
			TagCount = -1;
			return IPF_TAG_END;
		};
<INTAG>{WS}	;
<INTAG>=	{
			if (ipf_ValidTag(yytext)==VALID_OTHER_TAG)
                        	return EQ;
                	else
                	{
                		BEGIN INITIAL;
                		return IPF_STRING;
                	}
		};
<INTAG>"'"[^']*"'"	{
			if (ipf_ValidTag(yytext)==VALID_OTHER_TAG)
                        {
                        	ipf_ExtractLiteral('\'');
				return (IPF_LITERAL);
                        }
                        else
                        {
                        	BEGIN INITIAL;
				ipf_AddPlainText (yytext);
                                return IPF_TAG_TERMINATE;
                        }
		};
<INTAG>\"[^\"]*\"	{
			if (ipf_ValidTag(yytext)==VALID_OTHER_TAG)
                        {
                        	ipf_ExtractLiteral ('"');
				return (IPF_LITERAL);
                	}
                	else
                	{
                		BEGIN INITIAL;
				ipf_AddPlainText (yytext);
                		return IPF_TAG_TERMINATE;
                	}
		};
<INTAG>[0-9]+		{
			if (ipf_ValidTag(yytext)==VALID_OTHER_TAG)
                        {
                                CONV_s_i_io (yytext,&(ipf_yylval.num));
				return IPF_NUMERIC;
                	}
                	else
                	{
                		BEGIN INITIAL;
				ipf_AddPlainText (yytext);
                		return IPF_TAG_TERMINATE;
                	}
		};
<INTAG>[a-zA-Z0-9_\-\x80-\xFF]+	{
                        if (ipf_ValidTag(yytext)==INVALID_FIRST_TAG)
                        {
		              	BEGIN INITIAL;
                        	ipf_AddPlainText (":");
				ipf_AddPlainText (yytext);
                        	return IPF_TAG_TERMINATE;
                        }
                        else
                        {
				strcpy (ipf_yylval.name,yytext);
				return IPF_ATT;
                	}
		};
<INFILE>\n	{
			BEGIN INITIAL;
		};
<INFILE>"'"[^']*"'"	{
			ipf_ExtractLiteral('\'');
			BEGIN INITIAL;
			ipf_IncludeFile (yylval.lit);
		};
<INFILE>\"[^\"]*\"	{
			ipf_ExtractLiteral ('"');
			BEGIN INITIAL;
			ipf_IncludeFile (yylval.lit);
		};
<INFILE>[ \t]	;	/* skip spaces	*/
<INFILE>[^\t\n\ ]+	{
			BEGIN INITIAL;
			ipf_IncludeFile (yytext);
		};
<INITIAL>\n     {
        	if (ipf_NLENDEDTAG)
        	{
                	ipf_NLENDEDTAG=FALSE;
                	ipf_EndTag ("NLEND");
		};
		if (ipf_CGRAPHIC)
		{
			return (IPF_STRING);
		};
        };
<INITIAL>\t         ;       /* skip spaces  */
<INITIAL>"&"[a-zA-z0-9]+"." {
			ipf_SymbolByValue (yytext);
		};
<INITIAL>[^:\t\n\.\&]+	{
			return IPF_STRING;
		};
<<EOF>>		{
	if (--include_stack_ptr>=0)
        {
        	yy_delete_buffer (YY_CURRENT_BUFFER);
                yy_switch_to_buffer (include_stack[include_stack_ptr]);
        }
	else
	{
		yyterminate ();
	}
};
        
.	/* skip all other */

%%
