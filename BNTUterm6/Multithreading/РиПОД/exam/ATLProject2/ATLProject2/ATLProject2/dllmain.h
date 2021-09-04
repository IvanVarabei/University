// dllmain.h: объявление класса модуля.

class CATLProject2Module : public ATL::CAtlDllModuleT< CATLProject2Module >
{
public :
	DECLARE_LIBID(LIBID_ATLProject2Lib)
	DECLARE_REGISTRY_APPID_RESOURCEID(IDR_ATLPROJECT2, "{485c6413-ed98-4c5e-8f24-e093ad6226ad}")
};

extern class CATLProject2Module _AtlModule;
