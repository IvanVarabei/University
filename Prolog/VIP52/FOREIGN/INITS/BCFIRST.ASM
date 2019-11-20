;/***************************************************************************
;
;			   PDC Prolog
;
;
; FileName: TCFIRST.ASM
; PURPOSE: FIRST - Layout of segments
;
; อออออออออออออออหออออออหออออออออออออออออออออออออออออออออออออออออออออออออออออ
;  Date Modified,บ By,  บ  Comments.
; อออออออออออออออฮออออออฮออออออออออออออออออออออออออออออออออออออออออออออออออออ
;                บ      บ
;***************************************************************************/


TITLE	FIRST - Layout of segments
SUBTTL	Copyright 1987,91 by Prolog Development Center
NAME	FIRST


;------------------------- PDC PROLOG Segments ---------------------------
;
; Must be first file during linking !
;
; The most important thing to look for when interfacing PDC Prolog and C
; is to check in the .MAP file that the "STACK" segment is the last in the
; list of segments. This is important because the stacksegment is expanded
; during upstart.
; 


INIT_TEXT	SEGMENT BYTE PUBLIC 'CODE'
INIT_TEXT	ENDS


; Array of module descriptors
public _PROLOG_ModTab
PROMOD	SEGMENT BYTE PUBLIC 'PROMOD'
_PROLOG_ModTab	label	byte
PROMOD	ENDS


; Prolog private datastructures
PROCONST SEGMENT WORD PUBLIC 'PROCONST'
PROCONST ENDS


; _Symbol table from .SYM file
PROSYMB	SEGMENT PARA PUBLIC 'PROSYMB'
PROSYMB	ENDS

	END
