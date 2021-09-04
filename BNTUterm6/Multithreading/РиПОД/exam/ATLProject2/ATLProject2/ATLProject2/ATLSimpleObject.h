// ATLSimpleObject.h: объявление CATLSimpleObject

#pragma once
#include "resource.h"       // основные символы



#include "ATLProject2_i.h"
#include <atlcom.h>
#include <atlhost.h>



#if defined(_WIN32_WCE) && !defined(_CE_DCOM) && !defined(_CE_ALLOW_SINGLE_THREADED_OBJECTS_IN_MTA)
#error "Однопотоковые COM-объекты не поддерживаются должным образом платформой Windows CE, например платформами Windows Mobile, в которых не предусмотрена полная поддержка DCOM. Определите _CE_ALLOW_SINGLE_THREADED_OBJECTS_IN_MTA, чтобы принудить ATL поддерживать создание однопотоковых COM-объектов и разрешить использование его реализаций однопотоковых COM-объектов. Для потоковой модели в вашем rgs-файле задано значение 'Free', поскольку это единственная потоковая модель, поддерживаемая не-DCOM платформами Windows CE."
#endif

using namespace ATL;


// CATLSimpleObject

class ATL_NO_VTABLE CATLSimpleObject :
	public CComObjectRootEx<CComSingleThreadModel>,
	public CComCoClass<CATLSimpleObject, &CLSID_ATLSimpleObject>,
	public IDispatchImpl<IATLSimpleObject, &IID_IATLSimpleObject, &LIBID_ATLProject2Lib, /*wMajor =*/ 1, /*wMinor =*/ 0>
{
public:
	CATLSimpleObject()
	{
	}

DECLARE_REGISTRY_RESOURCEID(106)


BEGIN_COM_MAP(CATLSimpleObject)
	COM_INTERFACE_ENTRY(IATLSimpleObject)
	COM_INTERFACE_ENTRY(IDispatch)
END_COM_MAP()



	DECLARE_PROTECT_FINAL_CONSTRUCT()

	HRESULT FinalConstruct()
	{
		return S_OK;
	}

	void FinalRelease()
	{
	}

public:



	STDMETHOD(Square)(DOUBLE sideLength, DOUBLE* Area);
};

OBJECT_ENTRY_AUTO(__uuidof(ATLSimpleObject), CATLSimpleObject)
