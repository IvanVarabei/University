    #include "stdafx.h"
#include "Lab3.h"
#include "Windows.h"

#define MAX_LOADSTRING 100
#define ID_TIMER_SEC 1
#define ID_TIMER_THIRD 2
#define ID_TIMER_COLOR 3
#define ID_BUTTON 10

HDC hdc;

int x1 = 0;
int y1 = 0;

int x11 = 200;
int y11 = 0;

int size = 200;

HINSTANCE hInst;

HWND hWnd;
HWND hWndChild1;
HWND hWndChild2;

WCHAR szTitle[MAX_LOADSTRING];                 
WCHAR szWindowClass[MAX_LOADSTRING];            

ATOM                MyRegisterClass(HINSTANCE hInstance);
BOOL                InitInstance(HINSTANCE, int);
LRESULT CALLBACK    WndProc(HWND, UINT, WPARAM, LPARAM);

int APIENTRY wWinMain(_In_ HINSTANCE hInstance,
                     _In_opt_ HINSTANCE hPrevInstance,
                     _In_ LPWSTR    lpCmdLine,
                     _In_ int       nCmdShow)
{
    UNREFERENCED_PARAMETER(hPrevInstance);
    UNREFERENCED_PARAMETER(lpCmdLine);

    LoadStringW(hInstance, IDS_APP_TITLE, szTitle, MAX_LOADSTRING);
    LoadStringW(hInstance, IDC_LAB3, szWindowClass, MAX_LOADSTRING);
    MyRegisterClass(hInstance);

    if (!InitInstance (hInstance, nCmdShow))
    {
        return FALSE;
    }

    HACCEL hAccelTable = LoadAccelerators(hInstance, MAKEINTRESOURCE(IDC_LAB3));

    MSG msg;

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

	wcex.hCursor = LoadCursor(nullptr, IDC_ARROW);
	wcex.hbrBackground = (HBRUSH)(CreateSolidBrush(RGB(10, 100, 0)));
	wcex.lpszClassName = L"ChildWnd1";
	
	RegisterClassExW(&wcex);

    wcex.hCursor = LoadCursor(nullptr, IDC_ARROW);
    wcex.hbrBackground = (HBRUSH)(CreateSolidBrush(RGB(39, 200, 200)));
    wcex.lpszClassName = L"ChildWnd2";

    RegisterClassExW(&wcex);

	return RegisterClassExW(&wcex);
}

BOOL InitInstance(HINSTANCE hInstance, int nCmdShow)
{
   hInst = hInstance;

   HWND hWnd = CreateWindowW(szWindowClass, szTitle, WS_OVERLAPPEDWINDOW,
      CW_USEDEFAULT, 0, 1000, 500, nullptr, nullptr, hInstance, nullptr);

   if (!hWnd)
   {
      return FALSE;
   }

   ShowWindow(hWnd, nCmdShow);
   UpdateWindow(hWnd);
   SetTimer(hWnd, ID_TIMER_SEC, 2000, NULL);
   SetTimer(hWnd, ID_TIMER_THIRD, 3000, NULL);
   SetTimer(hWnd, ID_TIMER_COLOR, 2100, NULL);

   return TRUE;
}

LRESULT CALLBACK WndProc(HWND hWnd, UINT message, WPARAM wParam, LPARAM lParam)
{

    switch (message)
    {
	case WM_SYSKEYDOWN:
		if (GetKeyState(VK_MENU) && GetAsyncKeyState(0x31)) {
			SetClassLongPtr(hWndChild1, GCLP_HBRBACKGROUND, (LONG_PTR)CreateSolidBrush(RGB(50, 50, 50)));
            UpdateWindow(hWndChild1);

            SetClassLongPtr(hWndChild2, GCLP_HBRBACKGROUND, (LONG_PTR)CreateSolidBrush(RGB(50, 50, 50)));
            UpdateWindow(hWndChild2);
			break;
		}
		break;
			
    case WM_LBUTTONDOWN:
        ShowWindow(hWndChild1, SW_HIDE);
        hWndChild1 = NULL;
        break;

    case WM_MBUTTONDOWN:
        ShowWindow(hWndChild2, SW_HIDE);
        hWndChild2 = NULL;
        break;

	case WM_TIMER:
		switch (wParam)
		{
		case ID_TIMER_SEC:

			hWndChild1 = CreateWindowW(L"ChildWnd1", L"Child Window 1", WS_CHILDWINDOW
				| WS_CAPTION | WS_SYSMENU | WS_THICKFRAME,
				x1, y1, size, size, hWnd, nullptr, hInst, nullptr);

			ShowWindow(hWndChild1, SW_NORMAL);

			KillTimer(hWnd, ID_TIMER_SEC);
			break;
        case ID_TIMER_THIRD:

            hWndChild2 = CreateWindowW(L"ChildWnd2", L"Child Window 2", WS_CHILDWINDOW
                | WS_CAPTION | WS_SYSMENU | WS_THICKFRAME,
                x11, y11, 200, 200, hWnd, nullptr, hInst, nullptr);

            ShowWindow(hWndChild2, SW_NORMAL);

            KillTimer(hWnd, ID_TIMER_THIRD);
            break;
        case ID_TIMER_COLOR:
            if(size == 200){
                size = 100;
                SetWindowPos(hWndChild1,
                    HWND_TOP,
                    x1,
                    y1,
                    size,
                    size,
                    SWP_DRAWFRAME
                );               
            }
            else {
                size = 200;
                SetWindowPos(hWndChild1,
                    HWND_TOP,
                    x1,
                    y1,
                    size,
                    size,
                    SWP_DRAWFRAME
                );
            }
            break;
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
        case VK_LEFT:
            if (GetKeyState(VK_SHIFT) < 0) {
                SetWindowPos(hWndChild1, HWND_BOTTOM, x1 -= 20, y1, 0, 0, SWP_NOZORDER | SWP_NOSIZE);
            }
            else {
                SetWindowPos(hWndChild2, HWND_BOTTOM, x11 -= 20, y11, 0, 0, SWP_NOZORDER | SWP_NOSIZE);
            }
            break;

        case VK_RIGHT:
            if (GetKeyState(VK_SHIFT) < 0) {
                SetWindowPos(hWndChild1, HWND_BOTTOM, x1 += 20, y1, 0, 0, SWP_NOZORDER | SWP_NOSIZE);
            }
            else {
            SetWindowPos(hWndChild2, HWND_BOTTOM, x11 += 20, y11, 0, 0, SWP_NOZORDER | SWP_NOSIZE);
            }
            break;

        case VK_DOWN:
            if (GetKeyState(VK_SHIFT) < 0) {
                SetWindowPos(hWndChild1, HWND_BOTTOM, x1, y1 += 20, 0, 0, SWP_NOZORDER | SWP_NOSIZE);
            }
            else {
                SetWindowPos(hWndChild2, HWND_BOTTOM, x11, y11 += 20, 0, 0, SWP_NOZORDER | SWP_NOSIZE);
            }
            break;

        case VK_UP:
            if (GetKeyState(VK_SHIFT) < 0) {
                SetWindowPos(hWndChild1, HWND_BOTTOM, x1, y1 -= 20, 0, 0, SWP_NOZORDER | SWP_NOSIZE);
            }
            else {
                SetWindowPos(hWndChild2, HWND_BOTTOM, x11, y11 -= 20, 0, 0, SWP_NOZORDER | SWP_NOSIZE);
            }
            break;
        }
    case WM_COMMAND:
        {
            int wmId = LOWORD(wParam);
            switch (wmId)
            {
            case IDM_EXIT:
                DestroyWindow(hWnd);
                break;
            default:
                return DefWindowProc(hWnd, message, wParam, lParam);
            }
        }
        break;
    case WM_DESTROY:
        PostQuitMessage(0);
        break;
    default:
        return DefWindowProc(hWnd, message, wParam, lParam);
    }
    return 0;
}