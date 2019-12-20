/*****************************************************************************

	       Copyright (c) 1984 - 2000 Prolog Development Center A/S

				Class  examples


 Project:  SHAPES
 FileName: CL_RECT.PRO
 Purpose: Example of Classes & Objects
 Written by: Compiler Group
 Comments:
******************************************************************************/

include "shapes.inc"

		/***********************/
		/*   Class Rectangle   */
		/***********************/

implement Rectangle
  clauses
    point_sw( pnt( 0, 0 ) ).
    point_ne( pnt( 0, 0 ) ).

  clauses
    create( Psw, Pne ):-
	assert( point_sw( Psw ) ),
	assert( point_ne( Pne ) ).

    draw( W ):-
	point_sw( pnt( Xsw, Ysw ) ),
	point_ne( pnt( Xne, Yne ) ),
	Rect = rct( Xsw, Yne, Xne, Ysw ),
	W:putRectangle( Rect ).

    x_move( Delta ) :-
	point_sw( Psw ),
	point_ne( Pne ),
	Psw = pnt( Xsw, Ysw ),
	Pne = pnt( Xne, Yne ),
	Xsw_n = Xsw + Delta,
	Xne_n = Xne + Delta,
	assert( point_sw( pnt( Xsw_n, Ysw ) ) ),
	assert( point_ne( pnt( Xne_n, Yne ) ) ).

    y_move( Delta ) :-
	point_sw( Psw ),
	point_ne( Pne ),
	Psw = pnt( Xsw, Ysw ),
	Pne = pnt( Xne, Yne ),
	Ysw_n = Ysw + Delta,
	Yne_n = Yne + Delta,
	assert( point_sw( pnt( Xsw, Ysw_n ) ) ),
	assert( point_ne( pnt( Xne, Yne_n ) ) ).
endclass Rectangle

