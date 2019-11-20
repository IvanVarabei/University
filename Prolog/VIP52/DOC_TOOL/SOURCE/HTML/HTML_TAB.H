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
typedef union  {
		int     num;
		LITERAL lit;
		NAME    name;
	} YYSTYPE;
extern YYSTYPE yylval;
