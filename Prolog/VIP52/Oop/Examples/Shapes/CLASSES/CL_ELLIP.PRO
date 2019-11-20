/*****************************************************************************

	      Copyright (c) 1984 - 2000 Prolog Development Center A/S

				Class  examples


 Project:  SHAPES
 FileName: CL_ELLIP.PRO
 Purpose: Example of Classes & Objects
 Written by: Compiler Group
 Comments:
******************************************************************************/

include "shapes.inc"

		/*********************/
		/*   Class Ellipse   */
		/*********************/

implement Ellipse
  clauses
    draw( W ):-
	point_sw( pnt( Xsw, Ysw ) ),
	point_ne( pnt( Xne, Yne ) ),
	Rect = rct( Xsw, Yne, Xne, Ysw ),
	W:putEllipse( Rect ).
endclass Ellipse

