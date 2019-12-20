     The  ISAPI  directory  contains  the tools and declarations that simplify
development  of  the  ISAPI  (Internet  Server  API)  extensions for Microsoft
Internet Information Server and the examples of using them.
     An  ISAPI  extension  is  a  replaceable,  dynamic-link library (DLL) the
server  loads the first time it gets extension execution request. The DLL then
stays  in  memory, ready to service other requests until the server decides it
is  no  longer  needed.  This kind of ISAPI extension is also known as the ISA
(Internet Server Application).
     There  are  three  entry  points  for  this  DLL  -  GetExtensionVersion,
HttpExtensionProc  and  TerminateExtension.  The Server first calls the ISA at
the  entry  point of GetExtensionVersion to retrieve the version number of the
ISAPI specification on which the extension is based. For every client request,
the  HttpExtensionProc  entry  point  is  called.  Interaction between an HTTP
server and an ISA is done through extension control blocks (ECBs).
     More information on the ISAPI specification can be found in the Win32 SDK
documentation.


                Declarations.
                =============
        All declaration modules necessary to create ISAPI extensions
are located in TOOLS\INCLUDE directory.
        HTTPEXT.CON   -  definition of constants for status code to
                         be returned by the extension and for codes
                         to request services from the Server.
        HTTPEXT.DOM   -  definition of the EXTENSION_CONTROL_BLOCK domain.
        HTTPEXT.PRE   -  declaration of the entry points and extension layer
                         predicates
        HTMLFUN.PRE  -   declaration of the HTML authoring predicates.

                Entry Points.
                =============
        The Prolog programmer must implement three predicates representing
extension entry points :
  http_ExtensionVersion(string) - (o)
  DWORD http_ExtensionProc(EXTENSION_CONTROL_BLOCK) - (i)
  boolean http_TerminateExtension(DWORD _flags) - (i)
        They are declared in HTTPEXT.PRE and are called from
native DLL entry points.
       http_ExtensionVersion is called only once when the extension activates
to retrieve the short extension description.
       http_ExtensionProc is called to process every client request. The
possible return values are defined as constants in HTTPEXT.CON module.

                TOOLS
                =====
        The ISAPI tools are divided into two groups :
 - Extension tools which are the low level layer that gives access to
   ECB data fields and the Server callbacks.
   The predicates of this group are declared in HTTPEXT.PRE .
 - HTML authoring tools which simplify dynamic creation of the resulting HTML
   page. These predicates are declared in HTMLFUN.PRE .


                Library
                =======
     To use the ISAPI tools the programmer must insert to the project tree the
ISAPI.LIB   module   from   WWW\LIB\ISAPI\MSC  or  WWW\LIB\ISAPI\BC  directory
depending on the desired "Main Program".
        The source module the libraries are built from is located in the
WWW\ISAPI\SOURCE directory.

                Examples
                ========
        The SIMPLE1 and SIMPLE2 directories contain the simple example
projects with minimum source code and minimum functionality. They show
where to begin creating ISAPI extensions.
        The TEST1 and TEST2 directories contain more functional extensions.
They have almost the same visible functionality but differ in creating of the
resulting page - TEST1 example uses only HTML authoring predicates while in
TEST2 the page body is created through DOC/HTML conversion using DOC_TOOL package.
         Each directory contains HTML page that can be used to test the
extension.


        How to create ISAPI extension.
        ==============================
       1. Create a project for Windows32 Textmode or VPI Dll target.
       2. Add $(PRODIR)www\include\isapi to the Project include path.
       3. Add $(PRODIR)www\lib\isapi\{MSC|BC}\ISAPI.LIB to the list
          of project modules.
       4. Add GetExtensionVersion,HttpExtensionProc and TerminateExtension
          function names to the EXPORTS section of the project definition module.
       5. Add include statements for HTTPEXT.CON, HTTPEXT.DOM, HTTPEXT.PRE and
          HTMLFUN.PRE in your source module.
       6. Implement http_ExtensionVersion, http_ExtensionProc and http_TerminateExtension
          predicates.


