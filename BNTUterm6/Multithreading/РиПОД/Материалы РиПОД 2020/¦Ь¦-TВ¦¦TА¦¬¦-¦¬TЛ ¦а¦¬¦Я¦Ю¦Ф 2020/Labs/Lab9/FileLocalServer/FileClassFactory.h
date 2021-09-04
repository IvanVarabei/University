#include <windows.h>
#include <unknwn.h>

class FileClassFactory : public IClassFactory
{
public:
	FileClassFactory();
	virtual ~FileClassFactory();
	STDMETHODIMP QueryInterface(REFIID riid,void** pIFace);
	STDMETHODIMP_(ULONG)AddRef();
	STDMETHODIMP_(ULONG)Release();
	STDMETHODIMP LockServer(BOOL fLock);
	STDMETHODIMP CreateInstance(LPUNKNOWN pUnkOuter,REFIID riid,void** ppv);

private:
	LONG m_refCount;

};