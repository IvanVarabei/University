#include "stdafx.h"
#include "FileWork.h"
#include "FileClassFactory.h"
#include "locks.h"

FileClassFactory::FileClassFactory()
{
	m_refCount = 0;
}

FileClassFactory::~FileClassFactory()
{	
}

STDMETHODIMP_(ULONG) FileClassFactory::AddRef()
{
	   return InterlockedIncrement( &m_refCount );
}

STDMETHODIMP_(ULONG) FileClassFactory::Release()
{
	if ( InterlockedDecrement( &m_refCount ) == 0 )
	{
		delete this;
		return 0;
	}
	return ++m_refCount;
}

STDMETHODIMP FileClassFactory::QueryInterface(REFIID riid,void** pIFace)
{
	if ( riid == IID_IUnknown )
	{
		//*pIFace = static_cast<IUnknown*>(this);
		*pIFace = (IUnknown*)this;
	}
	else if ( riid == IID_IClassFactory )
	{
		//*pIFace =static_cast<IClassFactory*>(this);
		*pIFace = (IClassFactory*)this;
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

STDMETHODIMP FileClassFactory::LockServer(BOOL fLock)
{
	if ( fLock ) 
		Lock();
	else 
		UnLock();
	return S_OK;
}

STDMETHODIMP FileClassFactory::CreateInstance(LPUNKNOWN pUnkOuter,REFIID riid,void** ppv)
{
	if ( pUnkOuter != NULL ) return CLASS_E_NOAGGREGATION;

	Plan* pFileWorkObj = NULL;
	HRESULT hr;

	pFileWorkObj = new Plan();
	hr = pFileWorkObj->QueryInterface(riid,ppv);

	if ( FAILED(hr) ) delete pFileWorkObj;
	return hr;
}
