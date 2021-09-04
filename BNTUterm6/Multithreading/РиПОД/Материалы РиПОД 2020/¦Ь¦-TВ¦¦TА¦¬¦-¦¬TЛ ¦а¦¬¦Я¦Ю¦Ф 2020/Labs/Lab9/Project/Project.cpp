// Project.cpp : Defines the entry point for the console application.
//
#include "FileLocalServerTypeInfo_h.h"
#include "FileLocalServerTypeInfo_i.c"
#include <stdio.h>
#include "stdafx.h"

IPlan* pPlan = NULL;
IClassFactory * pICF = NULL;
HRESULT hr;

char bufrus[256];
char *rus(const char *text)
{
	CharToOemA(text,bufrus);
	return bufrus;
}

int main()
{
	printf(rus("\nИнициализация COM ..."));
	if ( FAILED( CoInitialize( NULL )))
	{
		printf(rus("\nОшибка при инициализации COM ..."));
		printf(rus("\n\nНажмите любую клавишу для продолжения..."));
		getchar();
		return -1;
	}	
	
	printf(rus("\nПолучение интерфейса фабрики классов для класса Plan..."));
	hr = CoGetClassObject(CLSID_Plan,CLSCTX_LOCAL_SERVER,NULL,IID_IClassFactory,(void**)&pICF);
	if ( FAILED( hr ))
	{
		printf(rus("\nОшибка при получении указателя на интерфейс фабрики классов. Код ошиибки %X"),hr);
		printf(rus("\n\nНажмите любую клавишу для продолжения..."));
		getchar();
		return -1;
	};

	IUnknown* pIUnk;
	hr = pICF->CreateInstance( NULL, IID_IUnknown, (void**) &pIUnk );
	pICF->Release();
	if ( FAILED( hr ))
	{
		printf(rus("\nОшибка при создании экземпляра компонента. Код ошибки %X"),hr);
		printf(rus("\n\nНажмите любую клавишу для продолжения..."));
		getchar();
		return -1;
	};
   
	printf(rus("\nЭкземпляр компонента успешно создан "));
	printf(rus("\n\nНажмите любую клавишу для продолжения..."));
	getchar();
	
	hr = pIUnk->QueryInterface( IID_IPlan, (LPVOID*)&pPlan );
	pIUnk->Release();
	if ( FAILED( hr ))
	{
		printf(rus("Ошибка при запросе интерфейса IPlan. Код ошибки %X"),hr);
		printf(rus("\n\nНажмите любую клавишу для продолжения..."));
		getchar();
		getchar();
		return -1;
	}

	DWORD c = 0;
	pPlan->Summ(3,4,&c);
	printf(rus("Результат -  %d"),c);
	//char str[256];
	//gets(str);
	getchar();
	return 0;
}

