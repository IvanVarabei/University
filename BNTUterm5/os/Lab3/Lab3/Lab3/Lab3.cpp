// Lab3.cpp : Defines the entry point for the application.
//

#include "stdafx.h"
#include "Lab3.h"
#include "Windows.h"

#define MAX_LOADSTRING 100
#define ID_TIMER_SEC 1
#define ID_TIMER_MIN 2
#define ID_TIMER_SEC2 3
#define ID_TIMER_MIN2 4
//#define ID_FOCUSTIMER 5

#define ID_BUTTON 10

HDC hdc;

int x1 = 50;
int x2 = 250;
int x3 = 50;
int x4 = 250;
int y1 = 50;
int y2 = 50;
int y3 = 250;
int y4 = 250;
int rc;
int i = 0;

int c1, c2, c3, c4, v1, v2, v3, v4;

WCHAR str1[10] = { L"Строчная" };
WCHAR str2[10] = { L"Прописная" };
WCHAR str3[50];

// Global Variables:
HINSTANCE hInst;                                // current instance

HWND hWnd;
HWND hWndChild1, hWndChild2, hWndChild3, hWndChild4;
HWND hEdit1, hEdit2, hEdit3, hEdit4, hEdit;

LRESULT CALLBACK EditProc(HWND, UINT, WPARAM, LPARAM);

WNDPROC EditDefault; //указатель на стандартную функцию обработчик событий edit'a

int counter = 0;
int cnt = 0;

WCHAR szTitle[MAX_LOADSTRING];                  // The title bar text
WCHAR szWindowClass[MAX_LOADSTRING];            // the main window class name

// Forward declarations of functions included in this code module:
ATOM                MyRegisterClass(HINSTANCE hInstance);
BOOL                InitInstance(HINSTANCE, int);
LRESULT CALLBACK    WndProc(HWND, UINT, WPARAM, LPARAM);
LRESULT CALLBACK    WndProc1(HWND, UINT, WPARAM, LPARAM);
LRESULT CALLBACK    WndProc2(HWND, UINT, WPARAM, LPARAM);
LRESULT CALLBACK    WndProc3(HWND, UINT, WPARAM, LPARAM);
LRESULT CALLBACK    WndProc4(HWND, UINT, WPARAM, LPARAM);
INT_PTR CALLBACK    About(HWND, UINT, WPARAM, LPARAM);

int APIENTRY wWinMain(_In_ HINSTANCE hInstance,
                     _In_opt_ HINSTANCE hPrevInstance,
                     _In_ LPWSTR    lpCmdLine,
                     _In_ int       nCmdShow)
{
    UNREFERENCED_PARAMETER(hPrevInstance);
    UNREFERENCED_PARAMETER(lpCmdLine);

    // TODO: Place code here.

    // Initialize global strings
    LoadStringW(hInstance, IDS_APP_TITLE, szTitle, MAX_LOADSTRING);
    LoadStringW(hInstance, IDC_LAB3, szWindowClass, MAX_LOADSTRING);
    MyRegisterClass(hInstance);

    // Perform application initialization:
    if (!InitInstance (hInstance, nCmdShow))
    {
        return FALSE;
    }

    HACCEL hAccelTable = LoadAccelerators(hInstance, MAKEINTRESOURCE(IDC_LAB3));

    MSG msg;

    // Main message loop:
    while (GetMessage(&msg, nullptr, 0, 0))
    {
        if (!TranslateAccelerator(msg.hwnd, hAccelTable, &msg))
        {
            TranslateMessage(&msg);
            DispatchMessage(&msg);
        }
    }

    return (int) msg.wParam;
}



//
//  FUNCTION: MyRegisterClass()
//
//  PURPOSE: Registers the window class.
//
ATOM MyRegisterClass(HINSTANCE hInstance)
{
    WNDCLASSEXW wcex;

    wcex.cbSize = sizeof(WNDCLASSEX);

    wcex.style          = CS_HREDRAW | CS_VREDRAW;
    wcex.lpfnWndProc    = WndProc;
    wcex.cbClsExtra     = 0;
    wcex.cbWndExtra     = 0;
    wcex.hInstance      = hInstance;
    wcex.hIcon          = LoadIcon(hInstance, MAKEINTRESOURCE(IDI_LAB3));
    wcex.hCursor        = LoadCursor(nullptr, IDC_ARROW);
    wcex.hbrBackground  = (HBRUSH)(COLOR_WINDOW+1);
    wcex.lpszMenuName   = MAKEINTRESOURCEW(IDC_LAB3);
    wcex.lpszClassName  = szWindowClass;
    wcex.hIconSm        = LoadIcon(wcex.hInstance, MAKEINTRESOURCE(IDI_SMALL));

	RegisterClassExW(&wcex);

	wcex.lpfnWndProc = WndProc1;
	wcex.hCursor = LoadCursor(nullptr, IDC_ARROW);
	wcex.hbrBackground = (HBRUSH)(CreateSolidBrush(RGB(250, 100, 0)));
	wcex.lpszClassName = L"ChildWnd1";
	
	RegisterClassExW(&wcex);

	wcex.lpfnWndProc = WndProc2;
	wcex.hCursor = LoadCursor(nullptr, IDC_ARROW);
	wcex.hbrBackground = (HBRUSH)(CreateSolidBrush(RGB(0, 0, 200)));
	wcex.lpszClassName = L"ChildWnd2";
	
	RegisterClassExW(&wcex);

	wcex.lpfnWndProc = WndProc3;
	wcex.hCursor = LoadCursor(nullptr, IDC_ARROW);
	wcex.hbrBackground = (HBRUSH)(CreateSolidBrush(RGB(250, 250, 0)));
	wcex.lpszClassName = L"ChildWnd3";
	
	RegisterClassExW(&wcex);

	wcex.lpfnWndProc = WndProc4;
	wcex.hCursor = LoadCursor(nullptr, IDC_ARROW);
	wcex.hbrBackground = (HBRUSH)(CreateSolidBrush(RGB(0, 250, 0)));
	wcex.lpszClassName = L"ChildWnd4";

	return RegisterClassExW(&wcex);
}

//
//   FUNCTION: InitInstance(HINSTANCE, int)
//
//   PURPOSE: Saves instance handle and creates main window
//
//   COMMENTS:
//
//        In this function, we save the instance handle in a global variable and
//        create and display the main program window.
//
BOOL InitInstance(HINSTANCE hInstance, int nCmdShow)
{
   hInst = hInstance; // Store instance handle in our global variable

   HWND hWnd = CreateWindowW(szWindowClass, szTitle, WS_OVERLAPPEDWINDOW,
      CW_USEDEFAULT, 0, 550, 600, nullptr, nullptr, hInstance, nullptr);

   /*hEdit = CreateWindow(L"Edit", L"Sample", WS_CHILD | WS_VISIBLE,
	   10, 10, 80, 20, hWnd, nullptr, hInst, nullptr);*/

   if (!hWnd)
   {
      return FALSE;
   }

   ShowWindow(hWnd, nCmdShow);
   UpdateWindow(hWnd);

   return TRUE;
}

//
//  FUNCTION: WndProc(HWND, UINT, WPARAM, LPARAM)
//
//  PURPOSE: Processes messages for the main window.
//
//  WM_COMMAND  - process the application menu
//  WM_PAINT    - Paint the main window
//  WM_DESTROY  - post a quit message and return
//
//
LRESULT CALLBACK WndProc(HWND hWnd, UINT message, WPARAM wParam, LPARAM lParam)
{

    switch (message)
    {
	case WM_SYSKEYDOWN:
		if (GetKeyState(VK_MENU) && GetAsyncKeyState(0x31)) {
			SetClassLongPtr(hWndChild1, GCLP_HBRBACKGROUND, (LONG_PTR)CreateSolidBrush(RGB(50, 50, 50)));
			UpdateWindow(hWndChild1);
			SetWindowText(GetParent(GetFocus()), L"Window");
			SetFocus(hWndChild1);
			SetWindowText(hWndChild1, L"Focus window");
			SetFocus(hEdit1);
			InvalidateRect(hWndChild1, NULL, 1);
			break;
		}
		if (GetAsyncKeyState(VK_MENU) && GetAsyncKeyState(0x32)) {
			SetClassLongPtr(hWndChild2, GCLP_HBRBACKGROUND, (LONG_PTR)CreateSolidBrush(RGB(200, 0, 50)));
			UpdateWindow(hWndChild2);
			SetWindowText(GetParent(GetFocus()), L"Window");
			SetFocus(hWndChild2);
			SetWindowText(hWndChild2, L"Focus window");
			SetFocus(hEdit2);
			InvalidateRect(hWndChild2, NULL, 1);
			break;
		}
		if (GetAsyncKeyState(0x33) && GetAsyncKeyState(VK_MENU)) {
			SetClassLongPtr(hWndChild3, GCLP_HBRBACKGROUND, (LONG_PTR)CreateSolidBrush(RGB(250, 0, 250)));
			UpdateWindow(hWndChild3);
			SetWindowText(GetParent(GetFocus()), L"Window");
			SetFocus(hWndChild3);
			SetWindowText(hWndChild3, L"Focus window");
			SetFocus(hEdit3);
			InvalidateRect(hWndChild3, NULL, 1);
			break;
		}
		if (GetAsyncKeyState(0x34) && GetAsyncKeyState(VK_MENU)) {
			SetClassLongPtr(hWndChild4, GCLP_HBRBACKGROUND, (LONG_PTR)CreateSolidBrush(RGB(50, 250, 50)));
			UpdateWindow(hWndChild4);
			SetWindowText(GetParent(GetFocus()), L"Window");
			SetFocus(hWndChild4);
			SetWindowText(hWndChild4, L"Focus window");
			SetFocus(hEdit4);
			InvalidateRect(hWndChild4, NULL, 1);
			break;
		}
		break;
			
	case WM_LBUTTONDOWN:
		SetTimer(hWnd, ID_TIMER_SEC, 1000, NULL);
		SetTimer(hWnd, ID_TIMER_MIN, 2000, NULL);
		SetTimer(hWnd, ID_TIMER_SEC2, 3000, NULL);
		SetTimer(hWnd, ID_TIMER_MIN2, 4000, NULL);
		//SetTimer(hWnd, ID_FOCUSTIMER, 1000, NULL);
		break;

	case WM_TIMER:
		switch (wParam)
		{
		case ID_TIMER_SEC:

			hWndChild1 = CreateWindowW(L"ChildWnd1", L"Child Window 1", WS_CHILDWINDOW
				| WS_CAPTION | WS_SYSMENU | WS_THICKFRAME,
				x1, y1, 200, 200, hWnd, nullptr, hInst, nullptr);

			hEdit1 = CreateWindow(L"Edit", L"Sample", WS_CHILD | WS_VISIBLE,
				60, 75, 80, 20, hWndChild1, nullptr, hInst, nullptr);

			//CreateWindowW(L"Button", L"Kek", WS_CHILD | WS_VISIBLE | BS_PUSHBUTTON | BS_MULTILINE,
			//	30 , 30, 20, 20, hWndChild1, (HMENU)ID_BUTTON, hInst, nullptr);

			ShowWindow(hWndChild1, SW_NORMAL);

			EditDefault = (WNDPROC)GetWindowLongPtr(hEdit1, GWLP_WNDPROC); // здесь получили указатель на ф-цию

			SetWindowLongPtr(hEdit1, GWLP_WNDPROC, (LONG_PTR)EditProc); // меняем указатель на нашу функцию

			KillTimer(hWnd, ID_TIMER_SEC);
			break;

		case ID_TIMER_MIN:

			hWndChild2 = CreateWindowW(L"ChildWnd2", L"Child Window 2", WS_CHILDWINDOW
				| WS_CAPTION | WS_SYSMENU | WS_THICKFRAME,
				x2, y2, 200, 200, hWnd, nullptr, hInst, nullptr);

			//hEdit2 = CreateWindow(L"Edit", L"Sample", WS_CHILD | WS_VISIBLE,
			//	60, 75, 80, 20, hWndChild2, nullptr, hInst, nullptr);

			//CreateWindowW(L"Button", L"Kek", WS_CHILD | WS_VISIBLE | BS_PUSHBUTTON | BS_MULTILINE,
			//	30, 30, 20, 20, hWndChild2, (HMENU)ID_BUTTON, hInst, nullptr);

			ShowWindow(hWndChild2, SW_NORMAL);

			EditDefault = (WNDPROC)GetWindowLongPtr(hEdit2, GWLP_WNDPROC); // здесь получили указатель на ф-цию

			SetWindowLongPtr(hEdit2, GWLP_WNDPROC, (LONG_PTR)EditProc); // меняем указатель на нашу функцию

			KillTimer(hWnd, ID_TIMER_MIN);
			break;

		case ID_TIMER_SEC2:

			hWndChild3 = CreateWindowW(L"ChildWnd3", L"Child Window 3", WS_CHILDWINDOW
				| WS_CAPTION | WS_SYSMENU | WS_THICKFRAME,
				x3, y3, 200, 200, hWnd, nullptr, hInst, nullptr);

			//hEdit3 = CreateWindow(L"Edit", L"Sample", WS_CHILD | WS_VISIBLE,
			//	60, 75, 80, 20, hWndChild3, nullptr, hInst, nullptr);

			ShowWindow(hWndChild3, SW_NORMAL);

			EditDefault = (WNDPROC)GetWindowLongPtr(hEdit3, GWLP_WNDPROC); // здесь получили указатель на ф-цию

			SetWindowLongPtr(hEdit3, GWLP_WNDPROC, (LONG_PTR)EditProc); // меняем указатель на нашу функцию

			KillTimer(hWnd, ID_TIMER_SEC2);
			break;

		case ID_TIMER_MIN2:

			hWndChild4 = CreateWindowW(L"ChildWnd4", L"Child Window 4", WS_CHILDWINDOW
				| WS_CAPTION | WS_SYSMENU | WS_THICKFRAME,
				x4, y4, 200, 200, hWnd, nullptr, hInst, nullptr);

			//hEdit4 = CreateWindow(L"Edit", L"Sample", WS_CHILD | WS_VISIBLE,
			//	60, 75, 80, 20, hWndChild4, nullptr, hInst, nullptr);

			ShowWindow(hWndChild4, SW_NORMAL);

			EditDefault = (WNDPROC)GetWindowLongPtr(hEdit4, GWLP_WNDPROC); // здесь получили указатель на ф-цию

			SetWindowLongPtr(hEdit4, GWLP_WNDPROC, (LONG_PTR)EditProc); // меняем указатель на нашу функцию

			KillTimer(hWnd, ID_TIMER_MIN2);
			break;
		}
		/*case ID_FOCUSTIMER:
			if (cnt == 0) {
				SetFocus(hWndChild1);
				SetWindowText(hWndChild1, L"Focus window");
				SetWindowText(hWndChild4, L"Window");
			}
			if (cnt == 1) {
				SetFocus(hWndChild2);
				SetWindowText(hWndChild2, L"Focus window");
				SetWindowText(hWndChild1, L"Window");
			}
			if (cnt == 2) {

				SetFocus(hWndChild3);
				SetWindowText(hWndChild3, L"Focus window");
				SetWindowText(hWndChild2, L"Window");
			}
			if (cnt == 3) {

				SetFocus(hWndChild4);
				SetWindowText(hWndChild4, L"Focus window");
				SetWindowText(hWndChild3, L"Window");
				cnt = -1;
			}
			cnt++;
			break;
		}
		break;*/
	
	case WM_CHAR:
		if (wParam >= 65 && wParam <= 90){
			SetWindowText(hEdit, str1);
		}
		if (wParam >= 97 && wParam <= 122) {
			SetWindowText(hEdit, str2);
		}

	case WM_KEYDOWN:
		switch (wParam)
		{
		case(0x31):
		{
			if (GetKeyState(VK_CONTROL) < 0) {
				SetWindowLong(hWndChild1, GWL_STYLE, WS_HSCROLL | GetWindowLong(hWndChild1, GWL_STYLE));
				SetWindowPos(hWndChild1, NULL, 30, 30, 220, 220, SWP_NOZORDER);
			}
			break;
		}
		case(0x32):
		{
			if (GetKeyState(VK_CONTROL) < 0) {
				SetWindowLong(hWndChild2, GWL_STYLE, WS_HSCROLL | GetWindowLong(hWndChild2, GWL_STYLE));
				SetWindowPos(hWndChild2, NULL, 250, 20, 230, 230, SWP_NOZORDER);
			}
			break;
		}
		case(0x33):
		{
			if (GetKeyState(VK_CONTROL) < 0) {
				SetWindowLong(hWndChild3, GWL_STYLE, WS_HSCROLL | GetWindowLong(hWndChild3, GWL_STYLE));
				SetWindowPos(hWndChild3, NULL, 10, 250, 240, 240, SWP_NOZORDER );
			}
			break;
		}
		case(0x34):
		{
			if (GetKeyState(VK_CONTROL) < 0) {
				SetWindowLong(hWndChild4, GWL_STYLE, WS_HSCROLL | GetWindowLong(hWndChild4, GWL_STYLE));
				SetWindowPos(hWndChild4, NULL, 250, 250, 250, 250, SWP_NOZORDER);
			}
			break;
		}
		case VK_LEFT:
			SetWindowPos(hWndChild1, HWND_BOTTOM, x1 -= 20, y1, 0, 0, SWP_NOZORDER | SWP_NOSIZE);
			SetWindowPos(hWndChild2, HWND_BOTTOM, x2 -= 20, y2, 0, 0, SWP_NOZORDER | SWP_NOSIZE);
			SetWindowPos(hWndChild3, HWND_BOTTOM, x3 -= 20, y3, 0, 0, SWP_NOZORDER | SWP_NOSIZE);
			SetWindowPos(hWndChild4, HWND_BOTTOM, x4 -= 20, y4, 0, 0, SWP_NOZORDER | SWP_NOSIZE);
			break;

		case VK_RIGHT:
			SetWindowPos(hWndChild1, HWND_BOTTOM, x1 += 20, y1, 0, 0, SWP_NOZORDER | SWP_NOSIZE);
			SetWindowPos(hWndChild2, HWND_BOTTOM, x2 += 20, y2, 0, 0, SWP_NOZORDER | SWP_NOSIZE);
			SetWindowPos(hWndChild3, HWND_BOTTOM, x3 += 20, y3, 0, 0, SWP_NOZORDER | SWP_NOSIZE);
			SetWindowPos(hWndChild4, HWND_BOTTOM, x4 += 20, y4, 0, 0, SWP_NOZORDER | SWP_NOSIZE);
			break;
			
		case VK_DOWN:
			SetWindowPos(hWndChild1, HWND_BOTTOM, x1, y1 += 20, 0, 0, SWP_NOZORDER | SWP_NOSIZE);
			SetWindowPos(hWndChild2, HWND_BOTTOM, x2, y2 += 20, 0, 0, SWP_NOZORDER | SWP_NOSIZE);
			SetWindowPos(hWndChild3, HWND_BOTTOM, x3, y3 += 20, 0, 0, SWP_NOZORDER | SWP_NOSIZE);
			SetWindowPos(hWndChild4, HWND_BOTTOM, x4, y4 += 20, 0, 0, SWP_NOZORDER | SWP_NOSIZE);
			break;

		case VK_UP:
			SetWindowPos(hWndChild1, HWND_BOTTOM, x1, y1 -= 20, 0, 0, SWP_NOZORDER | SWP_NOSIZE);
			SetWindowPos(hWndChild2, HWND_BOTTOM, x2, y2 -= 20, 0, 0, SWP_NOZORDER | SWP_NOSIZE);
			SetWindowPos(hWndChild3, HWND_BOTTOM, x3, y3 -= 20, 0, 0, SWP_NOZORDER | SWP_NOSIZE);
			SetWindowPos(hWndChild4, HWND_BOTTOM, x4, y4 -= 20, 0, 0, SWP_NOZORDER | SWP_NOSIZE);
			break;

		}

	case WM_RBUTTONDOWN:
		SetWindowText(hWnd, L"Mouse is in client part");
		break;
	case WM_NCRBUTTONDOWN:
		SetWindowText(hWnd, L"Mouse is not in client part of window");
		break;

    case WM_COMMAND:
        {
            int wmId = LOWORD(wParam);
            // Parse the menu selections:
            switch (wmId)
            {
            case IDM_ABOUT:
                DialogBox(hInst, MAKEINTRESOURCE(IDD_ABOUTBOX), hWnd, About);
				break;
            case IDM_EXIT:
                DestroyWindow(hWnd);
                break;
            default:
                return DefWindowProc(hWnd, message, wParam, lParam);
            }
        }
        break;
    case WM_PAINT:
        {
            PAINTSTRUCT ps;
            HDC hdc = BeginPaint(hWnd, &ps);
            // TODO: Add any drawing code that uses hdc here...
            EndPaint(hWnd, &ps);
        }
        break;

	/*case WM_CHAR:
	{
		TCHAR c = (TCHAR)wParam;
		hdc = GetDC(hWnd);
		str3[i++] = c;
		SetWindowText(hEdit, str3);
		break;
	}*/

    case WM_DESTROY:
        PostQuitMessage(0);
        break;
    default:
        return DefWindowProc(hWnd, message, wParam, lParam);
    }
    return 0;
}

LRESULT CALLBACK WndProc1(HWND hWnd, UINT message, WPARAM wParam, LPARAM lParam)
{
	switch (message)
	{
	case WM_SETFOCUS:
		RECT rt;
		GetWindowRect(hWndChild1, &rt);
		c1 = rt.left + ((rt.right - rt.left) / 2);
		v1 = rt.top + ((rt.bottom - rt.top) / 2);
		SetCursorPos(c1, v1);

	case WM_RBUTTONDOWN:
		SetCapture(hWndChild1);
		SetWindowText(hWndChild1, L"Zahvat");
		break;
	case WM_RBUTTONUP:
		ReleaseCapture();
		SetWindowText(hWndChild1, L"Window");
		break;
	//case WM_SYSKEYDOWN:
	//	if (GetAsyncKeyState(0x31) && GetAsyncKeyState(VK_MENU)) {
	//		ReleaseCapture();
	//	}
	//	break;
	case WM_DESTROY:
		hWndChild1 = NULL;
		break;
	default:
		return DefWindowProc(hWnd, message, wParam, lParam);
	}
	return 0;
}

LRESULT CALLBACK WndProc2(HWND hWnd, UINT message, WPARAM wParam, LPARAM lParam)
{
	switch (message)
	{
	case WM_SETFOCUS:
		RECT rt;
		GetWindowRect(hWndChild1, &rt);
		c2 = rt.left + ((rt.right - rt.left) / 2);
		v2 = rt.top + ((rt.bottom - rt.top) / 2);
		SetCursorPos(c2, v2);
	case WM_RBUTTONDOWN:
		SetCapture(hWndChild2);
		SetWindowText(hWndChild2, L"Zahvat");
		break;
	case WM_RBUTTONUP:
		ReleaseCapture();
		SetWindowText(hWndChild2, L"Window");
		break;
	//case WM_LBUTTONDOWN:
	//	SetCapture(hWndChild2);
	//	break;
	//case WM_SYSKEYDOWN:
	//	if (GetAsyncKeyState(0x32) && GetAsyncKeyState(VK_MENU)) {
	//		ReleaseCapture();
	//	}
	//	break;
	case WM_DESTROY:
		hWndChild2 = NULL;
		break;
	default:
		return DefWindowProc(hWnd, message, wParam, lParam);
	}
	return 0;
}

LRESULT CALLBACK WndProc3(HWND hWnd, UINT message, WPARAM wParam, LPARAM lParam)
{
	switch (message)
	{
	case WM_SETFOCUS:
		RECT rt;
		GetWindowRect(hWndChild1, &rt);
		c3 = rt.left + ((rt.right - rt.left) / 2);
		v3 = rt.top + ((rt.bottom - rt.top) / 2);
		SetCursorPos(c3, v3);

	case WM_RBUTTONDOWN:
		SetCapture(hWndChild3);
		SetWindowText(hWndChild3, L"Zahvat");
		break;
	case WM_RBUTTONUP:
		ReleaseCapture();
		SetWindowText(hWndChild3, L"Window");
		break;
	//case WM_LBUTTONDOWN:
	//	SetCapture(hWndChild3);
	//	break;
	//case WM_SYSKEYDOWN:
	//	if (GetAsyncKeyState(0x33) && GetAsyncKeyState(VK_MENU)) {
	//		ReleaseCapture();
	//	}
	//	break;
	case WM_DESTROY:
		hWndChild3 = NULL;
		break;
	default:
		return DefWindowProc(hWnd, message, wParam, lParam);
	}
	return 0;
}

LRESULT CALLBACK WndProc4(HWND hWnd, UINT message, WPARAM wParam, LPARAM lParam)
{
	switch (message)
	{
	case WM_SETFOCUS:
		RECT rt;
		GetWindowRect(hWndChild1, &rt);
		c4 = rt.left + ((rt.right - rt.left) / 2);
		v4 = rt.top + ((rt.bottom - rt.top) / 2);
		SetCursorPos(c4, v4);

	case WM_RBUTTONDOWN:
		SetCapture(hWndChild4);
		SetWindowText(hWndChild4, L"Zahvat");
		break;
	case WM_RBUTTONUP:
		ReleaseCapture();
		SetWindowText(hWndChild4, L"Window");
		break;
	//case WM_LBUTTONDOWN:
	//	SetCapture(hWndChild4);
	//	break;
	//case WM_SYSKEYDOWN:
	//	if (GetAsyncKeyState(0x34) && GetAsyncKeyState(VK_MENU)) {
	//		ReleaseCapture();
	//	}
	//	break;
	case WM_DESTROY:
		hWndChild4 = NULL;
		break;
	default:
		return DefWindowProc(hWnd, message, wParam, lParam);
		}
		return 0;
}

// Message handler for about box.
INT_PTR CALLBACK About(HWND hDlg, UINT message, WPARAM wParam, LPARAM lParam)
{
    UNREFERENCED_PARAMETER(lParam);
    switch (message)
    {
    case WM_INITDIALOG:
        return (INT_PTR)TRUE;

    case WM_COMMAND:
        if (LOWORD(wParam) == IDOK || LOWORD(wParam) == IDCANCEL)
        {
            EndDialog(hDlg, LOWORD(wParam));
            return (INT_PTR)TRUE;
        }
        break;
    }
    return (INT_PTR)FALSE;
}

LRESULT CALLBACK EditProc(HWND hWnd, UINT message, WPARAM wParam, LPARAM lParam)
{
	switch (message)
	{
	case WM_SYSKEYDOWN:
		if (GetKeyState(VK_MENU) && GetAsyncKeyState(0x31)) {
			SetWindowText(GetParent(GetFocus()), L"Window");
			SetFocus(hWndChild1);
			SetWindowText(hWndChild1, L"Focus window");
			SetFocus(hEdit1);

		}
		if (GetAsyncKeyState(VK_MENU) && GetAsyncKeyState(0x32)) {
			SetWindowText(GetParent(GetFocus()), L"Window");
			SetFocus(hWndChild2);
			SetWindowText(hWndChild2, L"Focus window");
			SetFocus(hEdit2);
		}
		if (GetAsyncKeyState(0x33) && GetAsyncKeyState(VK_MENU)) {
			SetWindowText(GetParent(GetFocus()), L"Window");
			SetFocus(hWndChild3);
			SetWindowText(hWndChild3, L"Focus window");
			SetFocus(hEdit3);
		}
		if (GetAsyncKeyState(0x34) && GetAsyncKeyState(VK_MENU)) {
			SetWindowText(GetParent(GetFocus()), L"Window");
			SetFocus(hWndChild4);
			SetWindowText(hWndChild4, L"Focus window");
			SetFocus(hEdit4);
		}

		break;
	default:
		return CallWindowProc(EditDefault, hWnd, message, wParam, lParam); // все остальные события пусть обрабатывает стандартный обработчик
	}
	return 0;
}
