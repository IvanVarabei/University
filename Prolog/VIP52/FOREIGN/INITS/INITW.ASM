;/******************************************************************************
;
;               Copyright (c) 1984 - 2000 Prolog Development Center A/S
;
;                         PDC PROLOG Windows Upstart code
;
; ModuleName: INIT
; FileName: INITW.ASM
; PURPOSE: Upstarts code for a PDC Prolog WINDOWS executable
; VERSION: false
;; VERSION: defined(WINDOWS) && complib_version == LIB
;
; อออออออออออออออหออออออหออออออออออออออออออออออออออออออออออออออออออออออออออออ
;  Date Modified,บ By,  บ  Comments.
; อออออออออออออออฮออออออฮออออออออออออออออออออออออออออออออออออออออออออออออออออ
;    01/08/95    บSPB064บ 950610.04: stack size
;    16/09/97    บSPB330บ R970618.01 main doesn't return code return
;                บ      บ
;******************************************************************************/

.286

TITLE	INIT - Initiate execution of a PDC PROLOG program
SUBTTL	Copyright 1987,90 by Prolog Development Center
NAME	INIT

;
;---------------------- Define the code Segment ------------------------------
;

INIT SEGMENT byte PUBLIC 'CODE'

	PUBLIC	FIDRQQ		; wait, esc
FIDRQQ	equ	05C32h

	PUBLIC	FIWRQQ		; nop, wait
FIWRQQ	equ	0A23Dh


public	__turboFloat
__turboFloat:
	int	1

INIT ENDS


;
;---------------------- Define the MODGROUP ----------------------------------
;

; Prepare the layout of an array of module descriptors
; one record is generated for each module
PROMOD	SEGMENT BYTE PUBLIC 'PROMOD'
public _PROLOG_ModTab
_PROLOG_ModTab	label	byte
PROMOD	ENDS

; The array of module descriptors will be ended with a zero
PROMODE	SEGMENT BYTE PUBLIC 'PROMOD'
	dd 0
PROMODE	ENDS

MODGROUP GROUP PROMOD,PROMODE


;
;---------------------- Define thePROSYMB Segment ----------------------------
;

PROSYMB SEGMENT para public 'PROSYMB'
PROSYMB ENDS


;
;---------------------- Define the STACK Segment ------------------------------
;

;STK SEGMENT STACK 'STACK'
;db 10000 dup (?)
;STK ENDS


;
;---------------------- Define the DATA Segment ------------------------------
;

_DATA SEGMENT WORD PUBLIC 'DATA'
CopyRight       db      'PDC Prolog - Copyright 1991 Prolog Development Center',0
_INIT_psp		dw	0

_INIT_hInstance		dw	0
_INIT_hPrev		dw	0
_INIT_pszCmdline	dw	0
_INIT_cmdShow		dw	0
_INIT_WinAllocFlag	dw	0	;to pass to GlobalAlloc (for DLL use)

_Stack_HGlobal		dw	0	;SPB064 HGLOBAL-value for new stack
winmain_rc		db	0       ;SPB330 winmain retcode


                ends

CONST SEGMENT WORD PUBLIC 'CONST'
CONST ENDS

_BSS SEGMENT WORD PUBLIC 'BSS'
_BSS ENDS

DGROUP GROUP _BSS,_DATA, CONST



;
;---------------------- Code ------------------------------
;
                ASSUME CS:INIT, DS:DGROUP

                public  __acrtused              ;satisfy MS for now
__acrtused      equ     0

__galloc_flags	equ	40h			;SPB064 GMEM_FIXED | GMEM_ZEROINIT
__galloc_size	equ	0FFF0h			;SPB064 Size = 64K - 16B
__delta		equ	100h                    ;SPB064
__newstack_sp	equ	__galloc_size - __delta	;SPB064 SP for new stack
__newstack_top	equ	__delta			;SPB064 Offset of new stack's top
__sp_shift	equ	8			;SPB064

extrn           WINMAIN:far
extrn           INITAPP:far
extrn           INITTASK:far
extrn           FATALEXIT:far
extrn           WAITEVENT:far
extrn           LOCKSEGMENT:far
extrn           UNLOCKSEGMENT:far
extrn           GETWINFLAGS:far
extrn           GLOBALALLOC:far		;SPB064
extrn           GLOBALFREE:far		;SPB064
extrn           GLOBALLOCK:far		;SPB064
extrn           GLOBALUNLOCK:far	;SPB064
extrn           SWITCHSTACKTO:far
extrn           SWITCHSTACKBACK:far

INIT           segment

PROLOG_Start            proc near

;Windows initialization.  Sets up registers and stack.
                ;INITTASK returns:
                ;  'Failure:
                ;    AX = zero if it failed
                ;  Success:
                ;    AX = 1
                ;    CX = stack limit
                ;    DX = cmdShow parameter to CreateWindow
                ;    ES:BX = -> DOS format command line (ES = PSP address)
                ;    SI = hPrevinstance
                ;    DI = hinstance
                call    INITTASK
                or      ax,ax
                jnz     OK
                jmp     exit
OK:             mov     _INIT_psp,es
                mov     word ptr _INIT_pszCmdline,bx
                mov     _INIT_hPrev,si
                mov     _INIT_hInstance,di
                mov     _INIT_cmdShow,dx

;Init the Windows App
                xor     ax,ax
                push    ax
                call    WAITEVENT
                push    _INIT_hInstance
                call    INITAPP
                or      ax,ax
                jnz     InitOK
                jmp     exit
InitOK:

;Determine whether we are in protected mode
                call    GETWINFLAGS
                test    ax,1
                jz      exit

;SPB064 begin
;Allocate global memory for new stack
		push	__galloc_flags
		push	0
		push	__galloc_size
		call	GLOBALALLOC	;AX = HGLOBAL / 0 (fail)
		test	ax,ax
		jz	exit
		mov	_Stack_HGlobal,ax

;Lock new memory block
		push	ax
		call	GLOBALLOCK	;DX:AX = ptr / 0 (fail)
		mov	bx,dx
		or	bx,ax
		jz	Free_GMem

;Set new stack for task
		push	bp
		mov	bp,sp		;Modify for stack's copying
		sub	sp,__sp_shift
		push    dx		;Address of segment
		push	__newstack_sp	;New SP
		add	ax,__newstack_top
		push    ax		;New stack's top
		call	SWITCHSTACKTO
;SPB064 end

;Set up and call WinMain
                push    _INIT_hInstance
                push    _INIT_hPrev
                push    _INIT_psp
                push    word ptr _INIT_pszCmdline
                push    _INIT_cmdShow
                call    WINMAIN
		mov	winmain_rc, al	;SPB330

;SPB064 begin
;Return previous stack
		call	SWITCHSTACKBACK
		add	sp,__sp_shift
		pop	bp

;Unlock new memory block
		push	_Stack_HGlobal
		call	GLOBALUNLOCK

;Free global memory for stack
Free_GMem:
		push	_Stack_HGlobal
		call	GLOBALFREE
;SPB064 end

; Terminate application
exit:
		mov	al, winmain_rc	;SPB330
                mov     ah,4ch
                int     21h
                endp

                ends

                end PROLOG_Start
