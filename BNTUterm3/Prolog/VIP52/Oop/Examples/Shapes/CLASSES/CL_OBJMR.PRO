/*****************************************************************************

	       Copyright (c) 1984 - 2000 Prolog Development Center A/S

				Class  examples


 Project:  SHAPES
 FileName: CL_OBJMR.PRO
 Purpose: Example of Classes & Objects
 Written by: Compiler Group
 Comments:
******************************************************************************/

include "shapes.inc"

constants

  first_ident = 1

  win_left    = 10
  win_top     = 20
  win_right   = 150
  win_bottom  = 160
  win_delta   = 30

  shape_delta = 40
  shift_delta = 10

  stop_delay  = 1000

  ready_text  = "I am ready"
  stop_text   = "I am finished"

		/*********************/
		/*   ObjectManager   */
		/*********************/

implement ObjectManager
  predicates
    clean
    makeShape( Shape )

  static predicates
    procedure Win_Ident getNextIdent()

  facts - objwin_db
    determ objectwindow( Win )

  facts - screen_db
    determ scr_color( COLOR )
    determ scr_text( STRING )
    determ scr_title( STRING )
    determ scr_shape( Shape )

  static facts - winparms_db
    single coordinates( RCT )
    single identifier( Win_Ident )

  clauses
    coordinates( rct( win_left, win_top, win_right, win_bottom ) ).
    identifier( first_ident ).

  clauses
    getNextIdent( WIdent ) :-
	identifier( WIdent ), !,
	NextID = WIdent + 1,
	assert( identifier( NextID ) ).
    getNextIdent( first_ident ) :-
	dlg_Note( "FAIL: ObjectManager::getWinIdent()" ),
	assert( identifier( first_ident ) ).

  clauses
    new() :-
	NextID = getNextIdent(),
	format( Title, "Window %u", NextID ),
	coordinates( rct( CurLeft, CurTop, CurRight, CurBottom ) ),
	NextLeft = CurLeft + win_delta,
	NextTop = CurTop + win_delta,
	NextRight = CurRight + win_delta,
	NextBottom = CurBottom + win_delta,
	assert( coordinates( rct( NextLeft, NextTop, NextRight, NextBottom ) ) ),
	CurArea = rct( CurLeft, CurTop, CurRight, CurBottom ),
	ObjWin = Win::new( Title, CurArea, win_handler ),
	assert( objectwindow( ObjWin ) ),
	assert( scr_color( color_Green ), screen_db ),
	assert( scr_text( ready_text ), screen_db ),
	assert( scr_title( Title ), screen_db ).

    delete() :-
	retractall( _, screen_db ),
	objectwindow( ObjWin ), !,
	retractall( _, objwin_db ),
	ObjWin:delete().
    delete().

    update :-
	objectwindow( ObjWin ),
	scr_title( CurTitle ),		/* Title must always exist */
	ObjWin:setTitle( CurTitle ),
	scr_color( CurColor ),		/* Color must always exist */
	ObjWin:setColor( CurColor ),
	scr_shape( CurShape ),
	!,
	CurShape:draw( ObjWin ).
    update :-
	objectwindow( ObjWin ),
	scr_text( Text ), !,
	ObjWin:putString( Text ).

    destroy :-
	scr_shape( CurShape ), !,
	CurShape:delete,
	clean.
    destroy :-
	clean.

    getHandle( Wnd ) :-
	objectwindow( ObjWin ),
	Wnd = ObjWin:getHandle().

    newShape( s_line ) :-
	NewLine = Line::new(),
	makeShape( NewLine ).
    newShape( s_ellipse ) :-
	NewEllipse = Ellipse::new(),
	makeShape( NewEllipse ).
    newShape( s_rectangle ):-
	NewRectangle = Rectangle::new(),
	makeShape( NewRectangle ).

    shiftShape( m_left ) :-
	scr_shape( CurShape ),
	CurShape:x_move( - shift_delta ),
	objectwindow( ObjWin ),
	ObjWin:invalidate.
    shiftShape( m_right ) :-
	scr_shape( CurShape ),
	CurShape:x_move( shift_delta ),
	objectwindow( ObjWin ),
	ObjWin:invalidate.
    shiftShape( m_up ) :-
	scr_shape( CurShape ),
	CurShape:y_move( - shift_delta ),
	objectwindow( ObjWin ),
	ObjWin:invalidate.
    shiftShape( m_down ) :-
	scr_shape( CurShape ),
	CurShape:y_move( shift_delta ),
	objectwindow( ObjWin ),
	ObjWin:invalidate.

    clean :-
	scr_title( CurTitle ),
	retractall( _, screen_db ),
	assert( scr_color( color_Red ), screen_db ),
	assert( scr_text( stop_text ), screen_db ),
	assert( scr_title( CurTitle ), screen_db ),
	objectwindow( ObjWin ),
	ObjWin:invalidate,
	Wnd = ObjWin:getHandle(),
	timer_Set( Wnd, stop_delay ).

    makeShape( S ) :-
	objectwindow( ObjWin ),
	Area = ObjWin:getArea(),
	Area = rct( _, _, R, B ),
	Ysw = B - shape_delta,
	Xne = R - shape_delta,
	Psw = pnt( shape_delta, Ysw ),
	Pne = pnt( Xne, shape_delta ),
	S:create( Psw, Pne ),
	scr_title( CurTitle ),
	retractall( _, screen_db ),
	assert( scr_color( color_Cyan ), screen_db ),
	assert( scr_shape( S ), screen_db ),
	assert( scr_title( CurTitle ), screen_db ),
	ObjWin:invalidate.
endclass ObjectManager

