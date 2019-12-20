;/***************************************************************************
;
;			   PDC Prolog
;
;
; FileName: TCINIT.ASM
; PURPOSE: Initiate execution of a PDC PROLOG program from TC
;
;
; description	Initializes memory manager and global prolog variables.
;               Used when PROLOG is linked together with TC and TC
;               defines the main program
;
; อออออออออออออออหออออออหออออออออออออออออออออออออออออออออออออออออออออออออออออ
;  Date Modified,บ By,  บ  Comments.
; อออออออออออออออฮออออออฮออออออออออออออออออออออออออออออออออออออออออออออออออออ
;                บ      บ
;***************************************************************************/


TITLE	INIT - Initiate execution of a PDC PROLOG program from TC
SUBTTL	Copyright 1987,91 by Prolog Development Center
NAME	TCINIT

;
;---------------------- Define C allocation routines --------------------------
;

extrn _MEM_Initialized: byte
extrn MEM_AllocHeap: far
extrn MEM_ReleaseHeap: far
extrn _MEM_Init: far
extrn _PTR_PtrDiff: far
extrn _MEM_MarkTemp: far
extrn _MEM_MarkGStack: far

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

public _coreleft
_coreleft proc far
	call	_MEM_MarkGStack
	push	dx
	push	ax
	call	_MEM_MarkTemp
	push	dx
	push	ax
	call	_PTR_PtrDiff
	add	sp,8
	ret
_coreleft endp


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
;public _calloc      Works OK in the TC library by calling malloc
;_calloc label far
public _allocmem
_allocmem label far
public null_ret

null_ret proc far
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

INIT_TEXT	ENDS


;
;--------------------------- DATA Group ------------------------------
;

_DATA	SEGMENT word PUBLIC 'DATA'
_DATA	ENDS

DGROUP	GROUP	_DATA


	END
