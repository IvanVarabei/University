#ifndef lint
static char yysccsid[] = "@(#)yaccpar	1.8 (Berkeley) 01/20/90";
#endif
#define YYBYACC 1
#line 2 "html\\html.y"
#include "html.h"
#include "html_tag.h"
#line 5 "html\\html.y"
typedef union  {
		int     num;
		LITERAL lit;
		NAME    name;
	} YYSTYPE;
#line 15 "html_tab.c"
#define HTML_START_TAG_BEGIN 257
#define HTML_END_TAG_BEGIN 258
#define HTML_TAG_END 259
#define HTML_STRING 260
#define HTML_WHITESPACE 261
#define HTML_LITERAL 262
#define HTML_ATT 263
#define HTML_NUMERIC 264
#define HTML_PROLOG 265
#define EQ 266
#define YYERRCODE 256
short yylhs[] = {                                        -1,
    0,    1,    1,    3,    2,    2,    4,    4,    4,    5,
    5,    5,    5,    5,    7,    8,    9,   12,   11,    6,
    6,   10,   10,   13,   13,   13,   13,
};
short yylen[] = {                                         2,
    2,    0,    2,    1,    0,    2,    1,    1,    1,    1,
    1,    2,    1,    1,    3,    3,    1,    1,    1,    1,
    1,    0,    2,    3,    3,    3,    1,
};
short yydefred[] = {                                      2,
    0,    0,    4,    0,    3,    0,    0,    0,   20,   21,
    0,    6,    7,    8,   10,   11,   22,    0,   12,    0,
    0,   19,    0,   15,   23,   16,    0,   24,   25,   26,
};
short yydgoto[] = {                                       1,
    2,    4,    5,   12,   13,   14,   15,   16,   17,   20,
   24,   18,   25,
};
short yysindex[] = {                                      0,
    0, -265,    0, -254,    0, -249,    0,    0,    0,    0,
 -265,    0,    0,    0,    0,    0,    0, -246,    0, -251,
 -241,    0, -247,    0,    0,    0, -248,    0,    0,    0,
};
short yyrindex[] = {                                      0,
    0,   21,    0,    5,    0,    0,    1,   11,    0,    0,
   27,    0,    0,    0,    0,    0,    0,    0,    0,    0,
    0,    0, -250,    0,    0,    0,    0,    0,    0,    0,
};
short yygindex[] = {                                      0,
   16,    0,    0,    0,    0,    0,    0,    0,    0,    0,
    2,    0,    0,
};
#define YYTABLESIZE 288
short yytable[] = {                                       3,
   14,    6,    7,    8,    1,    9,   10,   22,   27,   19,
   13,   23,   27,   28,   29,   30,   21,   22,   27,   11,
    5,    0,   26,    0,    0,    0,    9,    0,    0,    0,
    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
    0,    0,    0,    0,    0,    0,   14,   14,   14,   17,
   14,   14,    0,   17,    0,   14,   13,   13,   13,    2,
   13,   13,    0,   18,    0,   13,    5,    5,    5,    0,
    5,    5,    9,    9,    9,    0,    9,    9,
};
short yycheck[] = {                                     265,
    0,  256,  257,  258,    0,  260,  261,  259,  259,  259,
    0,  263,  263,  262,  263,  264,  263,  259,  266,    4,
    0,   -1,   21,   -1,   -1,   -1,    0,   -1,   -1,   -1,
   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
   -1,   -1,   -1,   -1,   -1,   -1,  256,  257,  258,  259,
  260,  261,   -1,  263,   -1,  265,  256,  257,  258,  265,
  260,  261,   -1,  263,   -1,  265,  256,  257,  258,   -1,
  260,  261,  256,  257,  258,   -1,  260,  261,
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
0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,"HTML_START_TAG_BEGIN",
"HTML_END_TAG_BEGIN","HTML_TAG_END","HTML_STRING","HTML_WHITESPACE",
"HTML_LITERAL","HTML_ATT","HTML_NUMERIC","HTML_PROLOG","EQ",
};
char *yyrule[] = {
"$accept : doc",
"doc : prolog docbody",
"prolog :",
"prolog : prolog prolog_element",
"prolog_element : HTML_PROLOG",
"docbody :",
"docbody : docbody tok",
"tok : tag",
"tok : plain",
"tok : prolog",
"tag : start_tag",
"tag : end_tag",
"tag : error HTML_TAG_END",
"tag : HTML_END_TAG_BEGIN",
"tag : HTML_START_TAG_BEGIN",
"start_tag : start_tag_begin attlist tag_end",
"end_tag : end_tag_begin HTML_ATT tag_end",
"start_tag_begin : HTML_START_TAG_BEGIN",
"end_tag_begin : HTML_END_TAG_BEGIN",
"tag_end : HTML_TAG_END",
"plain : HTML_STRING",
"plain : HTML_WHITESPACE",
"attlist :",
"attlist : attlist attrib",
"attrib : HTML_ATT EQ HTML_LITERAL",
"attrib : HTML_ATT EQ HTML_ATT",
"attrib : HTML_ATT EQ HTML_NUMERIC",
"attrib : HTML_ATT",
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
case 4:
#line 28 "html\\html.y"
{
		AddDocProlog (yyvsp[0].lit);
	}
break;
case 14:
#line 41 "html\\html.y"
{
		yyerrok;
		yyclearin;
	}
break;
case 15:
#line 47 "html\\html.y"
{
		BeginTag ();
	}
break;
case 16:
#line 52 "html\\html.y"
{
		EndTag (yyvsp[-1].name);
	}
break;
case 17:
#line 57 "html\\html.y"
{
		ClearTag ();
	}
break;
case 20:
#line 66 "html\\html.y"
{
		AddPlainText (yytext);
	}
break;
case 21:
#line 71 "html\\html.y"
{
		AddWhiteSpace ();
	}
break;
case 24:
#line 79 "html\\html.y"
{
			AddAttribute (yyvsp[-2].name,attval_lit,yyvsp[0].lit,0);
		}
break;
case 25:
#line 83 "html\\html.y"
{
			AddAttribute (yyvsp[-2].name,attval_atom,yyvsp[0].name,0);
		}
break;
case 26:
#line 87 "html\\html.y"
{
			AddAttribute (yyvsp[-2].name,attval_num,"",yyvsp[0].num);
		}
break;
case 27:
#line 91 "html\\html.y"
{
			AddAttribute (yyvsp[0].name,attval_nill,"",0);
		}
break;
#line 402 "html_tab.c"
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
