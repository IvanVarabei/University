/*****************************************************************************

		Copyright (c) 1984 - 1999 Prolog Development Center A/S

 Project:  DOCCNV
 FileName: IPF_TAB.C
 Purpose: 
 Written by: 
 Comments:
******************************************************************************/
#ifndef lint
static char yysccsid[] = "@(#)yaccpar	1.8 (Berkeley) 01/20/90";
#endif
#define YYBYACC 1
#line 2 "ipf\\ipf.y"
#include "ipf.h"
#include "ipf_tag.h"
#line 5 "ipf\\ipf.y"
typedef union  {
		int	num;
		LITERAL	lit;
		NAME	name;
	} YYSTYPE;
#line 15 "ipf_tab.c"
#define IPF_START_TAG_BEGIN 257
#define IPF_END_TAG_BEGIN 258
#define IPF_TAG_END 259
#define IPF_TAG_TERMINATE 260
#define IPF_STRING 261
#define IPF_ERROR 262
#define IPF_LITERAL 263
#define IPF_ATT 264
#define IPF_NUMERIC 265
#define EQ 266
#define YYERRCODE 256
short yylhs[] = {                                        -1,
    0,    0,    1,    1,    2,    2,    2,    4,    4,    5,
    6,   10,    8,    9,    3,    7,    7,   11,   11,   11,
   11,   11,
};
short yylen[] = {                                         2,
    0,    2,    1,    1,    1,    1,    2,    3,    3,    3,
    1,    1,    1,    1,    1,    0,    2,    3,    3,    3,
    1,    1,
};
short yydefred[] = {                                      1,
    0,    0,   11,   12,   15,    2,    3,    4,    5,    6,
   16,    0,    7,    0,    0,   22,   13,   14,    0,    8,
    9,   17,   10,    0,   18,   19,   20,
};
short yydgoto[] = {                                       1,
    6,    7,    8,    9,   10,   11,   14,   20,   21,   12,
   22,
};
short yysindex[] = {                                      0,
 -245, -258,    0,    0,    0,    0,    0,    0,    0,    0,
    0, -257,    0, -256, -250,    0,    0,    0, -252,    0,
    0,    0,    0, -246,    0,    0,    0,
};
short yyrindex[] = {                                      0,
    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
    0,    0,    0,    0,    0,    0,    0,    0, -254,    0,
    0,    0,    0,    0,    0,    0,    0,
};
short yygindex[] = {                                      0,
    0,    0,    0,    0,    0,    0,    0,    5,    0,    0,
    0,
};
#define YYTABLESIZE 20
short yytable[] = {                                      16,
   13,   21,   17,   18,   21,   21,   15,   19,   17,   21,
    2,    3,    4,   24,    0,    5,   25,   26,   27,   23,
};
short yycheck[] = {                                     256,
  259,  256,  259,  260,  259,  260,  264,  264,  259,  264,
  256,  257,  258,  266,   -1,  261,  263,  264,  265,   15,
};
#define YYFINAL 1
#ifndef YYDEBUG
#define YYDEBUG 0
#endif
#define YYMAXTOKEN 266
#if YYDEBUG
char *yyname[] = {
"end-of-file",0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,"IPF_START_TAG_BEGIN",
"IPF_END_TAG_BEGIN","IPF_TAG_END","IPF_TAG_TERMINATE","IPF_STRING","IPF_ERROR",
"IPF_LITERAL","IPF_ATT","IPF_NUMERIC","EQ",
};
char *yyrule[] = {
"$accept : doc",
"doc :",
"doc : doc tok",
"tok : tag",
"tok : plain",
"tag : start_tag",
"tag : end_tag",
"tag : error IPF_TAG_END",
"start_tag : start_tag_begin attlist tag_end",
"start_tag : start_tag_begin attlist term_tag",
"end_tag : end_tag_begin IPF_ATT tag_end",
"start_tag_begin : IPF_START_TAG_BEGIN",
"end_tag_begin : IPF_END_TAG_BEGIN",
"tag_end : IPF_TAG_END",
"term_tag : IPF_TAG_TERMINATE",
"plain : IPF_STRING",
"attlist :",
"attlist : attlist attrib",
"attrib : IPF_ATT EQ IPF_LITERAL",
"attrib : IPF_ATT EQ IPF_ATT",
"attrib : IPF_ATT EQ IPF_NUMERIC",
"attrib : IPF_ATT",
"attrib : error",
};
#endif
#define yyclearin (yychar=(-1))
#define yyerrok (yyerrflag=0)
#ifdef YYSTACKSIZE
#ifndef YYMAXDEPTH
#define YYMAXDEPTH YYSTACKSIZE
#endif
#else
#ifdef YYMAXDEPTH
#define YYSTACKSIZE YYMAXDEPTH
#else
#define YYSTACKSIZE 500
#define YYMAXDEPTH 500
#endif
#endif
int yydebug;
int yynerrs;
int yyerrflag;
int yychar;
short *yyssp;
YYSTYPE *yyvsp;
YYSTYPE yyval;
YYSTYPE yylval;
short yyss[YYSTACKSIZE];
YYSTYPE yyvs[YYSTACKSIZE];
#define yystacksize YYSTACKSIZE
#define YYABORT goto yyabort
#define YYACCEPT goto yyaccept
#define YYERROR goto yyerrlab
int
yyparse()
{
    register int yym, yyn, yystate;
#if YYDEBUG
    register char *yys;
    extern char *getenv();

    if (yys = getenv("YYDEBUG"))
    {
        yyn = *yys;
        if (yyn >= '0' && yyn <= '9')
            yydebug = yyn - '0';
    }
#endif

    yynerrs = 0;
    yyerrflag = 0;
    yychar = (-1);

    yyssp = yyss;
    yyvsp = yyvs;
    *yyssp = yystate = 0;

yyloop:
    if (yyn = yydefred[yystate]) goto yyreduce;
    if (yychar < 0)
    {
        if ((yychar = yylex()) < 0) yychar = 0;
#if YYDEBUG
        if (yydebug)
        {
            yys = 0;
            if (yychar <= YYMAXTOKEN) yys = yyname[yychar];
            if (!yys) yys = "illegal-symbol";
            printf("yydebug: state %d, reading %d (%s)\n", yystate,
                    yychar, yys);
        }
#endif
    }
    if ((yyn = yysindex[yystate]) && (yyn += yychar) >= 0 &&
            yyn <= YYTABLESIZE && yycheck[yyn] == yychar)
    {
#if YYDEBUG
        if (yydebug)
            printf("yydebug: state %d, shifting to state %d\n",
                    yystate, yytable[yyn]);
#endif
        if (yyssp >= yyss + yystacksize - 1)
        {
            goto yyoverflow;
        }
        *++yyssp = yystate = yytable[yyn];
        *++yyvsp = yylval;
        yychar = (-1);
        if (yyerrflag > 0)  --yyerrflag;
        goto yyloop;
    }
    if ((yyn = yyrindex[yystate]) && (yyn += yychar) >= 0 &&
            yyn <= YYTABLESIZE && yycheck[yyn] == yychar)
    {
        yyn = yytable[yyn];
        goto yyreduce;
    }
    if (yyerrflag) goto yyinrecovery;
#ifdef lint
    goto yynewerror;
#endif
yynewerror:
    yyerror("syntax error");
#ifdef lint
    goto yyerrlab;
#endif
yyerrlab:
    ++yynerrs;
yyinrecovery:
    if (yyerrflag < 3)
    {
        yyerrflag = 3;
        for (;;)
        {
            if ((yyn = yysindex[*yyssp]) && (yyn += YYERRCODE) >= 0 &&
                    yyn <= YYTABLESIZE && yycheck[yyn] == YYERRCODE)
            {
#if YYDEBUG
                if (yydebug)
                    printf("yydebug: state %d, error recovery shifting\
 to state %d\n", *yyssp, yytable[yyn]);
#endif
                if (yyssp >= yyss + yystacksize - 1)
                {
                    goto yyoverflow;
                }
                *++yyssp = yystate = yytable[yyn];
                *++yyvsp = yylval;
                goto yyloop;
            }
            else
            {
#if YYDEBUG
                if (yydebug)
                    printf("yydebug: error recovery discarding state %d\n",
                            *yyssp);
#endif
                if (yyssp <= yyss) goto yyabort;
                --yyssp;
                --yyvsp;
            }
        }
    }
    else
    {
        if (yychar == 0) goto yyabort;
#if YYDEBUG
        if (yydebug)
        {
            yys = 0;
            if (yychar <= YYMAXTOKEN) yys = yyname[yychar];
            if (!yys) yys = "illegal-symbol";
            printf("yydebug: state %d, error recovery discards token %d (%s)\n",
                    yystate, yychar, yys);
        }
#endif
        yychar = (-1);
        goto yyloop;
    }
yyreduce:
#if YYDEBUG
    if (yydebug)
        printf("yydebug: state %d, reducing by rule %d (%s)\n",
                yystate, yyn, yyrule[yyn]);
#endif
    yym = yylen[yyn];
    yyval = yyvsp[1-yym];
    switch (yyn)
    {
case 8:
#line 32 "ipf\\ipf.y"
{
		ipf_BeginTag ();
	}
break;
case 10:
#line 38 "ipf\\ipf.y"
{
		ipf_EndTag (yyvsp[-1].name);
	}
break;
case 11:
#line 43 "ipf\\ipf.y"
{
		ipf_ClearTag ();
	}
break;
case 15:
#line 54 "ipf\\ipf.y"
{
		ipf_AddPlainText (yytext);
	}
break;
case 18:
#line 62 "ipf\\ipf.y"
{
			ipf_AddAttribute (yyvsp[-2].name,attval_lit,yyvsp[0].lit,0);
		}
break;
case 19:
#line 66 "ipf\\ipf.y"
{
			ipf_AddAttribute (yyvsp[-2].name,attval_atom,yyvsp[0].name,0);
		}
break;
case 20:
#line 70 "ipf\\ipf.y"
{
			ipf_AddAttribute (yyvsp[-2].name,attval_num,"",yyvsp[0].num);
		}
break;
case 21:
#line 74 "ipf\\ipf.y"
{
			ipf_AddAttribute (yyvsp[0].name,attval_nill,"",0);
		}
break;
#line 324 "ipf_tab.c"
    }
    yyssp -= yym;
    yystate = *yyssp;
    yyvsp -= yym;
    yym = yylhs[yyn];
    if (yystate == 0 && yym == 0)
    {
#if YYDEBUG
        if (yydebug)
            printf("yydebug: after reduction, shifting from state 0 to\
 state %d\n", YYFINAL);
#endif
        yystate = YYFINAL;
        *++yyssp = YYFINAL;
        *++yyvsp = yyval;
        if (yychar < 0)
        {
            if ((yychar = yylex()) < 0) yychar = 0;
#if YYDEBUG
            if (yydebug)
            {
                yys = 0;
                if (yychar <= YYMAXTOKEN) yys = yyname[yychar];
                if (!yys) yys = "illegal-symbol";
                printf("yydebug: state %d, reading %d (%s)\n",
                        YYFINAL, yychar, yys);
            }
#endif
        }
        if (yychar == 0) goto yyaccept;
        goto yyloop;
    }
    if ((yyn = yygindex[yym]) && (yyn += yystate) >= 0 &&
            yyn <= YYTABLESIZE && yycheck[yyn] == yystate)
        yystate = yytable[yyn];
    else
        yystate = yydgoto[yym];
#if YYDEBUG
    if (yydebug)
        printf("yydebug: after reduction, shifting from state %d \
to state %d\n", *yyssp, yystate);
#endif
    if (yyssp >= yyss + yystacksize - 1)
    {
        goto yyoverflow;
    }
    *++yyssp = yystate;
    *++yyvsp = yyval;
    goto yyloop;
yyoverflow:
    yyerror("yacc stack overflow");
yyabort:
    return (1);
yyaccept:
    return (0);
}
