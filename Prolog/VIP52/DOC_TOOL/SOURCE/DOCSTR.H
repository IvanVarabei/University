/*****************************************************************************

		Copyright (c) 1984 - 1999 Prolog Development Center A/S

 Project:  DOCCNV
 FileName: DOCSTR.H
 Purpose: 
 Written by: 
 Comments:
******************************************************************************/
#define strucDoc_Dom_Included	1


#define VARFNO		0
#define CONSTFNO	1
#define LISTFNO		1
#define NILLFNO		2
typedef int INTEGER;
typedef char* STRING;
typedef unsigned char BYTE;


typedef STRING	DOCTYPE;

typedef BYTE	BOOL;

typedef enum {
	doc_unbound=0,
	doc_doc
} DOC_FNO;

typedef
  struct doc_struct {
	unsigned char fno;
	DOCTYPE Doctype;
	struct head_struct *Head;
	struct body_struct *Body;
  } DOC;

typedef
  struct head_struct {
	unsigned char fno;
	struct headelem_struct *headelem;
	struct head_struct *next;
  } HEAD;

typedef enum {
	headelem_unbound=0,
	headelem_title,
	headelem_isindex,
	headelem_base,
	headelem_style,
	headelem_meta,
	headelem_link
} HEADELEM_FNO;

typedef
  struct headelem_struct {
	unsigned char fno;
	union {
		STRING title;
		struct attlist_struct *isindex;
		struct attlist_struct *base;
		struct {
			struct attlist_struct *Attlist;
			STRING txt;
		} style;
		struct attlist_struct *meta;
		struct attlist_struct *link;
	} u;
  } HEADELEM;

typedef
  struct attlist_struct {
	unsigned char fno;
	struct att_struct *att;
	struct attlist_struct *next;
  } ATTLIST;

typedef enum {
	att_unbound=0,
	att_att
} ATT_FNO;

typedef
  struct att_struct {
	unsigned char fno;
	STRING Name;
	struct attval_struct *Val;
  } ATT;

typedef enum {
	attval_unbound=0,
	attval_nill,
	attval_atom,
	attval_lit,
	attval_num
} ATTVAL_FNO;

typedef
  struct attval_struct {
	unsigned char fno;
	union {
		STRING atom;
		STRING lit;
		INTEGER num;
	} u;
  } ATTVAL;

typedef enum {
	body_unbound=0,
	body_body
} BODY_FNO;

typedef
  struct body_struct {
	unsigned char fno;
	ATTLIST *Attlist;
	struct flow_struct *Flow;
  } BODY;

typedef
  struct flow_struct {
	unsigned char fno;
	struct flow_element_struct *flow_element;
	struct flow_struct *next;
  } FLOW;

typedef enum {
	flow_element_unbound=0,
	flow_element_div,
	flow_element_span,
	flow_element_heading,
	flow_element_hr,
	flow_element_address,
	flow_element_script,
	flow_element_applet,
	flow_element_frameset,
	flow_element_noframes,
	flow_element_txt,
	flow_element_u,
	flow_element_b,
	flow_element_i,
	flow_element_tt,
	flow_element_s,
	flow_element_big,
	flow_element_small,
	flow_element_sub,
	flow_element_sup,
	flow_element_font,
	flow_element_em,
	flow_element_strong,
	flow_element_dfn,
	flow_element_code,
	flow_element_samp,
	flow_element_kbd,
	flow_element_var,
	flow_element_cite,
	flow_element_abbr,
	flow_element_acronym,
	flow_element_q,
	flow_element_br,
	flow_element_fn,
	flow_element_tab,
	flow_element_img,
	flow_element_a,
	flow_element_par,
	flow_element_ins,
	flow_element_del,
	flow_element_dl,
	flow_element_ol,
	flow_element_ul,
	flow_element_blockquote,
	flow_element_preformatted,
	flow_element_note,
	flow_element_table,
	flow_element_table4,
	flow_element_map,
	flow_element_form,
	flow_element_input,
	flow_element_select,
	flow_element_textarea,
	flow_element_tag
} FLOW_ELEMENT_FNO;

typedef
  struct flow_element_struct {
	unsigned char fno;
	union {
		struct {
			ATTLIST *Attlist;
			FLOW *Flow;
		} div;
		struct {
			ATTLIST *Attlist;
			FLOW *Flow;
		} span;
		struct {
			INTEGER head_level;
			ATTLIST *Attlist;
			FLOW *Flow;
		} heading;
		ATTLIST *hr;
		struct {
			ATTLIST *Attlist;
			FLOW *Flow;
		} address;
		struct {
			ATTLIST *Attlist;
			STRING txt;
		} script;
		struct {
			ATTLIST *Attlist;
			struct paramlist_struct *Paramlist;
			FLOW *Flow;
		} applet;
		struct {
			ATTLIST *Attlist;
			struct framelist_struct *Framelist;
			FLOW *Flow;
		} frameset;
		BOOL noframes;
		STRING txt;
		BOOL u;
		BOOL b;
		BOOL i;
		BOOL tt;
		BOOL s;
		BOOL big;
		BOOL small;
		BOOL sub;
		BOOL sup;
		struct {
			BOOL Bool;
			ATTLIST *Attlist;
		} font;
		BOOL em;
		BOOL strong;
		BOOL dfn;
		BOOL code;
		BOOL samp;
		BOOL kbd;
		BOOL var;
		BOOL cite;
		struct {
			ATTLIST *Attlist;
			FLOW *Flow;
		} fn;
		ATTLIST *tab;
		ATTLIST *img;
		struct {
			ATTLIST *Attlist;
			FLOW *Flow;
		} a;
		struct {
			ATTLIST *Attlist;
			FLOW *Flow;
		} par;
		struct {
			ATTLIST *Attlist;
			struct lh_struct *Lh;
			struct li_list_struct *Li_list;
		} dl;
		struct {
			ATTLIST *Attlist;
			struct lh_struct *Lh;
			struct li_list_struct *Li_list;
		} ol;
		struct {
			ATTLIST *Attlist;
			struct lh_struct *Lh;
			struct li_list_struct *Li_list;
		} ul;
		struct {
			ATTLIST *Attlist;
			FLOW *Flow;
		} blockquote;
		struct {
			ATTLIST *Attlist;
			FLOW *Flow;
		} preformatted;
		struct {
			ATTLIST *Attlist;
			FLOW *Flow;
		} note;
		struct {
			ATTLIST *Attlist;
			struct caption_struct *Caption;
			struct trow_list_struct *Trow_list;
		} table;
		struct {
			struct attlist_struct *Attlist;
			struct caption_struct *Caption;
			struct colgroup_list_struct *Colgroup_list;
			struct thead_list_struct *Thead_list;
			struct tfoot_list_struct *Tfoot_list;
			struct tbody_list_struct *Tbody_list;
		} table4;
		struct {
			ATTLIST *Attlist;
			struct area_list_struct *Area_list;
		} map;
		struct {
			ATTLIST *Attlist;
			FLOW *Flow;
		} form;
		ATTLIST *input;
		struct {
			ATTLIST *Attlist;
			struct option_list_struct *Option_list;
		} select;
		struct {
			ATTLIST *Attlist;
			STRING initial;
		} textarea;
		struct {
			STRING Name;
			BOOL Bool;
			ATTLIST *Attlist;
		} tag;
	} u;
  } FLOW_ELEMENT;

typedef
  struct paramlist_struct {
	unsigned char fno;
	struct param_struct *param;
	struct paramlist_struct *next;
  } PARAMLIST;

typedef enum {
	param_unbound=0,
	param_param
} PARAM_FNO;

typedef
  struct param_struct {
	unsigned char fno;
	ATTLIST *Attlist;
  } PARAM;

typedef
  struct framelist_struct {
	unsigned char fno;
	struct frame_struct *frame;
	struct framelist_struct *next;
  } FRAMELIST;

typedef enum {
	frame_unbound=0,
	frame_frame
} FRAME_FNO;

typedef
  struct frame_struct {
	unsigned char fno;
	ATTLIST *Attlist;
  } FRAME;

typedef enum {
	lh_unbound=0,
	lh_lh
} LH_FNO;

typedef
  struct lh_struct {
	unsigned char fno;
	ATTLIST *Attlist;
	FLOW *Flow;
  } LH;

typedef
  struct li_list_struct {
	unsigned char fno;
	struct li_struct *li;
	struct li_list_struct *next;
  } LI_LIST;

typedef enum {
	li_unbound=0,
	li_li,
	li_dt,
	li_dd
} LI_FNO;

typedef
  struct li_struct {
	unsigned char fno;
	union {
		struct {
			ATTLIST *Attlist;
			FLOW *Flow;
		} li;
		struct {
			ATTLIST *Attlist;
			FLOW *Flow;
		} dt;
		struct {
			ATTLIST *Attlist;
			FLOW *Flow;
		} dd;
	} u;
  } LI;

typedef enum {
	caption_unbound=0,
	caption_caption
} CAPTION_FNO;

typedef
  struct caption_struct {
	unsigned char fno;
	ATTLIST *Attlist;
	FLOW *Flow;
  } CAPTION;

typedef enum {
	colgroup_unbound=0,
	colgroup_colgroup
} COLGROUP_FNO;

typedef
  struct colgroup_struct {
	unsigned char fno;
	struct attlist_struct *Attlist;
	struct col_list_struct *Col_list;
  } COLGROUP;

typedef
  struct colgroup_list_struct {
	unsigned char fno;
	COLGROUP *colgroup;
	struct colgroup_list_struct *next;
  } COLGROUP_LIST;

typedef
  struct col_list_struct {
	unsigned char fno;
	struct col_struct *col;
	struct col_list_struct *next;
  } COL_LIST;

typedef enum {
	col_unbound=0,
	col_col
} COL_FNO;

typedef
  struct col_struct {
	unsigned char fno;
	struct attlist_struct *Attlist;
  } COL;

typedef enum {
	thead_unbound=0,
	thead_thead
} THEAD_FNO;

typedef
  struct thead_struct {
	unsigned char fno;
	struct attlist_struct *Attlist;
	struct trow_list_struct *Trow_list;
  } THEAD;

typedef enum {
	tfoot_unbound=0,
	tfoot_tfoot
} TFOOT_FNO;

typedef
  struct tfoot_struct {
	unsigned char fno;
	struct attlist_struct *Attlist;
	struct trow_list_struct *Trow_list;
  } TFOOT;

typedef enum {
	tbody_unbound=0,
	tbody_tbody
} TBODY_FNO;

typedef
  struct tbody_struct {
	unsigned char fno;
	struct attlist_struct *Attlist;
	struct trow_list_struct *Trow_list;
  } TBODY;

typedef
  struct thead_list_struct {
	unsigned char fno;
	THEAD *thead;
	struct thead_list_struct *next;
  } THEAD_LIST;

typedef
  struct tfoot_list_struct {
	unsigned char fno;
	TFOOT *tfoot;
	struct tfoot_list_struct *next;
  } TFOOT_LIST;

typedef
  struct tbody_list_struct {
	unsigned char fno;
	TBODY *tbody;
	struct tbody_list_struct *next;
  } TBODY_LIST;

typedef
  struct trow_list_struct {
	unsigned char fno;
	struct trow_struct *trow;
	struct trow_list_struct *next;
  } TROW_LIST;

typedef enum {
	trow_unbound=0,
	trow_trow
} TROW_FNO;

typedef
  struct trow_struct {
	unsigned char fno;
	ATTLIST *Attlist;
	struct cell_list_struct *Cell_list;
  } TROW;

typedef
  struct cell_list_struct {
	unsigned char fno;
	struct cell_struct *cell;
	struct cell_list_struct *next;
  } CELL_LIST;

typedef enum {
	cell_unbound=0,
	cell_th,
	cell_td
} CELL_FNO;

typedef
  struct cell_struct {
	unsigned char fno;
	union {
		struct {
			ATTLIST *Attlist;
			FLOW *Flow;
		} th;
		struct {
			ATTLIST *Attlist;
			FLOW *Flow;
		} td;
	} u;
  } CELL;

typedef
  struct area_list_struct {
	unsigned char fno;
	struct area_struct *area;
	struct area_list_struct *next;
  } AREA_LIST;

typedef enum {
	area_unbound=0,
	area_area
} AREA_FNO;

typedef
  struct area_struct {
	unsigned char fno;
	ATTLIST *Attlist;
  } AREA;

typedef
  struct option_list_struct {
	unsigned char fno;
	struct option_struct *option;
	struct option_list_struct *next;
  } OPTION_LIST;

typedef enum {
	option_unbound=0,
	option_option
} DOC_OPTION_FNO;

typedef
  struct option_struct {
	unsigned char fno;
	ATTLIST *Attlist;
	STRING item;
  } OPTION;

