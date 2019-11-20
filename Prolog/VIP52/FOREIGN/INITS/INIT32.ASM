;/******************************************************************************
;
;               Copyright (c) 1984 - 2000 Prolog Development Center A/S
;
;                            PDC PROLOG Upstart code
;
; ModuleName: INIT
; FileName: INIT32.ASM
; PURPOSE: start-up code for 32-bit application
; VERSION: (opsys == OS2 && memmodel == MLINEAR) && opsys = NT
; WRITEN BY : Compiler Croup
; อออออออออออออออหออออออหออออออออออออออออออออออออออออออออออออออออออออออออออออ
;  Date Modified,บ By,  บ  Comments.
; อออออออออออออออฮออออออฮออออออออออออออออออออออออออออออออออออออออออออออออออออ
;    09/09/97    บSPB000บ Inner : stackbase problem
;                บ      บ
;******************************************************************************/
  .386p

  IFDEF MSC
    UNDERSCORE equ 1
  ELSE
   UNDERSCORE  equ 0
  ENDIF

  ENDPROC MACRO   NAME
  IFDEF UNDERSCORES
    _&NAME  endp
  ELSE
    NAME    endp
  ENDIF
	ENDM

  PROCDST32 macro name
  name    proc near
	endm

  PROCDEF macro   name
    IFDEF UNDERSCORES
      public    _&name
      name  equ _&name
      PROCDST32 _&name
    ELSE
      public    name
      PROCDST32 name
    ENDIF
  	ENDM


  IFDEF WIN32
    STACK_PAGE_SIZE	 equ	1000h
    STARTF_USESHOWWINDOW equ	00000001h
    SW_SHOWDEFAULT	 equ	10
    DQUOTE		 equ	22h
    SPACE		 equ	20h
  ENDIF

  IFDEF OS32
    EXIT_PROCESS	 equ    1
  ENDIF

  IFDEF WIN32
   .model flat
  ENDIF

  IFDEF WIN32
    extern _ExitProcess@4:PROC
    extern _GetStartupInfoA@4:PROC
    extern _GetModuleHandleA@4:PROC
    extern _GetCommandLineA@0:PROC
  ENDIF

  IFDEF OS32
    EXTRN  DosExit:FAR
  ENDIF

  IFDEF PROLOG_EXE
    _DATA		SEGMENT PUBLIC DWORD USE32 'DATA'
      IFDEF OS32
        public	_exeentry
        public	_fltused
      ELSE
        public	__fltused
      ENDIF
       _fpu_cw	dw 222h	; IM = 0, DM=1, ZM=0, OM=0, UM=0, PM =1 ###
		    		; PC = 10, RC = 00
      IFDEF OS32
        _exeentry	dd 0
        _fltused	dd 0
      ELSE
       __fltused	dd 0
      ENDIF
      _end		dd 0
    _DATA		ENDS
  ENDIF

  ;  debug link ####
  IFDEF PROLOG_DLL
    public __fltused
    _DATA		SEGMENT PUBLIC DWORD USE32 'DATA'
      __fltused	dd 0
    _DATA		ENDS
  ENDIF

; ####

  ASSUME   CS: FLAT, DS: FLAT, SS: FLAT, ES: FLAT
  _TEXT		SEGMENT PUBLIC DWORD USE32 'CODE'
    IFDEF OS32
      IFDEF PROLOG_EXE
        EXTRN	main:NEAR
      ENDIF
    ELSE				; WIN32
      IFDEF PROLOG_EXE
        IFDEF VPI
          EXTRN _WinMain@16:NEAR
        ELSE
          EXTRN _main:NEAR
        ENDIF
      ENDIF
      IFDEF PROLOG_DLL
        EXTRN _DllMain@12:NEAR
      ENDIF
    ENDIF
  _TEXT		ENDS

  IFDEF OS32
    public _PROLOG_ModTab
    PROMOD  SEGMENT DWORD PUBLIC 'DATA'
      _PROLOG_ModTab  label   byte
    PROMOD  ENDS

    PROMODE SEGMENT DWORD PUBLIC 'DATA'
       dd 0
    PROMODE ENDS

    DGROUP GROUP PROMOD,PROMODE

    pgoal_CONST SEGMENT DWORD PUBLIC 'DATA'
    pgoal_CONST ENDS
    PROSYMB SEGMENT DWORD PUBLIC 'DATA'
    PROSYMB ENDS
    public _stkbase

;   SPB000 09/09/97  STACKDATA	SEGMENT PARA USE32 PUBLIC 'DATA'
;   SPB000 09/09/97  STACKDATA   ENDS
    STACKBASE	SEGMENT PARA USE32 PUBLIC 'STACK'
      _stkbase	dd	0
      db              01000h dup(0)
    STACKBASE       ENDS

    _STACK          SEGMENT PARA  USE32 PUBLIC 'STACK'
       db              0b000h dup (?)
    _STACK          ENDS

    IFDEF OS2_LINK 
      DGROUP GROUP pgoal_CONST,PROSYMB, STACKBASE, _STACK
    ENDIF
    IFDEF PDC_LINK
      DGROUP GROUP pgoal_CONST,PROSYMB		; SPB000 09/09/97
      STACK GROUP  STACKBASE, _STACK		; SPB000 09/09/97
    ENDIF

    IFDEF PROLOG_EXE
      _TEXT		SEGMENT PUBLIC DWORD USE32 'CODE'
        PROCDEF  PDCPrologStart
          push	ebp
          mov	ebp, esp
          fninit				; initialize  FPU
          fldcw	_fpu_cw			; load our fpu control word
          call	main
          pop	ebp
          push	EXIT_PROCESS			;Flag exit process
          push	eax				;return code
          call	DosExit
          ret
        ENDPROC PDCPrologStart
      _TEXT		ENDS
      END  PDCPrologStart
    ENDIF			; END IFDEF PROLOG_EXE
  ENDIF				; EMD IFDEF OS2_32

  IFDEF WIN32
    IFDEF PROLOG_EXE
      IFDEF VPI
        StartUpInfo	struct
          cb			DWORD	?    ;DWORD
	  lpReserved		DWORD	?    ;LPTSTR
	  lpDesktop		DWORD	?    ;LPTSTR
	  lpTitle		DWORD	?    ;LPTSTR
	  dwX			DWORD	?    ;DWORD
	  dwY			DWORD	?    ;DWORD
	  dwXSize		DWORD	?    ;DWORD
	  dwYSize		DWORD	?    ;DWORD
	  dwXCountChars		DWORD	?    ;DWORD
	  dwYCountChars		DWORD	?    ;DWORD
	  dwFillAttribute	DWORD	?    ;DWORD
	  dwFlags		DWORD	0    ;DWORD
	  wShowWindow		WORD	?    ;WORD
	  cbReserved2		WORD	?    ;WORD
	  lpReserved2		DWORD	?    ;LPBYTE
	  hStdInput		DWORD	?    ;HANDLE
	  hStdOutput		DWORD	?    ;HANDLE
	  hStdError		DWORD	?    ;HANDLE
        StartUpInfo ends

        _DATA SEGMENT DWORD USE32 PUBLIC 'DATA'
          startup_info		StartUpInfo	{}
        _DATA  ENDS
      ENDIF			; END IFDEF VPI
    ENDIF     			; END IFDEF PROLOG_EXE

    CONST   SEGMENT DWORD USE32 PUBLIC 'CONST'
    CONST   ENDS
    _BSS    SEGMENT DWORD USE32 PUBLIC 'BSS'
    _BSS    ENDS

    _DATA SEGMENT DWORD USE32 PUBLIC 'DATA'
      public _PROLOG_ModTab
      public _INIT_StartOfData
      _stklen			dd 10000
      _INIT_StartOfData	db 0
      _PROLOG_ModTab		dd 0
    _DATA  ENDS

    public endbyt
    PROMODE SEGMENT DWORD USE32 PUBLIC 'DATA'
      endbyt dd 0
    PROMODE ENDS
    FLAT_GROUP GROUP _DATA, PROMODE, CONST, _BSS	;SPB172

    _TEXT           SEGMENT PUBLIC DWORD USE32 'CODE'

      _chkstk PROC NEAR C
        push    edx
        cmp     eax, STACK_PAGE_SIZE
        lea     edx,[esp] + 8
        jb      short test_last_page
test_pages_loop:
        sub     edx, STACK_PAGE_SIZE
        sub     eax, STACK_PAGE_SIZE

        test    dword ptr [edx],eax

        cmp     eax, STACK_PAGE_SIZE
        jae     short test_pages_loop

test_last_page:
        sub     edx, eax
        mov     eax, esp

        test    dword ptr [edx], eax

        mov     esp, edx

        mov     edx, dword ptr [eax]
        mov     eax, dword ptr [eax + 4]

        push    eax

        ret

      _chkstk ENDP

      IFDEF PROLOG_EXE
        PROCDEF  _PDCPrologStart
          push	ebp
	  mov	ebp, esp
	  fninit			     	; initialize  FPU
	  fldcw	word ptr _fpu_cw		; load our fpu control word
	  IFDEF VPI
	    push OFFSET startup_info
	    call	_GetStartupInfoA@4
	    and		startup_info.dwFlags, STARTF_USESHOWWINDOW
	    jnz		push_from_st_info
	    push	SW_SHOWDEFAULT
	    jmp		push_next_param
push_from_st_info:
	    xor		eax, eax
	    mov		ax, startup_info.wShowWindow
	    push	eax
push_next_param:
	    call	_GetCommandLineA@0
	    cmp		byte ptr [ eax ], DQUOTE
	    je		search_next_dquote
search_space:
	    inc		eax
	    cmp		byte ptr [ eax ], SPACE
	    je		shift_comline
	    cmp		byte ptr [ eax ], 0
	    je		push_ptr_comline
	    jmp		search_space
search_next_dquote:
	    inc		eax
	    cmp		byte ptr [ eax ], DQUOTE
	    je		shift_comline
	    jmp		search_next_dquote
shift_comline:
	    inc		eax
	    cmp		byte ptr [ eax ], SPACE
	    ja		push_ptr_comline
	    jmp		shift_comline
push_ptr_comline:
	    push	eax
	    push	0
	    push	0
	    call	_GetModuleHandleA@4
	    push	eax
	    call	_WinMain@16
	  ELSE
	    call	_main
	  ENDIF				; END IFDEF VPI
	  pop		ebp
	  push		eax	       	;return code
 	  call		_ExitProcess@4
	  ret
        ENDPROC  _PDCPrologStart
      ENDIF				; ENDIF PROLOG_EXE
      IFDEF PROLOG_DLL
        PROCDEF _PDCPrologDLLStart@12
	  push	ebp
	  mov	ebp, esp
	  push	[ ebp + 16 ]
	  push	[ ebp + 12 ]
	  push  [ ebp + 8 ]
	  call	_DllMain@12
	  pop	ebp
	  ret	12
        ENDPROC _PDCPrologDLLStart@12
      ENDIF				; END IFDEF PROLOG_DLL
    _TEXT ENDS
    ENDIF				; END IFDEF WIN32
    END





