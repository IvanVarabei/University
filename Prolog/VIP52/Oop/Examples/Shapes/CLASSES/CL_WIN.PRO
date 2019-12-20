/*****************************************************************************

	      Copyright (c) 1984 - 2000 Prolog Development Center A/S

				Class  examples


 Project:  SHAPES
 FileName: CL_WIN.PRO
 Purpose: Example of Classes & Objects
 Written by: Compiler Group
 Comments:
******************************************************************************/

include "shapes.inc"

		/*****************/
		/*   Class Win   */
		/*****************/

implement Win
  facts
    single handle( WINDOW )

  clauses
    handle( ~0 ).

  clauses
    new( Title, Area, Ehandler ):-
	WinType = w_TopLevel,
	NullWin = cast( WINDOW, 0 ),
	ParentTmp = win_GetAttrVal( NullWin, attr_task_window ),
	Parent = cast( WINDOW, ParentTmp ),
	Flags = [wsf_Minimize,wsf_Maximize,wsf_TitleBar,wsf_Close],
	Wnd = win_Create(WinType,Area,Title,no_menu,Parent,Flags,Ehandler,0),
	assert( handle( Wnd ) ).

    delete() :-
	W = getHandle(), !,
	win_Destroy( W ).
    delete().	

    invalidate :-
	W = getHandle(),
	R = getArea(),
	win_SendEvent( W, e_Update( R ) ).

    getHandle( Wnd ):-
	handle( Wnd ).

    getArea( Rct ):-
	W = getHandle(),
	Rct = win_GetClientRect( W ).

    setTitle( Title ):-
	W = getHandle(),
	win_SetText( W, Title ).

    setColor( Color ):-
	W = getHandle(),
	win_SetBackColor( W, Color ),
	win_Clear( W, Color ).

    putString( Str ):-
	W = getHandle(),
	Rct = win_GetClientRect( W ),
	Flags = [dtext_singleline,dtext_center,dtext_vcenter],
   	draw_TextInRect( W, Rct, Str, -1, Flags ).

    putLine( Begin, End ):-
	W = getHandle(),
   	draw_Line( W, Begin, End ).

    putRectangle( Rct ):-
	W = getHandle(),
   	draw_Rect( W, Rct ).

    putEllipse( Rct ):-
	W = getHandle(),
   	draw_Ellipse( W, Rct ).
endclass Win

