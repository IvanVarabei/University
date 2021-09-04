#include "stdafx.h"
#include "FileWork.h"
#include "FileLocalServerTypeInfo_i.c"
#include <stdio.h>
#include <io.h>
#include "locks.h"

Plan::Plan() : m_refCount(0)
{
	Lock();
}

Plan::~Plan()
{
	UnLock();
}

HRESULT __stdcall Plan::QueryInterface(REFIID riid, void** pIFace)
{
	if(riid == IID_IUnknown)
	{
		//*pIFace = static_cast<IUnknown*>(this);	
		*pIFace = (IUnknown*)(IPlan*)this;
	}
	
	else if(riid == IID_IPlan)
	{
		//*pIFace = static_cast<IPlan*>(this);
		*pIFace = (IPlan*)this;	
	}
	else
	{
		*pIFace = NULL;
		return E_NOINTERFACE;
	}

	//reinterpret_cast<IUnknown*>(*pIFace)->AddRef();

	((IUnknown*)(*pIFace))->AddRef();
	return S_OK;
}

STDMETHODIMP_(DWORD) Plan::AddRef()
{
	return InterlockedIncrement( &m_refCount );
}

STDMETHODIMP_(DWORD) Plan::Release()
{
	if ( InterlockedDecrement( &m_refCount ) == 0 )
	{
		delete this;
		return 0;
	}
	return m_refCount;
}

STDMETHODIMP Plan::Summ(DWORD a,DWORD b,DWORD* c)
{
	*c = a + b;
	return S_OK;
}