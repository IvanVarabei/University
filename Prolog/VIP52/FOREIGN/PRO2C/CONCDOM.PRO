/*****************************************************************************

		Copyright (c) 1984 - 2000 Prolog Development Center A/S

 Project:  
 FileName: CONCDOM.PRO
 Purpose: 
 Written by: PDC
 Comments:
******************************************************************************/

GLOBAL DOMAINS
posdom = position(integer,integer) /* page, line */
poslist = posdom*
concelem = clm(string,integer,poslist) /* word, count, positions */
concordance = concelem*

GLOBAL PREDICATES
interface_conc(concordance) - (o) language C

 