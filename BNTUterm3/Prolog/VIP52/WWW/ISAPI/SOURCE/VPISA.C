/******************************************************************************

                           PDC Prolog

             Copyright (c) 1984 - 2000 Prolog Development Center A/S

 FileName: VPISA.C
 PURPOSE:
        Implementation of ISAPI Layer Functions for 32-bit ISAPI DLLs .



******************************************************************************/

#include <windows.h>
#include <httpext.h>

#include <pdcrunt.h>

#define HSE_MAX_VARIABLE_LEN            4096


#define NO_SPECIAL_INI


//
//   User defined extension functions prototypes
//

// http_ExtensionVersion(string) - (o) language c
void  http_ExtensionVersion ( char** text ) ;
// DWORD http_ExtensionProc(EXTENSION_CONTROL_BLOCK) - (i) language c
DWORD http_ExtensionProc ( EXTENSION_CONTROL_BLOCK *pECB ) ;
// boolean http_TerminateExtension( DWORD flag ) - (i) language c
BOOL  http_TerminateExtension( DWORD dwFlags ) ;


//  Global critical section
CRITICAL_SECTION        _gcs ;



//  BOOL WINAPI GetExtensionVersion (HSE_VERSION_INFO *pVersionInfo)
//
//  Return the version this server is built for.  See <httpext.h> for
//  a prototype.  This function is required by the spec.
//

BOOL WINAPI GetExtensionVersion (HSE_VERSION_INFO *pVersionInfo)
{
    char *version_text ;
    STACKMARK stm = MEM_MarkGStack ();

    // set version to httpext.h version constants
    pVersionInfo->dwExtensionVersion = MAKELONG (HSE_VERSION_MINOR, HSE_VERSION_MAJOR);

    http_ExtensionVersion(&version_text) ;

    lstrcpyn ((LPTSTR) pVersionInfo->lpszExtensionDesc,
              version_text,
              HSE_MAX_EXT_DLL_NAME_LEN);

    MEM_ReleaseGStack ( stm ) ;

#ifdef NO_SPECIAL_INI
        InitializeCriticalSection(&_gcs) ;
#endif

    return TRUE;
} // GetExtensionVersion()



//
//  Our entry point:
//
//  BOOL WINAPI HttpExtensionProc (EXTENSION_CONTROL_BLOCK *pECB)
//
//


DWORD WINAPI HttpExtensionProc (EXTENSION_CONTROL_BLOCK *pECB)
{

      DWORD retc ;
      unsigned savedSP ;

          EnterCriticalSection(&_gcs) ;

          savedSP = GETSP;

      if ( RUN_StackTrap() ) {
                if ((! RUN_StackTrap()) && RUN_GetErrorFlag()) {
                                retc = HSE_STATUS_ERROR ;
                }
      }
      else if ( ! RUN_StackBTrack() ) {
                 STACKMARK stm = MEM_MarkGStack ();
         retc = http_ExtensionProc(pECB) ;
                 MEM_ReleaseGStack ( stm ) ;
      }

      RUN_RemoveTrap( savedSP );                        /* Remove the trap       */

          LeaveCriticalSection(&_gcs) ;

    return retc ;

}  // HttpExtensionProc()



//
//   Entry point which is called by the server
// before termination
//
BOOL  WINAPI   TerminateExtension( DWORD dwFlags )
{

      BOOL retc ;
      unsigned savedSP ;

          savedSP = GETSP;

      if ( RUN_StackTrap() ) {
                if ((! RUN_StackTrap()) && RUN_GetErrorFlag()) {
                                retc = TRUE ;
                }
      }
      else if ( ! RUN_StackBTrack() ) {
                 STACKMARK stm = MEM_MarkGStack ();
         retc = http_TerminateExtension(dwFlags) ;
                 MEM_ReleaseGStack ( stm ) ;
      }

      RUN_RemoveTrap( savedSP );                        /* Remove the trap       */

#ifdef NO_SPECIAL_INI
          if( (dwFlags & HSE_TERM_MUST_UNLOAD)  ||  (retc == TRUE) ) {
                DeleteCriticalSection(&_gcs) ;
          }
#endif

    return retc ;
}


//
// Access to connId field
//

DWORD http_ConnID (
         EXTENSION_CONTROL_BLOCK *pECB
                  )
{
 return (DWORD) pECB->ConnID ;
}



void http_SetStatusCode (
          EXTENSION_CONTROL_BLOCK *pECB ,
          DWORD StatusCode
                        )
{
 pECB->dwHttpStatusCode = StatusCode ;
}


//
// Access to request method field
//

void http_Method (
         EXTENSION_CONTROL_BLOCK *pECB ,
         char** method_str
                 )
{
 *method_str = MEM_SaveStringGStack(pECB->lpszMethod);
}



//
// Access to query string field
//

void http_QueryString (
         EXTENSION_CONTROL_BLOCK *pECB ,
         char** query_str
                      )
{
 *query_str = MEM_SaveStringGStack(pECB->lpszQueryString);
}



//
// Access to content type field
//

void http_ContentType (
         EXTENSION_CONTROL_BLOCK *pECB ,
         char** type_str
                      )
{
 *type_str = MEM_SaveStringGStack(pECB->lpszContentType);
}



//
// Access to content length field
//

DWORD http_ContentLength ( EXTENSION_CONTROL_BLOCK *pECB )
{
 return pECB->cbTotalBytes ;
}



//
// Access to available bytes count
//

DWORD http_AvailableBytes ( EXTENSION_CONTROL_BLOCK *pECB )
{
 return pECB->cbAvailable ;
}



//
// Access to user data in binary form
//

void http_Data (
         EXTENSION_CONTROL_BLOCK *pECB ,
         void** data
                )
{

  *data = MEM_MakeBinaryGStack( pECB->cbAvailable );
  MEM_MovMem(pECB->lpbData,*data,pECB->cbAvailable);
}



//
// Access to user data in string form
//

void http_DataString (
         EXTENSION_CONTROL_BLOCK *pECB ,
         char** data
                     )
{

  *data = MEM_MakeBinaryGStack( pECB->cbAvailable+1 );
  MEM_MovMem(pECB->lpbData,*data,pECB->cbAvailable);
  *(*data+pECB->cbAvailable) = 0 ;
}



//
//   Server's GetServerVariable function call
//

BOOL http_GetServerVariable (
        EXTENSION_CONTROL_BLOCK *pECB ,
        char*  name ,
        char** value
                             )
{
 char buf[HSE_MAX_VARIABLE_LEN] ;
 DWORD bsize = HSE_MAX_VARIABLE_LEN ;

 BOOL retc = pECB->GetServerVariable(pECB->ConnID,name,buf,&bsize) ;

 if( retc == TRUE ) {
        *value = MEM_SaveStringGStack(buf);
 }
 return retc ;

}


//
//   Server's ReadClient function call
//

BOOL http_ReadClient (
                  EXTENSION_CONTROL_BLOCK *pECB ,
                  DWORD bytes_req ,
                  void** data ,
                  DWORD* bytes_read
                     )
{
 BOOL retc ;
 *data = MEM_MakeBinaryGStack( bytes_req );
 retc = pECB->ReadClient(pECB->ConnID,*data,&bytes_req) ;
 *bytes_read = bytes_req ;

 return retc ;
}


//
//   Server's WriteClient function call
//

BOOL http_WriteClient (
                  EXTENSION_CONTROL_BLOCK *pECB ,
                  DWORD bytes_req ,
                  void* data ,
                  DWORD* bytes_written
                      )
{
 BOOL retc ;

 retc = pECB->WriteClient(pECB->ConnID,data,&bytes_req,0) ;
 *bytes_written = bytes_req ;

 return retc ;
}


//
//   Server's WriteClient function call
//

BOOL http_WriteClientString (
                  EXTENSION_CONTROL_BLOCK *pECB ,
                  char* data ,
                  DWORD* bytes_written
                            )
{
 BOOL retc ;
 DWORD bytes_req ;

 bytes_req = lstrlen(data) ;
 retc = pECB->WriteClient(pECB->ConnID,data,&bytes_req,0) ;
 *bytes_written = bytes_req ;

 return retc ;
}



//
//  Server Support Function Call
//

BOOL http_ServerSupportFunction (
                  EXTENSION_CONTROL_BLOCK *pECB ,
                  DWORD request ,
                  DWORD bytes_req ,
                  void* data ,
                  LPDWORD data_type ,
                  DWORD* bytes_act
                                )
{
 BOOL retc ;

 retc = pECB->ServerSupportFunction(pECB->ConnID,request,data,&bytes_req,
                                   data_type) ;
 *bytes_act = bytes_req ;

 return retc ;
}


//
// WriteString writes an ASCII string to the web browser
//
static
void WriteString (EXTENSION_CONTROL_BLOCK *pECB, LPCTSTR lpsz)
{
    DWORD dwBytesWritten;

    dwBytesWritten = lstrlen (lpsz);
    pECB->WriteClient (pECB->ConnID, (PVOID) lpsz, &dwBytesWritten, 0);
}


void html_WriteString (EXTENSION_CONTROL_BLOCK *pECB, LPCTSTR lpsz)
{
     WriteString(pECB,lpsz) ;
}


//
// Text tools
//

void html_WriteText (EXTENSION_CONTROL_BLOCK *pECB, LPCTSTR lpsz)
{
        WriteString(pECB,lpsz) ;
}


void html_WriteTextLine (EXTENSION_CONTROL_BLOCK *pECB, LPCTSTR lpsz)
{
    WriteString (pECB, lpsz);
    WriteString (pECB, TEXT("\r\n"));
}


//
// html_CreatePage adds <HTML> and a title
//

void html_CreatePage (EXTENSION_CONTROL_BLOCK *pECB, LPCTSTR lpszTitle)
{


    DWORD dwWritten ;

    // Send content type

    TCHAR str[] = TEXT("Content-type: text/html\r\n");
    dwWritten = sizeof (str);
    pECB->ServerSupportFunction (pECB->ConnID,
                                 HSE_REQ_SEND_RESPONSE_HEADER,
                                 NULL,
                                 &dwWritten,
                                 (LPDWORD) str);



    WriteString (pECB, TEXT("<HTML>\r\n\r\n"));

    if (lpszTitle)
    {
        WriteString (pECB, TEXT("<HEAD><TITLE>"));
        html_WriteText (pECB, lpszTitle);
        WriteString (pECB, TEXT("</TITLE></HEAD>\r\n\r\n"));
    }

    WriteString (pECB, TEXT("<BODY>\r\n\r\n"));
}


void html_EndPage (EXTENSION_CONTROL_BLOCK *pECB)
{
    WriteString (pECB, TEXT("</BODY>\r\n\r\n"));
    WriteString (pECB, TEXT("</HTML>\r\n"));
}


//
// Heading tools
//

void html_BeginHeading (EXTENSION_CONTROL_BLOCK *pECB, int nHeading)
{
    TCHAR szCode[16];

    wsprintf (szCode, TEXT("<H%i>"), nHeading);
    WriteString (pECB, szCode);
}

void html_EndHeading (EXTENSION_CONTROL_BLOCK *pECB, int nHeading)
{
    TCHAR szCode[16];

    wsprintf (szCode, TEXT("</H%i>"), nHeading);
    WriteString (pECB, szCode);
}

void html_Heading (EXTENSION_CONTROL_BLOCK *pECB, int nHeading,
                  LPCTSTR lpszText)
{
    html_BeginHeading (pECB, nHeading);
    html_WriteText (pECB, lpszText);
    html_EndHeading (pECB, nHeading);
}



void html_EndParagraph (EXTENSION_CONTROL_BLOCK *pECB)
{
    WriteString (pECB, TEXT("<P>\r\n"));
}


//
// html_HyperLink adds a hyptertext link.  lpszDoc is the destination
// document, and lpszText is the display text.
//
// html_HyperLinkAndBookmark adds a hyperlink with a bookmark link.
// html_BookmarkLink adds only a bookmark link.
//

void html_HyperLink (EXTENSION_CONTROL_BLOCK *pECB, LPCTSTR lpszDoc, LPCTSTR lpszText)
{
    WriteString (pECB, TEXT("<A HREF=\""));
    html_WriteText (pECB, lpszDoc);
    WriteString (pECB, TEXT("\">"));
    html_WriteText (pECB, lpszText);
    WriteString (pECB, TEXT("</A>\r\n"));
}

void html_HyperLinkAndBookmark (EXTENSION_CONTROL_BLOCK *pECB,
                               LPCTSTR lpszDoc, LPCTSTR lpszBookmark,
                               LPCTSTR lpszText)
{
    WriteString (pECB, TEXT("<A HREF=\""));
    if (lpszDoc)
        html_WriteText (pECB, lpszDoc);
    WriteString (pECB, TEXT("#"));
    html_WriteText (pECB, lpszBookmark);
    WriteString (pECB, TEXT("\">"));
    html_WriteText (pECB, lpszText);
    WriteString (pECB, TEXT("</A>\r\n"));
}

void html_BookmarkLink (EXTENSION_CONTROL_BLOCK *pECB, LPCTSTR lpszBookmark,
                       LPCTSTR lpszText)
{
    html_HyperLinkAndBookmark (pECB, NULL, lpszBookmark, lpszText);
}



void html_SetBookMark ( EXTENSION_CONTROL_BLOCK *pECB,
                                                 LPCTSTR lpszBookmark)
{
        WriteString (pECB, TEXT("<A NAME=\""));
    html_WriteText (pECB, lpszBookmark);
    WriteString (pECB, TEXT("\">"));
    WriteString (pECB, TEXT("</A>\r\n"));
}


//
// The following support list formatting.
//

void html_BeginUnnumberedList (EXTENSION_CONTROL_BLOCK *pECB)
{
    WriteString (pECB, TEXT("<UL>\r\n"));
}

void html_BeginListItem (EXTENSION_CONTROL_BLOCK *pECB)
{
    WriteString (pECB, TEXT("<LI>"));
}

void html_EndUnnumberedList (EXTENSION_CONTROL_BLOCK *pECB)
{
    WriteString (pECB, TEXT("</UL>"));
}

void html_BeginNumberedList (EXTENSION_CONTROL_BLOCK *pECB)
{
    WriteString (pECB, TEXT("<OL>"));
}

void html_EndNumberedList (EXTENSION_CONTROL_BLOCK *pECB)
{
    WriteString (pECB, TEXT("</OL>"));
}

void html_BeginDefinitionList (EXTENSION_CONTROL_BLOCK *pECB)
{
    WriteString (pECB, TEXT("<DL>"));
}

void html_EndDefinitionList (EXTENSION_CONTROL_BLOCK *pECB)
{
    WriteString (pECB, TEXT("</DL>"));
}

void html_Definition (EXTENSION_CONTROL_BLOCK *pECB, LPCTSTR lpszTerm,
                     LPTSTR lpszDef)
{
    int nStart, nEnd, nLen;
    TCHAR tcHolder;

    WriteString (pECB, TEXT("<DT> "));
    html_WriteText (pECB, lpszTerm);
    WriteString (pECB, TEXT("\r\n"));
    WriteString (pECB, TEXT("<DD> "));

    nStart = 0 ;
    nLen = lstrlen (lpszDef);
    do  {
        nEnd = nStart + 70;
        if (nEnd >= nLen)
        {
            html_WriteText (pECB, &lpszDef[nStart]);
            WriteString (pECB, TEXT("\r\n"));
            break;
        }

        while (nEnd > nStart)
            if (lpszDef[nEnd] == TEXT(' '))
                break;

        if (nEnd == nStart)
            // too long!
            nEnd = nStart + 70;

        // write defintion segment
        tcHolder = lpszDef[nEnd];
        lpszDef[nEnd] = 0;
        html_WriteText (pECB, &lpszDef[nStart]);
        WriteString (pECB, TEXT("\r\n"));
        lpszDef[nEnd] = tcHolder;
        nStart = nEnd;

        // skip excess whitespace
        while (lpszDef[nStart] == TEXT(' '))
            nStart++;

        // pretty formatting
        if (nStart < nLen)
            WriteString (pECB, TEXT("     "));
    } while (nStart < nLen);
}

// For complex defintions
void html_BeginDefinitionTerm (EXTENSION_CONTROL_BLOCK *pECB)
{
    WriteString (pECB, TEXT("<DT>"));
}

void html_BeginDefinition (EXTENSION_CONTROL_BLOCK *pECB)
{
    WriteString (pECB, TEXT("<DD>"));
}


//
// Text formatting
//

void html_BeginPreformattedText (EXTENSION_CONTROL_BLOCK *pECB)
{
    WriteString (pECB, TEXT("<PRE>"));
}

void html_EndPreformattedText (EXTENSION_CONTROL_BLOCK *pECB)
{
    WriteString (pECB, TEXT("</PRE>"));
}

void html_BeginBlockQuote (EXTENSION_CONTROL_BLOCK *pECB)
{
    WriteString (pECB, TEXT("<BLOCKQUOTE>"));
}

void html_EndBlockQuote (EXTENSION_CONTROL_BLOCK *pECB)
{
    WriteString (pECB, TEXT("</BLOCKQUOTE>"));
}

void html_BeginAddress (EXTENSION_CONTROL_BLOCK *pECB)
{
    WriteString (pECB, TEXT("<ADDRESS>"));
}

void html_EndAddress (EXTENSION_CONTROL_BLOCK *pECB)
{
    WriteString (pECB, TEXT("</ADDRESS>"));
}

void html_BeginDefine (EXTENSION_CONTROL_BLOCK *pECB)
{
    WriteString (pECB, TEXT("<DFN>"));
}

void html_EndDefine (EXTENSION_CONTROL_BLOCK *pECB)
{
    WriteString (pECB, TEXT("</DFN>"));
}

void html_BeginEmphasis (EXTENSION_CONTROL_BLOCK *pECB)
{
    WriteString (pECB, TEXT("<EM>"));
}

void html_EndEmphasis (EXTENSION_CONTROL_BLOCK *pECB)
{
    WriteString (pECB, TEXT("</EM>"));
}

void html_BeginCitation (EXTENSION_CONTROL_BLOCK *pECB)
{
    WriteString (pECB, TEXT("<CITE>"));
}

void html_EndCitation (EXTENSION_CONTROL_BLOCK *pECB)
{
    WriteString (pECB, TEXT("</CITE>"));
}

void html_BeginCode (EXTENSION_CONTROL_BLOCK *pECB)
{
    WriteString (pECB, TEXT("<CODE>"));
}

void html_EndCode (EXTENSION_CONTROL_BLOCK *pECB)
{
    WriteString (pECB, TEXT("</CODE>"));
}

void html_BeginKeyboard (EXTENSION_CONTROL_BLOCK *pECB)
{
    WriteString (pECB, TEXT("<KBD>"));
}

void html_EndKeyboard (EXTENSION_CONTROL_BLOCK *pECB)
{
    WriteString (pECB, TEXT("</KBD>"));
}

void html_BeginSample (EXTENSION_CONTROL_BLOCK *pECB)
{
    WriteString (pECB, TEXT("<SAMP>"));
}

void html_EndSample (EXTENSION_CONTROL_BLOCK *pECB)
{
    WriteString (pECB, TEXT("</SAMP>"));
}

void html_BeginStrong (EXTENSION_CONTROL_BLOCK *pECB)
{
    WriteString (pECB, TEXT("<STRONG>"));
}

void html_EndStrong (EXTENSION_CONTROL_BLOCK *pECB)
{
    WriteString (pECB, TEXT("</STRONG>"));
}

void html_BeginVariable (EXTENSION_CONTROL_BLOCK *pECB)
{
    WriteString (pECB, TEXT("<VAR>"));
}

void html_EndVariable (EXTENSION_CONTROL_BLOCK *pECB)
{
    WriteString (pECB, TEXT("</VAR>"));
}

void html_BeginBold (EXTENSION_CONTROL_BLOCK *pECB)
{
    WriteString (pECB, TEXT("<B>"));
}

void html_EndBold (EXTENSION_CONTROL_BLOCK *pECB)
{
    WriteString (pECB, TEXT("</B>"));
}

void html_Bold (EXTENSION_CONTROL_BLOCK *pECB, LPCTSTR lpszText)
{
    html_BeginBold (pECB);
    html_WriteText (pECB, lpszText);
    html_EndBold (pECB);
}

void html_BeginItalic (EXTENSION_CONTROL_BLOCK *pECB)
{
    WriteString (pECB, TEXT("<I>"));
}

void html_EndItalic (EXTENSION_CONTROL_BLOCK *pECB)
{
    WriteString (pECB, TEXT("</I>"));
}


void html_Italic (EXTENSION_CONTROL_BLOCK *pECB, LPCTSTR lpszText)
{
    html_BeginItalic (pECB);
    html_WriteText (pECB, lpszText);
    html_EndItalic (pECB);
}

void html_BeginFixed (EXTENSION_CONTROL_BLOCK *pECB)
{
    WriteString (pECB, TEXT("<TT>"));
}

void html_EndFixed (EXTENSION_CONTROL_BLOCK *pECB)
{
    WriteString (pECB, TEXT("</TT>"));
}


void html_Fixed (EXTENSION_CONTROL_BLOCK *pECB, LPCTSTR lpszText)
{
    html_BeginFixed (pECB);
    html_WriteText (pECB, lpszText);
    html_EndFixed (pECB);
}


//
// Line breaks and other formatting
//

void html_LineBreak (EXTENSION_CONTROL_BLOCK *pECB)
{
    WriteString (pECB, TEXT("<BR>\r\n"));
}

void html_HorizontalRule (EXTENSION_CONTROL_BLOCK *pECB)
{
    WriteString (pECB, TEXT("\r\n<HR>\r\n"));
}


//
// Images
//

void html_Image (EXTENSION_CONTROL_BLOCK *pECB, LPCTSTR lpszPicFile,
                LPCTSTR lpszAltText)
{
    WriteString (pECB, TEXT("<IMG SRC = \""));
    html_WriteText (pECB, lpszPicFile);
    WriteString (pECB, TEXT("\""));
    if (lpszAltText)
        {
        WriteString (pECB, TEXT(" ALT = \""));
        html_WriteText (pECB, lpszAltText);
        WriteString (pECB, TEXT("\""));
        }
    WriteString (pECB, TEXT(">\r\n"));
}

