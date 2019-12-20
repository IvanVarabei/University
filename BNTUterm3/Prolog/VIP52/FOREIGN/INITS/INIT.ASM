;/******************************************************************************
;
;               Copyright (c) 1984 - 2000 Prolog Development Center A/S
;
;                            PDC PROLOG Upstart code
;
; ModuleName: INIT
; FileName: INIT.ASM
; PURPOSE: Upstarts code for a PDC Prolog DOS .EXE file
; VERSION: memmodel == M8086 && complib_version == LIB
;
; อออออออออออออออหออออออหออออออออออออออออออออออออออออออออออออออออออออออออออออ
;  Date Modified,บ By,  บ  Comments.
; อออออออออออออออฮออออออฮออออออออออออออออออออออออออออออออออออออออออออออออออออ
;                บ      บ
;******************************************************************************/

TITLE	INIT - Initiate execution of a PDC PROLOG program
SUBTTL	Copyright 1987,90 by Prolog Development Center
NAME	INIT

;
;---------------------- Define the code Segment ------------------------------
;

INIT	SEGMENT BYTE PUBLIC 'CODE'
INIT	ENDS

;
;------------------------- PDC-PROLOG Segments ---------------------------
;

; _Symbol table from .SYM file
PROSYMB	SEGMENT PARA PUBLIC 'PROSYMB'
PROSYMB	ENDS


; Prolog private datastructures
PROCONST SEGMENT WORD PUBLIC 'PROCONST'
PROCONST ENDS

; Used under OS/2 and Unix for a layout of an array of module descriptors
PROMOD	SEGMENT BYTE PUBLIC 'PROMOD'
PROMOD	ENDS

LDA	SEGMENT word PUBLIC 'LDA'
LDA	ENDS

;
;--------------------------- DATA Segment ------------------------------
;

_DATA	SEGMENT word PUBLIC 'DATA'
_DATA	ENDS

BSS	SEGMENT word PUBLIC 'BSS'
BSS	ENDS

ENDBSS SEGMENT BYTE PUBLIC 'ENDBSS'
ENDBSS ENDS

_BSS	SEGMENT WORD PUBLIC 'BSS'
_BSS	ENDS

_BSSEND SEGMENT BYTE PUBLIC 'BSSEND'
_BSSEND ENDS

CONST SEGMENT BYTE PUBLIC 'CONST'
CONST ENDS


DGROUP	GROUP	_DATA,_BSS,_BSSEND, ENDBSS


;
;----------------FINALLY !! Prolog initialization ---------------------
;

extrn	_RUN_Main	    : far   ;Main routine in runinit

extrn	_PROLOG_Vars	    : dword ;Misc parameters transfered from prolog main module
extrn	_PROLOG_SymbolTable : dword ;Root of the prolog symbol table
extrn	_PROLOG_Goal	    : far   ;Main routine in prolog program
extrn	_PROLOG_ErrReport   : far   ;Error report routine exported by prolog
				    ;calls corresponding errorlevel routine


INIT	SEGMENT BYTE PUBLIC 'CODE'
	ASSUME	CS:INIT
	ASSUME	DS:DGROUP

	PUBLIC	FIDRQQ		; wait, esc
FIDRQQ	equ	05C32h

	PUBLIC	FIWRQQ		; nop, wait
FIWRQQ	equ	0A23Dh


public	__turboFloat
__turboFloat:
	int	1

	
;	PUBLIC	INIT_Prolog
INIT_Prolog	PROC	FAR

; set ds base
	MOV	AX,DGROUP
	MOV	DS,AX

	MOV	SI,ES

; Allocate stack dynamic
	mov	bx,seg _PROLOG_Vars
	mov	es,bx
	mov	bx,offset _PROLOG_Vars

	mov	dx,word ptr es:[bx]
	MOV	ES,SI

; Readjust size of memory to actual used top=SS:SP
	mov	cx,4
	mov	bx,dx
	shr	bx,cl
	mov	ax,ss
	add	bx,ax		; Now BX=paragraf(SS:SP)

	mov	ax,es		; Subtract start of mem
	sub	bx,ax
        inc	bx
        mov     ah, 04Ah
	int	21H

	jnc	cont1
	mov	al,1		; Exit with errorlevel 1 if too little memory
	mov	ah,4CH
	int	21H

cont1:
	mov	sp,dx


; Call RUN_Main
	mov	ax,1
	push	ax		; Init screen
	push	ax		; Init KB
	push	ax		; Allow reboot from normal prolog programs

	xor	ax,ax
	push	ax		; Dummy modtab under DOS
	push	ax

	mov	ax, seg _PROLOG_ErrReport
	push	ax
	mov	ax, offset _PROLOG_ErrReport
	push	ax

	mov	ax, seg _PROLOG_Goal
	push	ax
	mov	ax, offset _PROLOG_Goal
	push	ax

	mov	ax, seg _PROLOG_SymbolTable
	push	ax
	mov	ax, offset _PROLOG_SymbolTable
	push	ax

	mov	ax, seg _PROLOG_Vars
	push	ax
	mov	ax, offset _PROLOG_Vars
	push	ax

	call	far ptr _RUN_Main	; Will never exit

INIT_Prolog	endp



	PUBLIC	_INIT_Exit
_INIT_Exit	PROC	FAR

;	exitcode  : 4-5
;	retur	  : 0-3
	mov	bp,sp
	mov	ax,4[bp]		;ax = noofbytes

	mov	ah,4CH	; Return Errorlevel to DOS
	int	21H
_INIT_Exit	endp


INIT	ENDS



;
;--------------------------- Stack segment ------------------------------
;

STK	SEGMENT STACK 'STACK'

	DB	"Copyright (c) 1984 - 2000 Prolog Development Center A/S 1992 by Prolog Development Center"

	DB	80 dup(0)

EVEN
STK	ENDS

	END	INIT_Prolog
