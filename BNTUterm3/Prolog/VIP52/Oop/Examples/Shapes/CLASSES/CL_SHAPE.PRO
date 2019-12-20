/*****************************************************************************

	       Copyright (c) 1984 - 2000 Prolog Development Center A/S

				Class  examples


 Project:  SHAPES
 FileName: CL_SHAPE.PRO
 Purpose: Example of Classes & Objects
 Written by: Compiler Group
 Comments:
******************************************************************************/

include "shapes.inc"

		/*******************/
		/*   Class Shape   */
		/*******************/

implement Shape
  clauses
    create( _, _ ).
    draw( _ ).
    x_move( _ ).
    y_move( _ ).
endclass Shape

