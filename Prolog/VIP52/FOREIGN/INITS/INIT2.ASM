;/******************************************************************************
;
;               Copyright (c) 1984 - 2000 Prolog Development Center A/S
;
;                            PDC PROLOG Upstart code
;
; ModuleName: INIT
; FileName: INIT2.ASM
; PURPOSE: OS2 LIB start-up code.
; VERSION: opsys == OS2 && memmodel == M80286 && complib_version == LIB
;
; อออออออออออออออหออออออหออออออออออออออออออออออออออออออออออออออออออออออออออออ
;  Date Modified,บ By,  บ  Comments.
; อออออออออออออออฮออออออฮออออออออออออออออออออออออออออออออออออออออออออออออออออ
;                บ      บ
;******************************************************************************/

.286P

INIT2 SEGMENT byte PUBLIC 'CODE'
INIT2 ENDS

extrn	_PROLOG_Vars : dword ; Misc parameters transfered from prolog main module
extrn	_PROLOG_SymbolTable : dword ;Root of the prolog symbol table

; Prepare the layout of an array of module descriptors
; one record is generated for each module
PROMOD	SEGMENT BYTE PUBLIC 'PROMOD'
PROLOG_ModTab	label	byte
PROMOD	ENDS

; The array of module descriptors will be ended with a zero
PROMODE	SEGMENT BYTE PUBLIC 'PROMOD'
	dd 0
PROMODE	ENDS

MODGROUP GROUP PROMOD,PROMODE

PROSYMB SEGMENT para public 'PROSYMB'
PROSYMB ENDS

STACKVARS SEGMENT word public 'STACK'
STACKVARS ENDS

STK SEGMENT STACK 'STACK'
db 2560 dup (?)
STK ENDS

INCL_DOSINFOSEG equ 1

include ..\os2incl\bsedos.inc

; Minimum stack for  a Prolog program. This *MUST BE* even and >= 9600
PMINSTACK equ 9600

_DATA	SEGMENT word PUBLIC 'DATA'
__ginfoseg	dw ?
__linfoseg	dw ?
stklen		dw 0FFFEH	; Stack len for main thread.
Thrd1Sem	dd 0		; Thrd1 waits for this one.
retcode		dw ?
SemName		db '\SEM\PSYS\MTD00000',0
SemNameEnd	= $-2
_DATA	ENDS

CONST SEGMENT WORD PUBLIC 'CONST'
CONST ENDS

_BSS SEGMENT WORD PUBLIC 'BSS'
_BSS ENDS

DGROUP GROUP CONST,_BSS,_DATA

; STACKVARS
;extrn	_INIT_endstackv: abs

extrn	_Thrd2StackSel: word

extrn	_PROLOG_ErrReport: far
extrn	_PROLOG_Goal: far
extrn	_RUN_Main: far

extrn   DOSALLOCSEG: far
extrn	DOSGETINFOSEG: far
extrn   DOSEXIT: far
extrn	DOSCREATESEM: far
extrn	DOSSEMSET: far
extrn	DOSSEMWAIT: far
extrn	DOSSEMCLEAR: far
extrn	DOSCREATETHREAD: far

;
; OS/2 has the following startup conventions:
; ------------------------------------------
;       CS:IP -> Initial entry specified in EXE header.
;       SS:SP -> Stack specified in EXE header.
;       DS    -> Data segment specified in EXE header.
;       AX    -> Environment segment
;       ES    =  Zero (0)
;       BX    =  Offset in the environment of the command line 
;       CX    =  Length of the data segment. (0=65536)
;       DX    =  STACKSIZE parameter from the EXE.
;       SI    =  HEAPSIZE parameter from the EXE.
;       DI    =  Module handle for the application executable.
;       BP    =  Zero (0)
;


INIT2 segment byte public 'CODE'
assume ds:DGROUP,cs:INIT2

AURORA_BOREALIS PROC NEAR		; See the light.
	cld
	push	ds
	push	offset DGROUP:__ginfoseg
	push	ds
	push	offset DGROUP:__linfoseg
	call	DOSGETINFOSEG
	or	ax,ax
	jz	infosegok
	jmp	InitFailed

infosegok:
	mov	ax,stklen
	and	al,0FEH			; Make requested stack size even.
	push	ax
	push	seg _Thrd2StackSel
	push	offset _Thrd2StackSel
	push	0			; Alloc flags: strictly non-sharing.
	call	DOSALLOCSEG
	or	ax,ax
	jz	stackallocok
	jmp	InitFailed

stackallocok:
	push	ds			; Keep ds on stack.
;	mov	ax,seg _Thrd2StackSel	; Segment for library/dll.
;	mov	es,ax
;	mov	es,es:[_Thrd2StackSel]
	push	STACKVARS
	pop	ds
;	mov	cx,_INIT_endstackv
;	shr	cx,1			; Probably < 256 bytes.
;	xor	si,si
;	xor	di,di			; Copy initialized stack-vars to
;	rep	movsw			; new stack segment.
	pop	es			; DS, kept over from above, into ES.

	mov	di,offset DGROUP:SemNameEnd
	std
	mov	ds,es:[__linfoseg]	; Now cat PID onto semname.
	mov	ax,ds:[lis_pidCurrent]
	push	es
	pop	ds			; Restore ds.
	mov	bx,10			; Divisor.

loopy:
	xor	dx,dx
	div	bx			; Result in AX, remainder in DX.
	xchg	ax,dx			; Result in DX, remainder in AX.
	add	al,'0'			; ASCII equivalent of remainder.
	stosb
	xchg	ax,dx
	or	ax,ax
	jnz	loopy
	cld

	push	0			; Private semaphore ownership.
	push	ds
	push	offset DGROUP:Thrd1Sem
	push	ds
	push	offset DGROUP:SemName
	call	DOSCREATESEM
	or	ax,ax
	jnz	InitFailed
	push	ds			; Set Thrd1Sem. This shouldn't be
	push	offset DGROUP:Thrd1Sem		; necessary, as system sems are to
	call	DOSSEMSET		; be set when created.

; Call DOSCREATETHREAD (pascal param convention)
; USHORT APIENTRY DOSCREATETHREAD(
;	PFNTHREAD,                      /* Starting Address for new thread */
;	PTID,                           /* Address to put new thread ID */
;	PBYTE);                         /* Address of stack for new thread */

	push	ax			; Stack temp for thread id.
	mov	ax,sp
	push	cs
	push	offset MainThread
	push	ss
	push	ax
	push	seg _Thrd2StackSel
	pop	es			; es == seg Thrd2StackSel.
	push	es:[_Thrd2StackSel]
	push	stklen
	call	DOSCREATETHREAD
	pop	cx			; Thread ID.
	or	ax,ax
	jnz	InitFailed

WaitSem:
	push	ds
	push	offset DGROUP:Thrd1Sem
	mov	ax,-1
	push	ax
	push	ax
	call	DOSSEMWAIT
	mov	ax,retcode

InitFailed:
	push	1			; All threads.
	push	ax			; Return code.
	call	DOSEXIT
	int	3			; What the hell is going on???

AURORA_BOREALIS endp


MainThread proc far
; Call
; UNSIGNED DLP RUN_Main(
;	void *runtimevars,
;	void *SymbolTable,
;	void (*goal)(void),
;	void (*ERR_Report)(UNSIGNED),
;	void *ModTab,
;	BOOL AllowReBoot,
;	BOOL kb,
;	BOOL scr )

	push	1
	push	1
	push	0
	push	seg PROLOG_ModTab
	push	offset PROLOG_ModTab
	push	seg _PROLOG_ErrReport
	push	offset _PROLOG_ErrReport
	push	seg _PROLOG_Goal
	push	offset _PROLOG_Goal
	push	seg _PROLOG_SymbolTable
	push	offset _PROLOG_SymbolTable
	push	seg _PROLOG_Vars
	push	offset _PROLOG_Vars
	call	_RUN_Main
	mov	retcode,ax
	push	ds
	push	offset DGROUP:Thrd1Sem
	call	DOSSEMCLEAR
	push	0			; This thread.
	push	retcode
	call	DOSEXIT
	int	3			; What the hell is going on???
MainThread endp

INIT2 ends

END  AURORA_BOREALIS
