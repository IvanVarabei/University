/*****************************************************************************

	       Copyright (c) 1984 - 2000 Prolog Development Center A/S

				Class  examples


 Project:  SHAPES
 FileName: CL_LINE.PRO
 Purpose: Example of Classes & Objects
 Written by: Compiler Group
 Comments:
******************************************************************************/

include "shapes.inc"

		/******************/
		/*   Class Line   */
		/******************/

implement Line
  facts
    single point_w( PNT )
    single point_e( PNT )

  clauses
    point_w( pnt( 0, 0 ) ).
    point_e( pnt( 0, 0 ) ).

  clauses
    create( Begin, End ):-
	assert( point_w( Begin ) ),
	assert( point_e( End ) ).

    draw( W ):-
	point_w( Pw ),
	point_e( Pe ),
	W:putLine( Pw, Pe ).

    x_move( Delta ) :-
	point_w( Psw ),
	point_e( Pne ),
	Psw = pnt( Xsw, Ysw ),
	Pne = pnt( Xne, Yne ),
	Xsw_n = Xsw + Delta,
	Xne_n = Xne + Delta,
	assert( point_w( pnt( Xsw_n, Ysw ) ) ),
	assert( point_e( pnt( Xne_n, Yne ) ) ).

    y_move( Delta ) :-
	point_w( Psw ),
	point_e( Pne ),
	Psw = pnt( Xsw, Ysw ),
	Pne = pnt( Xne, Yne ),
	Ysw_n = Ysw + Delta,
	Yne_n = Yne + Delta,
	assert( point_w( pnt( Xsw, Ysw_n ) ) ),
	assert( point_e( pnt( Xne, Yne_n ) ) ).
endclass Line

