// ATLSimpleObject.cpp: реализация CATLSimpleObject

#include "pch.h"

#include "ATLSimpleObject.h"

using namespace std;
// CATLSimpleObject



STDMETHODIMP CATLSimpleObject::Square(DOUBLE sideLength, DOUBLE* Area)
{
	// TODO: Добавьте сюда код реализации
	*Area = sideLength * sideLength;
	return S_OK;
}
