;/***************************************************************************
;
;			   PDC Prolog
;
;		  Basic Runtime Support Functions
;
; FileName: MSCINIT.ASM
; PURPOSE: Initializes memory manager and global prolog variables.
;          Used when PROLOG is linked together with MC and MC defines
;          the main program
;
; อออออออออออออออหออออออหออออออออออออออออออออออออออออออออออออออออออออออออออออ
;  Date Modified,บ By,  บ  Comments.
; อออออออออออออออฮออออออฮออออออออออออออออออออออออออออออออออออออออออออออออออออ
;                บ      บ
;***************************************************************************/

TITLE	INIT - Initiate execution of a PROLOG program from MC
SUBTTL	Copyright 1987,92 by Prolog Development Center A/S
NAME	INIT

;
;---------------------- Define the code Segment ------------------------------
;

extrn _MEM_Initialized: byte
extrn MEM_AllocHeap: far
extrn MEM_ReleaseHeap: far
extrn _MEM_Init: far
extrn _MEM_MarkGStack: far
extrn _OS_Beep: far

DGROUP	GROUP	_DATA


INIT_TEXT	SEGMENT BYTE PUBLIC 'CODE'
assume cs:INIT_TEXT, ds:DGROUP

public _malloc
_malloc proc far
	push	bp
	mov	bp,sp
	cmp	_MEM_Initialized,0
	jne	init_ok
	call	_MEM_Init
init_ok:
	mov	ax,[bp+6]
	inc	ax
	inc	ax
	push	ax
	call	MEM_AllocHeap
	mov	es,dx
	mov	bx,ax
	mov	cx,[bp+6]
	mov	es:[bx],cx
	inc	ax
	inc	ax
	pop	bp
	ret
_malloc endp


public _free
_free proc far
	push	bp
	mov	bp,sp
	les	bx,[bp+6]
	dec	bx
	dec	bx
	push	es
	push	bx
	mov	ax,es:[bx]
	inc	ax
	inc	ax
	push	ax
	call	MEM_ReleaseHeap
	pop	bp
	ret
_free endp


public _realloc
_realloc label far
public _farcalloc
_farcalloc label far
public _farcoreleft
_farcoreleft label far
public _farmalloc
_farmalloc label far
public _farrealloc
_farrealloc label far
public _allocmem
_allocmem label far
public null_ret

null_ret proc far
	call far ptr _OS_Beep
	xor	ax,ax
	cwd
public _farfree
_farfree label far
	ret
null_ret endp


public _sbrk
_sbrk label far
public _brk
_brk label far
public _freemem
_freemem label far

public neg_ret
neg_ret proc far
	mov	ax,-1
	cwd
	ret
neg_ret endp


; Should never be called !!
public _INIT_Exit
_INIT_Exit proc far
	ret
_INIT_Exit endp


public	__turboFloat
__turboFloat:
	int	1
INIT_TEXT	ENDS

;
;------------------------- PC-PROLOG Segments ---------------------------
;

; Prolog private datastructures
PROCONST SEGMENT WORD PUBLIC 'PROCONST'
extrn	 _PROLOG_Vars : dword ; Misc parameters transfered from prolog main module
PROCONST ENDS



; _Symbol table from .SYM file
PROSYMB	SEGMENT PARA COMMON 'PROSYMB'
extrn	 _PROLOG_SymbolTable : dword ; Root of the prolog symbol table
PROSYMB	ENDS


;------------------------------------------------------------------------------
; Prepare the layout of an array of module descriptors
; one record is generated for each prolog module
;------------------------------------------------------------------------------

public _PROLOG_ModTab
PROMOD	SEGMENT BYTE PUBLIC 'PROMOD'
_PROLOG_ModTab	label	byte
PROMOD	ENDS

; The array of module descriptors will be ended with a zero
PROMODE	SEGMENT BYTE PUBLIC 'PROMOD'
	dd 0
PROMODE	ENDS


;
;--------------------------- DATA Segment ------------------------------
;

_DATA	SEGMENT word PUBLIC 'DATA'
_DATA	ENDS


	END
