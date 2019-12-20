%{
#include "rtf_tab.h"
#include "rtf.h"
#include "..\common/y_pdcdef.h"
static char HexBuff[5];
%}
%array
ALOWED_IN_TOKENS	[a-z0-9\*\-]
HEX			[0-9a-fA-F]
%%
" "			|
\t			|
\n			;
\\\\			{strcpy(yytext,"\\");
			 return RTF_PLAIN_TEXT;
			};
\\\{			{strcpy(yytext,"{");
			 return RTF_PLAIN_TEXT;
			};
\\\}			{strcpy(yytext,"}");
			 return RTF_PLAIN_TEXT;
			};
\\"'"{HEX}{HEX}		{
			int C;
			strcpy(HexBuff,"0x");
			HexBuff[2]=yytext[2];HexBuff[3]=yytext[3];
			HexBuff[4]='\0';
			CONV_s_i_io (HexBuff,&C);
			sprintf (yytext,"%c",C);
			return RTF_PLAIN_TEXT;
			};
\\{ALOWED_IN_TOKENS}+	{return RTF_TOKEN;};
\{			{return LBOW;};
\}			{return RBOW;};
[^\\\{\}\t\n]+		{return RTF_PLAIN_TEXT;};


