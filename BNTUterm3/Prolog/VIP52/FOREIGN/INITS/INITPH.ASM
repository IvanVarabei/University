;/******************************************************************************
;
;               Copyright (c) 1984 - 2000 Prolog Development Center A/S
;
;                            PDC PROLOG Upstart code
;
; ModuleName: INIT
; FileName: INITP.ASM
; PURPOSE: PHARLAP LIB start-up code.
; VERSION: defined(PHARLAP) && complib_version == LIB
;
; อออออออออออออออหออออออหออออออออออออออออออออออออออออออออออออออออออออออออออออ
;  Date Modified,บ By,  บ  Comments.
; อออออออออออออออฮออออออฮออออออออออออออออออออออออออออออออออออออออออออออออออออ
;                บ      บ
;******************************************************************************/

.286P

INITP SEGMENT byte PUBLIC 'CODE'
INITP ENDS

extrn	_PROLOG_Vars : dword ; Misc parameters transfered from prolog main module
extrn	_PROLOG_SymbolTable : dword ;Root of the prolog symbol table

PROSYMB SEGMENT para public 'PROSYMB'
PROSYMB ENDS

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

STK SEGMENT STACK 'STACK'
db 8192 dup (?)
STK ENDS


extrn	_PROLOG_ErrReport: far
extrn	_PROLOG_Goal: far
extrn	_RUN_Main: far

extrn   DOSEXIT: far


_DATA	SEGMENT word PUBLIC 'DATA'
__acrtused	dd	0
PUBLIC	__acrtused
_DATA	ENDS

CONST SEGMENT WORD PUBLIC 'CONST'
CONST ENDS

_BSS SEGMENT WORD PUBLIC 'BSS'
_BSS ENDS

DGROUP GROUP CONST,_BSS,_DATA


INITP segment byte public 'CODE'
assume ds:DGROUP,cs:INITP

INIT_Prolog proc far
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
	push	1			; This thread.
	push	ax			; No particular return code.
	call	DOSEXIT
INIT_Prolog endp

INITP ends

END  INIT_Prolog
