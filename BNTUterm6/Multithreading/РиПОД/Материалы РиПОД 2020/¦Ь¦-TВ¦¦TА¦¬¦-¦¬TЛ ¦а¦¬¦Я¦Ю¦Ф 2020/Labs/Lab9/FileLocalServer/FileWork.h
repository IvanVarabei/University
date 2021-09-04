#include "FileLocalServerTypeInfo_h.h"
class Plan : public IPlan
{
public:
   	Plan();
   	virtual ~Plan();

	STDMETHODIMP QueryInterface(REFIID riid, void** pIFace);
	STDMETHODIMP_(DWORD)AddRef();
	STDMETHODIMP_(DWORD)Release();

	STDMETHOD ( Summ(DWORD,DWORD,DWORD*)	);

private:
	LONG	m_refCount;

};