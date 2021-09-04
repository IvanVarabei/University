

/* this ALWAYS GENERATED file contains the definitions for the interfaces */


 /* File created by MIDL compiler version 7.00.0555 */
/* at Thu Dec 08 08:26:48 2011
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

#pragma warning( disable: 4049 )  /* more than 64k source lines */


/* verify that the <rpcndr.h> version is high enough to compile this file*/
#ifndef __REQUIRED_RPCNDR_H_VERSION__
#define __REQUIRED_RPCNDR_H_VERSION__ 475
#endif

#include "rpc.h"
#include "rpcndr.h"

#ifndef __RPCNDR_H_VERSION__
#error this stub requires an updated version of <rpcndr.h>
#endif // __RPCNDR_H_VERSION__

#ifndef COM_NO_WINDOWS_H
#include "windows.h"
#include "ole2.h"
#endif /*COM_NO_WINDOWS_H*/

#ifndef __FileLocalServerTypeInfo_h_h__
#define __FileLocalServerTypeInfo_h_h__

#if defined(_MSC_VER) && (_MSC_VER >= 1020)
#pragma once
#endif

/* Forward Declarations */ 

#ifndef __IPlan_FWD_DEFINED__
#define __IPlan_FWD_DEFINED__
typedef interface IPlan IPlan;
#endif 	/* __IPlan_FWD_DEFINED__ */


#ifndef __Plan_FWD_DEFINED__
#define __Plan_FWD_DEFINED__

#ifdef __cplusplus
typedef class Plan Plan;
#else
typedef struct Plan Plan;
#endif /* __cplusplus */

#endif 	/* __Plan_FWD_DEFINED__ */


/* header files for imported files */
#include "oaidl.h"
#include "ocidl.h"

#ifdef __cplusplus
extern "C"{
#endif 


#ifndef __IPlan_INTERFACE_DEFINED__
#define __IPlan_INTERFACE_DEFINED__

/* interface IPlan */
/* [helpstring][oleautomation][uuid][object] */ 


EXTERN_C const IID IID_IPlan;

#if defined(__cplusplus) && !defined(CINTERFACE)
    
    MIDL_INTERFACE("FE78387F-D150-4089-832C-BBF02402C872")
    IPlan : public IUnknown
    {
    public:
        virtual HRESULT STDMETHODCALLTYPE Summ( 
            /* [in] */ DWORD a,
            /* [in] */ DWORD b,
            /* [out] */ DWORD *c) = 0;
        
    };
    
#else 	/* C style interface */

    typedef struct IPlanVtbl
    {
        BEGIN_INTERFACE
        
        HRESULT ( STDMETHODCALLTYPE *QueryInterface )( 
            IPlan * This,
            /* [in] */ REFIID riid,
            /* [annotation][iid_is][out] */ 
            __RPC__deref_out  void **ppvObject);
        
        ULONG ( STDMETHODCALLTYPE *AddRef )( 
            IPlan * This);
        
        ULONG ( STDMETHODCALLTYPE *Release )( 
            IPlan * This);
        
        HRESULT ( STDMETHODCALLTYPE *Summ )( 
            IPlan * This,
            /* [in] */ DWORD a,
            /* [in] */ DWORD b,
            /* [out] */ DWORD *c);
        
        END_INTERFACE
    } IPlanVtbl;

    interface IPlan
    {
        CONST_VTBL struct IPlanVtbl *lpVtbl;
    };

    

#ifdef COBJMACROS


#define IPlan_QueryInterface(This,riid,ppvObject)	\
    ( (This)->lpVtbl -> QueryInterface(This,riid,ppvObject) ) 

#define IPlan_AddRef(This)	\
    ( (This)->lpVtbl -> AddRef(This) ) 

#define IPlan_Release(This)	\
    ( (This)->lpVtbl -> Release(This) ) 


#define IPlan_Summ(This,a,b,c)	\
    ( (This)->lpVtbl -> Summ(This,a,b,c) ) 

#endif /* COBJMACROS */


#endif 	/* C style interface */




#endif 	/* __IPlan_INTERFACE_DEFINED__ */



#ifndef __FileLocalServerLib_LIBRARY_DEFINED__
#define __FileLocalServerLib_LIBRARY_DEFINED__

/* library FileLocalServerLib */
/* [helpstring][version][uuid] */ 


EXTERN_C const IID LIBID_FileLocalServerLib;

EXTERN_C const CLSID CLSID_Plan;

#ifdef __cplusplus

class DECLSPEC_UUID("1D66CBA8-CCE2-4439-8596-82B47AA44E43")
Plan;
#endif
#endif /* __FileLocalServerLib_LIBRARY_DEFINED__ */

/* Additional Prototypes for ALL interfaces */

/* end of Additional Prototypes */

#ifdef __cplusplus
}
#endif

#endif


