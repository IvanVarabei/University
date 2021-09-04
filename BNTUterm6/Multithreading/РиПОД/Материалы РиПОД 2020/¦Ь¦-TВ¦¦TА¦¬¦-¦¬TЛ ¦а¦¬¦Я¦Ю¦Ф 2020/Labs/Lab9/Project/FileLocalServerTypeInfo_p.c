

/* this ALWAYS GENERATED file contains the proxy stub code */


 /* File created by MIDL compiler version 7.00.0555 */
/* at Thu Dec 08 08:06:19 2011
 */
/* Compiler settings for FileLocalServerTypeInfo.IDL:
    Oicf, W1, Zp8, env=Win64 (32b run), target_arch=AMD64 7.00.0555 
    protocol : dce , ms_ext, c_ext, robust
    error checks: allocation ref bounds_check enum stub_data 
    VC __declspec() decoration level: 
         __declspec(uuid()), __declspec(selectany), __declspec(novtable)
         DECLSPEC_UUID(), MIDL_INTERFACE()
*/
/* @@MIDL_FILE_HEADING(  ) */

#if defined(_M_AMD64)


#pragma warning( disable: 4049 )  /* more than 64k source lines */
#if _MSC_VER >= 1200
#pragma warning(push)
#endif

#pragma warning( disable: 4211 )  /* redefine extern to static */
#pragma warning( disable: 4232 )  /* dllimport identity*/
#pragma warning( disable: 4024 )  /* array to pointer mapping*/
#pragma warning( disable: 4152 )  /* function/data pointer conversion in expression */

#define USE_STUBLESS_PROXY


/* verify that the <rpcproxy.h> version is high enough to compile this file*/
#ifndef __REDQ_RPCPROXY_H_VERSION__
#define __REQUIRED_RPCPROXY_H_VERSION__ 475
#endif


#include "rpcproxy.h"
#ifndef __RPCPROXY_H_VERSION__
#error this stub requires an updated version of <rpcproxy.h>
#endif /* __RPCPROXY_H_VERSION__ */


#include "FileLocalServerTypeInfo_h.h"

#define TYPE_FORMAT_STRING_SIZE   7                                 
#define PROC_FORMAT_STRING_SIZE   51                                
#define EXPR_FORMAT_STRING_SIZE   1                                 
#define TRANSMIT_AS_TABLE_SIZE    0            
#define WIRE_MARSHAL_TABLE_SIZE   0            

typedef struct _FileLocalServerTypeInfo_MIDL_TYPE_FORMAT_STRING
    {
    short          Pad;
    unsigned char  Format[ TYPE_FORMAT_STRING_SIZE ];
    } FileLocalServerTypeInfo_MIDL_TYPE_FORMAT_STRING;

typedef struct _FileLocalServerTypeInfo_MIDL_PROC_FORMAT_STRING
    {
    short          Pad;
    unsigned char  Format[ PROC_FORMAT_STRING_SIZE ];
    } FileLocalServerTypeInfo_MIDL_PROC_FORMAT_STRING;

typedef struct _FileLocalServerTypeInfo_MIDL_EXPR_FORMAT_STRING
    {
    long          Pad;
    unsigned char  Format[ EXPR_FORMAT_STRING_SIZE ];
    } FileLocalServerTypeInfo_MIDL_EXPR_FORMAT_STRING;


static const RPC_SYNTAX_IDENTIFIER  _RpcTransferSyntax = 
{{0x8A885D04,0x1CEB,0x11C9,{0x9F,0xE8,0x08,0x00,0x2B,0x10,0x48,0x60}},{2,0}};


extern const FileLocalServerTypeInfo_MIDL_TYPE_FORMAT_STRING FileLocalServerTypeInfo__MIDL_TypeFormatString;
extern const FileLocalServerTypeInfo_MIDL_PROC_FORMAT_STRING FileLocalServerTypeInfo__MIDL_ProcFormatString;
extern const FileLocalServerTypeInfo_MIDL_EXPR_FORMAT_STRING FileLocalServerTypeInfo__MIDL_ExprFormatString;


extern const MIDL_STUB_DESC Object_StubDesc;


extern const MIDL_SERVER_INFO IPlan_ServerInfo;
extern const MIDL_STUBLESS_PROXY_INFO IPlan_ProxyInfo;



#if !defined(__RPC_WIN64__)
#error  Invalid build platform for this stub.
#endif

static const FileLocalServerTypeInfo_MIDL_PROC_FORMAT_STRING FileLocalServerTypeInfo__MIDL_ProcFormatString =
    {
        0,
        {

	/* Procedure Summ */

			0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/*  2 */	NdrFcLong( 0x0 ),	/* 0 */
/*  6 */	NdrFcShort( 0x3 ),	/* 3 */
/*  8 */	NdrFcShort( 0x28 ),	/* X64 Stack size/offset = 40 */
/* 10 */	NdrFcShort( 0x10 ),	/* 16 */
/* 12 */	NdrFcShort( 0x24 ),	/* 36 */
/* 14 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x4,		/* 4 */
/* 16 */	0xa,		/* 10 */
			0x1,		/* Ext Flags:  new corr desc, */
/* 18 */	NdrFcShort( 0x0 ),	/* 0 */
/* 20 */	NdrFcShort( 0x0 ),	/* 0 */
/* 22 */	NdrFcShort( 0x0 ),	/* 0 */
/* 24 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter a */

/* 26 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 28 */	NdrFcShort( 0x8 ),	/* X64 Stack size/offset = 8 */
/* 30 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter b */

/* 32 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 34 */	NdrFcShort( 0x10 ),	/* X64 Stack size/offset = 16 */
/* 36 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter c */

/* 38 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
/* 40 */	NdrFcShort( 0x18 ),	/* X64 Stack size/offset = 24 */
/* 42 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 44 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 46 */	NdrFcShort( 0x20 ),	/* X64 Stack size/offset = 32 */
/* 48 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

			0x0
        }
    };

static const FileLocalServerTypeInfo_MIDL_TYPE_FORMAT_STRING FileLocalServerTypeInfo__MIDL_TypeFormatString =
    {
        0,
        {
			NdrFcShort( 0x0 ),	/* 0 */
/*  2 */	
			0x11, 0xc,	/* FC_RP [alloced_on_stack] [simple_pointer] */
/*  4 */	0x8,		/* FC_LONG */
			0x5c,		/* FC_PAD */

			0x0
        }
    };


/* Object interface: IUnknown, ver. 0.0,
   GUID={0x00000000,0x0000,0x0000,{0xC0,0x00,0x00,0x00,0x00,0x00,0x00,0x46}} */


/* Object interface: IPlan, ver. 0.0,
   GUID={0xFE78387F,0xD150,0x4089,{0x83,0x2C,0xBB,0xF0,0x24,0x02,0xC8,0x72}} */

#pragma code_seg(".orpc")
static const unsigned short IPlan_FormatStringOffsetTable[] =
    {
    0
    };

static const MIDL_STUBLESS_PROXY_INFO IPlan_ProxyInfo =
    {
    &Object_StubDesc,
    FileLocalServerTypeInfo__MIDL_ProcFormatString.Format,
    &IPlan_FormatStringOffsetTable[-3],
    0,
    0,
    0
    };


static const MIDL_SERVER_INFO IPlan_ServerInfo = 
    {
    &Object_StubDesc,
    0,
    FileLocalServerTypeInfo__MIDL_ProcFormatString.Format,
    &IPlan_FormatStringOffsetTable[-3],
    0,
    0,
    0,
    0};
CINTERFACE_PROXY_VTABLE(4) _IPlanProxyVtbl = 
{
    &IPlan_ProxyInfo,
    &IID_IPlan,
    IUnknown_QueryInterface_Proxy,
    IUnknown_AddRef_Proxy,
    IUnknown_Release_Proxy ,
    (void *) (INT_PTR) -1 /* IPlan::Summ */
};

const CInterfaceStubVtbl _IPlanStubVtbl =
{
    &IID_IPlan,
    &IPlan_ServerInfo,
    4,
    0, /* pure interpreted */
    CStdStubBuffer_METHODS
};

static const MIDL_STUB_DESC Object_StubDesc = 
    {
    0,
    NdrOleAllocate,
    NdrOleFree,
    0,
    0,
    0,
    0,
    0,
    FileLocalServerTypeInfo__MIDL_TypeFormatString.Format,
    1, /* -error bounds_check flag */
    0x50002, /* Ndr library version */
    0,
    0x700022b, /* MIDL Version 7.0.555 */
    0,
    0,
    0,  /* notify & notify_flag routine table */
    0x1, /* MIDL flag */
    0, /* cs routines */
    0,   /* proxy/server info */
    0
    };

const CInterfaceProxyVtbl * const _FileLocalServerTypeInfo_ProxyVtblList[] = 
{
    ( CInterfaceProxyVtbl *) &_IPlanProxyVtbl,
    0
};

const CInterfaceStubVtbl * const _FileLocalServerTypeInfo_StubVtblList[] = 
{
    ( CInterfaceStubVtbl *) &_IPlanStubVtbl,
    0
};

PCInterfaceName const _FileLocalServerTypeInfo_InterfaceNamesList[] = 
{
    "IPlan",
    0
};


#define _FileLocalServerTypeInfo_CHECK_IID(n)	IID_GENERIC_CHECK_IID( _FileLocalServerTypeInfo, pIID, n)

int __stdcall _FileLocalServerTypeInfo_IID_Lookup( const IID * pIID, int * pIndex )
{
    
    if(!_FileLocalServerTypeInfo_CHECK_IID(0))
        {
        *pIndex = 0;
        return 1;
        }

    return 0;
}

const ExtendedProxyFileInfo FileLocalServerTypeInfo_ProxyFileInfo = 
{
    (PCInterfaceProxyVtblList *) & _FileLocalServerTypeInfo_ProxyVtblList,
    (PCInterfaceStubVtblList *) & _FileLocalServerTypeInfo_StubVtblList,
    (const PCInterfaceName * ) & _FileLocalServerTypeInfo_InterfaceNamesList,
    0, /* no delegation */
    & _FileLocalServerTypeInfo_IID_Lookup, 
    1,
    2,
    0, /* table of [async_uuid] interfaces */
    0, /* Filler1 */
    0, /* Filler2 */
    0  /* Filler3 */
};
#if _MSC_VER >= 1200
#pragma warning(pop)
#endif


#endif /* defined(_M_AMD64)*/

