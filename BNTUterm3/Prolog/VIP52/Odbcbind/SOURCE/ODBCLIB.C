/******************************************************************************
		Copyright (c) 1984 - 1998 Prolog Development Center A/S

 FileName:	ODBCLIB.C
 Purpose:	ODBC binding
 Written by:	Sergey Alexeev
 Build:		008.981026
 Comments:	Tested with Borland C++ v.4.5 and MSC 5.0
******************************************************************************/
#include <windows.h>
#include <sql.h>
#include <sqlext.h>

#include "pdcrunt.h"

#include "odbclib.h"

#define odbc_dynamicaly

#ifdef odbc_dynamicaly

HINSTANCE   OdbcLib;

FARPROC SQLAllocConnectDyn;
FARPROC SQLAllocEnvDyn;
FARPROC SQLAllocStmtDyn;
FARPROC SQLBindColDyn;
FARPROC SQLCancelDyn;
FARPROC SQLColAttributesDyn;
FARPROC SQLConnectDyn;
FARPROC SQLDescribeColDyn;
FARPROC SQLDisconnectDyn;
FARPROC SQLErrorDyn;
FARPROC SQLExecDirectDyn;
FARPROC SQLExecuteDyn;
FARPROC SQLFetchDyn;
FARPROC SQLFreeConnectDyn;
FARPROC SQLFreeEnvDyn;
FARPROC SQLFreeStmtDyn;
FARPROC SQLGetCursorNameDyn;
FARPROC SQLNumResultColsDyn;
FARPROC SQLPrepareDyn;
FARPROC SQLRowCountDyn;
FARPROC SQLSetCursorNameDyn;
FARPROC SQLTransactDyn;
FARPROC SQLSetParamDyn;
FARPROC SQLColumnsDyn;
FARPROC SQLDriverConnectDyn;
FARPROC SQLGetConnectOptionDyn;
FARPROC SQLGetDataDyn;
FARPROC SQLGetFunctionsDyn;
FARPROC SQLGetInfoDyn;
FARPROC SQLGetStmtOptionDyn;
FARPROC SQLGetTypeInfoDyn;
FARPROC SQLParamDataDyn;
FARPROC SQLPutDataDyn;
FARPROC SQLSetConnectOptionDyn;
FARPROC SQLSetStmtOptionDyn;
FARPROC SQLSpecialColumnsDyn;
FARPROC SQLStatisticsDyn;
FARPROC SQLTablesDyn;
FARPROC SQLBrowseConnectDyn;
FARPROC SQLColumnPrivilegesDyn;
FARPROC SQLDataSourcesDyn;
FARPROC SQLDescribeParamDyn;
FARPROC SQLExtendedFetchDyn;
FARPROC SQLForeignKeysDyn;
FARPROC SQLMoreResultsDyn;
FARPROC SQLNativeSqlDyn;
FARPROC SQLNumParamsDyn;
FARPROC SQLParamOptionsDyn;
FARPROC SQLPrimaryKeysDyn;
FARPROC SQLProcedureColumnsDyn;
FARPROC SQLProceduresDyn;
FARPROC SQLSetPosDyn;
FARPROC SQLTablePrivilegesDyn;
FARPROC SQLDriversDyn;
FARPROC SQLBindParameterDyn;
FARPROC SQLSetScrollOptionsDyn;

#define SQLAllocConnect       (*SQLAllocConnectDyn)
#define SQLAllocEnv           (*SQLAllocEnvDyn)
#define SQLAllocStmt          (*SQLAllocStmtDyn)
#define SQLBindCol            (*SQLBindColDyn)
#define SQLCancel             (*SQLCancelDyn)
#define SQLColAttributes      (*SQLColAttributesDyn)
#define SQLConnect            (*SQLConnectDyn)
#define SQLDescribeCol        (*SQLDescribeColDyn)
#define SQLDisconnect         (*SQLDisconnectDyn)
#define SQLError              (*SQLErrorDyn)
#define SQLExecDirect         (*SQLExecDirectDyn)
#define SQLExecute            (*SQLExecuteDyn)
#define SQLFetch              (*SQLFetchDyn)
#define SQLFreeConnect        (*SQLFreeConnectDyn)
#define SQLFreeEnv            (*SQLFreeEnvDyn)
#define SQLFreeStmt           (*SQLFreeStmtDyn)
#define SQLGetCursorName      (*SQLGetCursorNameDyn)
#define SQLNumResultCols      (*SQLNumResultColsDyn)
#define SQLPrepare            (*SQLPrepareDyn)
#define SQLRowCount           (*SQLRowCountDyn)
#define SQLSetCursorName      (*SQLSetCursorNameDyn)
#define SQLTransact           (*SQLTransactDyn)
#define SQLSetParam           (*SQLSetParamDyn)
#define SQLColumns            (*SQLColumnsDyn)
#define SQLDriverConnect      (*SQLDriverConnectDyn)
#define SQLGetConnectOption   (*SQLGetConnectOptionDyn)
#define SQLGetData            (*SQLGetDataDyn)
#define SQLGetFunctions       (*SQLGetFunctionsDyn)
#define SQLGetInfo            (*SQLGetInfoDyn)
#define SQLGetStmtOption      (*SQLGetStmtOptionDyn)
#define SQLGetTypeInfo        (*SQLGetTypeInfoDyn)
#define SQLParamData          (*SQLParamDataDyn)
#define SQLPutData            (*SQLPutDataDyn)
#define SQLSetConnectOption   (*SQLSetConnectOptionDyn)
#define SQLSetStmtOption      (*SQLSetStmtOptionDyn)
#define SQLSpecialColumns     (*SQLSpecialColumnsDyn)
#define SQLStatistics         (*SQLStatisticsDyn)
#define SQLTables             (*SQLTablesDyn)
#define SQLBrowseConnect      (*SQLBrowseConnectDyn)
#define SQLColumnPrivileges   (*SQLColumnPrivilegesDyn)
#define SQLDataSources        (*SQLDataSourcesDyn)
#define SQLDescribeParam      (*SQLDescribeParamDyn)
#define SQLExtendedFetch      (*SQLExtendedFetchDyn)
#define SQLForeignKeys        (*SQLForeignKeysDyn)
#define SQLMoreResults        (*SQLMoreResultsDyn)
#define SQLNativeSql          (*SQLNativeSqlDyn)
#define SQLNumParams          (*SQLNumParamsDyn)
#define SQLParamOptions       (*SQLParamOptionsDyn)
#define SQLPrimaryKeys        (*SQLPrimaryKeysDyn)
#define SQLProcedureColumns   (*SQLProcedureColumnsDyn)
#define SQLProcedures         (*SQLProceduresDyn)
#define SQLSetPos             (*SQLSetPosDyn)
#define SQLTablePrivileges    (*SQLTablePrivilegesDyn)
#define SQLDrivers            (*SQLDriversDyn)
#define SQLBindParameter      (*SQLBindParameterDyn)
#define SQLSetScrollOptions   (*SQLSetScrollOptionsDyn)

#endif   /*(odbc_dynamicaly)*/

#ifdef WIN32
    #define SQL_C_INTEGER_X SQL_C_LONG
    #define SQL_INTEGER_X SQL_INTEGER
#else
    #define SQL_C_INTEGER_X SQL_C_SHORT
    #define SQL_INTEGER_X SQL_SMALLINT
#endif

typedef struct data_save_struct
{
    unsigned char fno;
    void *ptr;
    SDWORD size;
    SDWORD sizeoriginal;
} ODBC_SAVE_DATA;

#define DATASF    colSData->fno
#define DATASS    colSData->size
#define DATASP    colSData->ptr
#define DATASSO    colSData->sizeoriginal

#define DATAF     colData->fno
#define DATAS     colData->u.s
#define DATAI     colData->u.i
#define DATAL     colData->u.l
#define DATAR     colData->u.r

#define DATACOLF  colData->fno
#define DATACOLAI colData->u.ai
#define DATACOLCS colData->u.cs
#define DATACOLCO colData->u.co
#define DATACOLDS colData->u.ds
#define DATACOLLA colData->u.la
#define DATACOLLE colData->u.le
#define DATACOLMO colData->u.mo
#define DATACOLNA colData->u.na
#define DATACOLNU colData->u.nu
#define DATACOLON colData->u.on
#define DATACOLPR colData->u.pr
#define DATACOLQN colData->u.qn
#define DATACOLSC colData->u.sc
#define DATACOLSE colData->u.se
#define DATACOLTN colData->u.tn
#define DATACOLTY colData->u.ty
#define DATACOLTA colData->u.ta
#define DATACOLUN colData->u.un
#define DATACOLUP colData->u.up

#define DATAINFF  colData->fno
#define DATAINFI  colData->u.i
#define DATAINFL  colData->u.l
#define DATAINFS  colData->u.s
#define f_i 1
#define f_l 2
#define f_s 3

#define DATACOF      Param->fno
#define DATACOL      Param->u.l
#define DATACOS      Param->u.s

#define fco_l  1
#define fco_s  2

// ***** Local Functions Prototypes *****
void odbc_copy_str(char *inStr,char *outStr);
int  odbc_len_str(STRING str);
int  odbc_cmp_str(STRING str1,STRING str2);
void odbc_cut_str(STRING StrIn,unsigned CutByte,STRING StrOut,STRING Rest);
int  odbc_atoi(STRING);
void odbc_mem_copy(PTR source,PTR target,unsigned byte);
void odbcMyError(RETCODE retCode,STRING func,HENV henv,HDBC hdbc,HSTMT hstmt);
void odbcError(HENV henv,HDBC hdbc,HSTMT hstmt,STRING szErrorMsg);
void *odbc_alloc_ham(UNSIGNED DataType,UNSIGNED Size,HAM FAR *pHam);
void odbcErrorMy(STRING szErrorMsg);
void odbc_run_error(RETCODE reCode);
void odbc_check_loading(STRING func);

// ***** Local Data *****
static INTEGER    error_code=0;
static INTEGER    GlobErr=0;
static UCHAR      error_function[SQL_MAX_MESSAGE_LENGTH]="0";
static UCHAR      error_message[SQL_MAX_MESSAGE_LENGTH]="0";
static void       *pnt_ham[100];

// ***** Local Functions *****
void odbc_copy_str(char *inStr,char *outStr)
{
    int i;
    for(i=0;(outStr[i]=inStr[i])!=0;i++);
    return;
}

int odbc_len_str(STRING str)
{
    int i;
    for(i=0;str[i];i++);
    return(i);
}

int odbc_cmp_str(STRING str1,STRING str2)
{
    int i;
    for(i=0;str1[i];i++)
        if(str1[i]!=str2[i])
            return(0);
    return(1);
}

void odbc_cut_str(STRING StrIn,unsigned CutByte,STRING StrOut,STRING Rest)
{
    unsigned i,j;
    for(i=0;i<CutByte;i++)
        StrOut[i]=StrIn[i];
    StrOut[i]=0;
    for(j=0;(Rest[j]=StrIn[i])!=0;i++,j++);
    return;
}

int odbc_atoi(STRING str1)
{
    int len,i,j,mul,result;
    unsigned char str[20];
    for(i=0,j=0;str1[j];j++)
        if(str1[j]>=48&&str1[j]<=57)
        {
            str[i]=str1[j];
            i++;
        }
    str[i]=0;
    len=odbc_len_str(str);
    for(mul=1,result=0,i=len-1;i>=0;i--,mul=mul*10)
        result+=(int)(str[i]-48)*mul;
    return(result);
}

void odbc_mem_copy(PTR source,PTR target,unsigned byte)
{
    unsigned i;
    char *s,*t;
    s=source;
    t=target;
    for(i=0;i<byte;i++)
        t[i]=s[i];
    return;
}
// Global error code
#define ODBC_PROLOG_ERROR_00  8800
#define ODBC_PROLOG_ERROR_01  8801
#define ODBC_PROLOG_ERROR_02  8802
#define ODBC_PROLOG_ERROR_03  8803
#define ODBC_PROLOG_ERROR_04  8804
#define ODBC_PROLOG_ERROR_05  8805
#define ODBC_PROLOG_ERROR_06  8806

// Local error code
#define ODBC_SUCCESS       -1000
#define ODBC_ERROR         -1001
#define ODBC_UNKNOWN_HAM      -1002
#define ODBC_UNKNOWN_DATA_TYPE      -1003
#define ODBC_UNKNOWN_PARAM_TYPE     -1004
#define ODBC_UNKNOWN_COLUMN_TYPE -1005
#define ODBC_UNKNOWN_DIRECTION      -1006
#define ODBC_UNKNOWN_DRIVER_COMPLETION -1007
#define ODBC_UNKNOWN_OPTION      -1008
#define ODBC_UNKNOWN_FUNCTION    -1009
#define ODBC_UNKNOWN_INFO_TYPE      -1010
#define ODBC_UNKNOWN_PARAM_DATA     -1011
#define ODBC_UNKNOWN_LOCK     -1012
#define ODBC_UNKNOWN_CONCURRENCY -1013
#define ODBC_UNKNOWN_SCOPE    -1014
#define ODBC_UNKNOWN_NULLABLE    -1015
#define ODBC_UNKNOWN_UNIQUE      -1016
#define ODBC_UNKNOWN_ACCURACY    -1017
#define ODBC_UNKNOWN_TRANSACT_TYPE  -1018
#define ODBC_UNLOAD        -1019

void odbcMyError(RETCODE retCode,STRING func,HENV henv,HDBC hdbc,HSTMT hstmt)
{
    error_code=retCode;
    odbc_copy_str(func,error_function);
    switch(retCode)
    {
        case SQL_SUCCESS:
            odbc_copy_str("SQL_SUCCESS",error_message);
            return;
        case SQL_SUCCESS_WITH_INFO:
            odbc_copy_str("SQL_SUCCESS_WITH_INFO",error_message);
            return;
        case SQL_ERROR:
            odbcError(henv,hdbc,hstmt,error_message);
            break;
        case SQL_INVALID_HANDLE:
            odbc_copy_str("SQL_INVALID_HANDLE",error_message);
            break;
        case SQL_STILL_EXECUTING:
            odbc_copy_str("SQL_STILL_EXECUTING",error_message);
            break;
        case SQL_NEED_DATA:
            odbc_copy_str("SQL_NEED_DATA",error_message);
            break;
        case SQL_NO_DATA_FOUND:
            odbc_copy_str("SQL_NO_DATA_FOUND",error_message);
            break;
        case ODBC_SUCCESS:
            odbc_copy_str("ODBC_SUCCESS",error_message);
            return;
        case ODBC_ERROR:
            odbcErrorMy(error_message);
            break;
        default:
            odbc_copy_str("SQL_UNKNOWN_ERROR",error_message);
            break;
    }
    odbc_run_error(retCode);
    return;
}

void odbcError(HENV henv,HDBC hdbc,HSTMT hstmt,STRING szErrorMsg)
{
    UCHAR state[SQL_MAX_MESSAGE_LENGTH];
    SDWORD pfNativeError;
    SWORD pcbErrorMsg;
    SQLError((HENV)henv,(HDBC)hdbc,(HSTMT)hstmt,(UCHAR FAR *)state,(SDWORD FAR *)&pfNativeError,
            (UCHAR FAR *)szErrorMsg,(SWORD)SQL_MAX_MESSAGE_LENGTH,(SWORD FAR *)&pcbErrorMsg);
    return;
}

void odbcErrorMy(STRING szErrorMsg)
{
    switch(GlobErr)
    {
        case(ODBC_UNKNOWN_HAM):
            odbc_copy_str("[ODBC_BIND] HAM is not reserved",szErrorMsg);
            break;
        case(ODBC_UNKNOWN_DATA_TYPE):
            odbc_copy_str("[ODBC_BIND] Illegal data type",szErrorMsg);
            break;
        case(ODBC_UNKNOWN_PARAM_TYPE):
            odbc_copy_str("[ODBC_BIND] Illegal param type",szErrorMsg);
            break;
        case(ODBC_UNKNOWN_COLUMN_TYPE):
            odbc_copy_str("[ODBC_BIND] Illegal column type",szErrorMsg);
            break;
        case(ODBC_UNKNOWN_DIRECTION):
            odbc_copy_str("[ODBC_BIND] Illegal direction",szErrorMsg);
            break;
        case(ODBC_UNKNOWN_DRIVER_COMPLETION):
            odbc_copy_str("[ODBC_BIND] Illegal driver completion",szErrorMsg);
            break;
        case(ODBC_UNKNOWN_OPTION):
            odbc_copy_str("[ODBC_BIND] Illegal option",szErrorMsg);
            break;
        case(ODBC_UNKNOWN_FUNCTION):
            odbc_copy_str("[ODBC_BIND] Illegal function number",szErrorMsg);
            break;
        case(ODBC_UNKNOWN_INFO_TYPE):
            odbc_copy_str("[ODBC_BIND] Illegal info type",szErrorMsg);
            break;
        case(ODBC_UNKNOWN_PARAM_DATA):
            odbc_copy_str("[ODBC_BIND] Illegal constant in param",szErrorMsg);
            break;
        case(ODBC_UNKNOWN_LOCK):
            odbc_copy_str("[ODBC_BIND] Illegal lock",szErrorMsg);
            break;
        case(ODBC_UNKNOWN_CONCURRENCY):
            odbc_copy_str("[ODBC_BIND] Illegal concurrency",szErrorMsg);
            break;
        case(ODBC_UNKNOWN_SCOPE):
            odbc_copy_str("[ODBC_BIND] Illegal scope",szErrorMsg);
            break;
        case(ODBC_UNKNOWN_NULLABLE):
            odbc_copy_str("[ODBC_BIND] Illegal nullable",szErrorMsg);
            break;
        case(ODBC_UNKNOWN_UNIQUE):
            odbc_copy_str("[ODBC_BIND] Illegal unique",szErrorMsg);
            break;
        case(ODBC_UNKNOWN_ACCURACY):
            odbc_copy_str("[ODBC_BIND] Illegal accuracy",szErrorMsg);
            break;
        case(ODBC_UNKNOWN_TRANSACT_TYPE):
            odbc_copy_str("[ODBC_BIND] Illegal transact type",szErrorMsg);
            break;
        case(ODBC_UNLOAD):
            odbc_copy_str("[ODBC_BIND] ODBC is not initialize",szErrorMsg);
            break;
    }
    return;
}

void odbc_run_error(RETCODE retCode)
{
    switch(retCode)
    {
        case SQL_INVALID_HANDLE      : RUN_Error(ODBC_PROLOG_ERROR_01);  break;
        case SQL_STILL_EXECUTING     : RUN_Error(ODBC_PROLOG_ERROR_02);  break;
        case SQL_NEED_DATA        : RUN_Error(ODBC_PROLOG_ERROR_03);  break;
        case SQL_NO_DATA_FOUND       : RUN_Error(ODBC_PROLOG_ERROR_04);  break;
        case SQL_ERROR            : RUN_Error(ODBC_PROLOG_ERROR_05);  break;
        case ODBC_ERROR        : RUN_Error(ODBC_PROLOG_ERROR_06);  break;
        default          : RUN_Error(ODBC_PROLOG_ERROR_00);  break;
    }
    return;
}

void *odbc_alloc_ham(UNSIGNED DataType,UNSIGNED Size,HAM FAR *pHam)
{
    ODBC_SAVE_DATA  *colSData;
    int i;

    colSData=MEM_AllocHeap(sizeof(ODBC_SAVE_DATA));
    DATASF=(unsigned char)DataType;
    switch(DataType)
    {
        case(ODBC_STRING):
        case(ODBC_MEMO):
        case(ODBC_BINARY):
        case(ODBC_NUMERIC):
            DATASSO=DATASS=Size;
            DATASP=MEM_AllocHeap(Size);
            break;
        case(ODBC_BIT):
        case(ODBC_BYTE):
        case(ODBC_INTEGER):
            DATASSO=DATASS=sizeof(short);
            DATASP=MEM_AllocHeap(sizeof(short));
            break;
        case(ODBC_LONG):
            DATASSO=DATASS=sizeof(long);
            DATASP=MEM_AllocHeap(sizeof(long));
            break;
        case(ODBC_FLOAT):
        case(ODBC_REAL):
            DATASSO=DATASS=sizeof(double);
            DATASP=MEM_AllocHeap(sizeof(double));
            break;
        case(ODBC_DATE):
            DATASSO=DATASS=sizeof(DATE_STRUCT);
            DATASP=MEM_AllocHeap(sizeof(TIMESTAMP_STRUCT));
            break;
        case(ODBC_TIME):
            DATASSO=DATASS=sizeof(TIME_STRUCT);
            DATASP=MEM_AllocHeap(sizeof(TIMESTAMP_STRUCT));
            break;
        case(ODBC_TIMESTAMP):
            DATASSO=DATASS=sizeof(TIMESTAMP_STRUCT);
            DATASP=MEM_AllocHeap(sizeof(TIMESTAMP_STRUCT));
            break;
	}
    *pHam=(HAM)colSData;
    for(i=0;i<100;i++)
        if(!pnt_ham[i])
        {
            pnt_ham[i]=colSData;
            break;
        }
    return(DATASP);
}

void odbc_check_loading(STRING func)
{
    #ifdef odbc_dynamicaly
        if((long)OdbcLib<=21)
        {
            GlobErr=ODBC_UNLOAD;
            odbcMyError(ODBC_ERROR,func,SQL_NULL_HENV,SQL_NULL_HDBC,SQL_NULL_HSTMT);
        }
    #endif
    return;
}

// ***** Global Functions *****
// Init
void odbcInit()
{
    #ifdef odbc_dynamicaly
        #ifdef WIN32
            OdbcLib=LoadLibrary ("odbc32.dll");
        #else
            OdbcLib=LoadLibrary ("odbc.dll");
        #endif
        if((long)OdbcLib>21)
        {
            SQLAllocConnectDyn=GetProcAddress(OdbcLib,"SQLAllocConnect");
            SQLAllocEnvDyn=GetProcAddress(OdbcLib,"SQLAllocEnv");
            SQLAllocStmtDyn=GetProcAddress(OdbcLib,"SQLAllocStmt");
            SQLBindColDyn=GetProcAddress(OdbcLib,"SQLBindCol");
            SQLCancelDyn=GetProcAddress(OdbcLib,"SQLCancel");
            SQLColAttributesDyn=GetProcAddress(OdbcLib,"SQLColAttributes");
            SQLConnectDyn=GetProcAddress(OdbcLib,"SQLConnect");
            SQLDescribeColDyn=GetProcAddress(OdbcLib,"SQLDescribeCol");
            SQLDisconnectDyn=GetProcAddress(OdbcLib,"SQLDisconnect");
            SQLErrorDyn=GetProcAddress(OdbcLib,"SQLError");
            SQLExecDirectDyn=GetProcAddress(OdbcLib,"SQLExecDirect");
            SQLExecuteDyn=GetProcAddress(OdbcLib,"SQLExecute");
            SQLFetchDyn=GetProcAddress(OdbcLib,"SQLFetch");
            SQLFreeConnectDyn=GetProcAddress(OdbcLib,"SQLFreeConnect");
            SQLFreeEnvDyn=GetProcAddress(OdbcLib,"SQLFreeEnv");
            SQLFreeStmtDyn=GetProcAddress(OdbcLib,"SQLFreeStmt");
            SQLGetCursorNameDyn=GetProcAddress(OdbcLib,"SQLGetCursorName");
            SQLNumResultColsDyn=GetProcAddress(OdbcLib,"SQLNumResultCols");
            SQLPrepareDyn=GetProcAddress(OdbcLib,"SQLPrepare");
            SQLRowCountDyn=GetProcAddress(OdbcLib,"SQLRowCount");
            SQLSetCursorNameDyn=GetProcAddress(OdbcLib,"SQLSetCursorName");
            SQLTransactDyn=GetProcAddress(OdbcLib,"SQLTransact");
            SQLSetParamDyn=GetProcAddress(OdbcLib,"SQLSetParam");
            SQLColumnsDyn=GetProcAddress(OdbcLib,"SQLColumns");
            SQLDriverConnectDyn=GetProcAddress(OdbcLib,"SQLDriverConnect");
            SQLGetConnectOptionDyn=GetProcAddress(OdbcLib,"SQLGetConnectOption");
            SQLGetDataDyn=GetProcAddress(OdbcLib,"SQLGetData");
            SQLGetFunctionsDyn=GetProcAddress(OdbcLib,"SQLGetFunctions");
            SQLGetInfoDyn=GetProcAddress(OdbcLib,"SQLGetInfo");
            SQLGetStmtOptionDyn=GetProcAddress(OdbcLib,"SQLGetStmtOption");
            SQLGetTypeInfoDyn=GetProcAddress(OdbcLib,"SQLGetTypeInfo");
            SQLParamDataDyn=GetProcAddress(OdbcLib,"SQLParamData");
            SQLPutDataDyn=GetProcAddress(OdbcLib,"SQLPutData");
            SQLSetConnectOptionDyn=GetProcAddress(OdbcLib,"SQLSetConnectOption");
            SQLSetStmtOptionDyn=GetProcAddress(OdbcLib,"SQLSetStmtOption");
            SQLSpecialColumnsDyn=GetProcAddress(OdbcLib,"SQLSpecialColumns");
            SQLStatisticsDyn=GetProcAddress(OdbcLib,"SQLStatistics");
            SQLTablesDyn=GetProcAddress(OdbcLib,"SQLTables");
            SQLBrowseConnectDyn=GetProcAddress(OdbcLib,"SQLBrowseConnect");
            SQLColumnPrivilegesDyn=GetProcAddress(OdbcLib,"SQLColumnPrivileges");
            SQLDataSourcesDyn=GetProcAddress(OdbcLib,"SQLDataSources");
            SQLDescribeParamDyn=GetProcAddress(OdbcLib,"SQLDescribeParam");
            SQLExtendedFetchDyn=GetProcAddress(OdbcLib,"SQLExtendedFetch");
            SQLForeignKeysDyn=GetProcAddress(OdbcLib,"SQLForeignKeys");
            SQLMoreResultsDyn=GetProcAddress(OdbcLib,"SQLMoreResults");
            SQLNativeSqlDyn=GetProcAddress(OdbcLib,"SQLNativeSql");
            SQLNumParamsDyn=GetProcAddress(OdbcLib,"SQLNumParams");
            SQLParamOptionsDyn=GetProcAddress(OdbcLib,"SQLParamOptions");
            SQLPrimaryKeysDyn=GetProcAddress(OdbcLib,"SQLPrimaryKeys");
            SQLProcedureColumnsDyn=GetProcAddress(OdbcLib,"SQLProcedureColumns");
            SQLProceduresDyn=GetProcAddress(OdbcLib,"SQLProcedures");
            SQLSetPosDyn=GetProcAddress(OdbcLib,"SQLSetPos");
            SQLTablePrivilegesDyn=GetProcAddress(OdbcLib,"SQLTablePrivileges");
            SQLDriversDyn=GetProcAddress(OdbcLib,"SQLDrivers");
            SQLBindParameterDyn=GetProcAddress(OdbcLib,"SQLBindParameter");
            SQLSetScrollOptionsDyn=GetProcAddress(OdbcLib,"SQLSetScrollOptions");
        }
        else
        RUN_Fail();
    #endif
    return;
}
// Destroy
void odbcDestroy(void)
{
    #ifdef odbc_dynamicaly
        if((long)OdbcLib>21)
            FreeLibrary(OdbcLib);
    #endif
    return;
}
// GetError
void odbcGetError(INTEGER FAR *ErrCode,STRING FAR *ErrFunc,STRING FAR *ErrMess)
{
    *ErrCode=error_code;
    *ErrFunc=MEM_SaveStringGStack(error_function);
    *ErrMess=MEM_SaveStringGStack(error_message);
    return;
}
// ***** Native Functions *****
// AllocConnect
void odbcAllocConnect(HENV henv,HDBC FAR *phdbc)
{
    odbc_check_loading("odbcAllocConnect");
    odbcMyError(
      (RETCODE)SQLAllocConnect((HENV)henv,(HDBC FAR *)phdbc),
      "SQLAllocConnect",henv,SQL_NULL_HDBC,SQL_NULL_HSTMT);
    return;
}
// AllocEnv
void odbcAllocEnv(HENV FAR *phenv)
{
    odbc_check_loading("odbcAllocEnv");
    odbcMyError(
        (RETCODE)SQLAllocEnv((HENV FAR *)phenv),
        "SQLAllocEnv",SQL_NULL_HENV,SQL_NULL_HDBC,SQL_NULL_HSTMT);
    return;
}
// AllocStmt
void odbcAllocStmt(HENV henv,HDBC hdbc,HSTMT FAR *phstmt)
{
    odbc_check_loading("odbcAllocStmt");
    odbcMyError(
        (RETCODE)SQLAllocStmt((HDBC)hdbc,(HSTMT FAR *)phstmt),
        "SQLAllocStmt",henv,hdbc,SQL_NULL_HSTMT);
    return;
}
// BindCol
void odbcBindCol(HENV henv,HDBC hdbc,HSTMT hstmt,UNSIGNED icol,UNSIGNED dataType,
    UNSIGNED BufferLen,HAM FAR *pHam)
{
    SWORD     fCType;
    PTR       rgbValue;
    ODBC_SAVE_DATA  *colSData;
    odbc_check_loading("odbcBindCol");
    switch(dataType)
    {
        case(ODBC_STRING)   : fCType=SQL_C_CHAR;       break;
        case(ODBC_BIT)      : fCType=SQL_C_BIT;        break;
        case(ODBC_BYTE)     : fCType=SQL_C_UTINYINT;   break;
        case(ODBC_INTEGER)  : fCType=SQL_C_INTEGER_X;  break;
        case(ODBC_LONG)     : fCType=SQL_C_LONG;	   break;
        case(ODBC_FLOAT)    : fCType=SQL_C_FLOAT;      break;
        case(ODBC_REAL)     : fCType=SQL_C_DOUBLE;     break;
        case(ODBC_DATE)     : fCType=SQL_C_DATE;       break;
        case(ODBC_TIME)     : fCType=SQL_C_TIME;       break;
        case(ODBC_TIMESTAMP): fCType=SQL_C_TIMESTAMP;  break;
        case(ODBC_BINARY)   : fCType=SQL_C_BINARY;     break;
        case(ODBC_NUMERIC)  : fCType=SQL_C_CHAR;       break;
        case(ODBC_MEMO)		: fCType=SQL_C_CHAR;       break;
        default:
            GlobErr=ODBC_UNKNOWN_DATA_TYPE;
            odbcMyError(ODBC_ERROR,"odbcBindCol",SQL_NULL_HENV,SQL_NULL_HDBC,SQL_NULL_HSTMT);
            break;
    }
    rgbValue=odbc_alloc_ham(dataType,BufferLen,pHam);
    colSData=(ODBC_SAVE_DATA *)*pHam;
    odbcMyError(
        (RETCODE)SQLBindCol((HSTMT)hstmt,(UWORD)icol,(SWORD)fCType,(PTR)rgbValue,(UWORD)BufferLen,(SDWORD FAR *)&DATASS),
        "SQLBindCol",henv,hdbc,hstmt);
    return;
}
// BindParameter
void odbcBindParameter(HENV henv,HDBC hdbc,HSTMT hstmt,UNSIGNED ipar,UNSIGNED ParamType,
	 UNSIGNED dataType,UDWORD Precision,INTEGER Scale,UNSIGNED BufferLen,HAM FAR *pHam)
{
	 SWORD     fParamType;
    SWORD     fCType;
    SWORD     fSqlType;
    PTR       rgbValue;
    ODBC_SAVE_DATA  *colSData;
    odbc_check_loading("odbcBindParameter");
    switch(ParamType)
    {
        case(ODBC_PARAM_INPUT)          : fParamType=SQL_PARAM_INPUT;          break;
        case(ODBC_PARAM_INPUT_OUTPUT)   : fParamType=SQL_PARAM_INPUT_OUTPUT;   break;
        default:
            GlobErr=ODBC_UNKNOWN_PARAM_TYPE;
            odbcMyError(ODBC_ERROR,"odbcBindParameter",SQL_NULL_HENV,SQL_NULL_HDBC,SQL_NULL_HSTMT);
            break;
    }
    switch(dataType)
    {
        case(ODBC_STRING)   : fCType=SQL_C_CHAR;       fSqlType=SQL_CHAR;      break;
        case(ODBC_BIT)      : fCType=SQL_C_BIT;        fSqlType=SQL_BIT;       break;
        case(ODBC_BYTE)     : fCType=SQL_C_UTINYINT;   fSqlType=SQL_TINYINT;   break;
        case(ODBC_INTEGER)  : fCType=SQL_C_INTEGER_X;  fSqlType=SQL_INTEGER_X; break;
        case(ODBC_LONG)     : fCType=SQL_C_LONG;       fSqlType=SQL_INTEGER;   break;
        case(ODBC_FLOAT)    : fCType=SQL_C_FLOAT;      fSqlType=SQL_REAL;      break;
        case(ODBC_REAL)     : fCType=SQL_C_DOUBLE;     fSqlType=SQL_DOUBLE;    break;
        case(ODBC_DATE)     : fCType=SQL_C_DATE;       fSqlType=SQL_DATE;      break;
        case(ODBC_TIME)     : fCType=SQL_C_TIME;       fSqlType=SQL_TIME;      break;
        case(ODBC_TIMESTAMP): fCType=SQL_C_TIMESTAMP;  fSqlType=SQL_TIMESTAMP; break;
        case(ODBC_BINARY)   : fCType=SQL_C_BINARY;     fSqlType=SQL_LONGVARBINARY; break;
        case(ODBC_NUMERIC)  : fCType=SQL_C_CHAR;       fSqlType=SQL_NUMERIC;   break;
        case(ODBC_MEMO)     : fCType=SQL_C_CHAR;       fSqlType=SQL_LONGVARCHAR;   break;
        default:
            GlobErr=ODBC_UNKNOWN_DATA_TYPE;
            odbcMyError(ODBC_ERROR,"odbcBindParameter",SQL_NULL_HENV,SQL_NULL_HDBC,SQL_NULL_HSTMT);
            break;
    }
    rgbValue=odbc_alloc_ham(dataType,BufferLen,pHam);
    colSData=(ODBC_SAVE_DATA *)*pHam;
    odbcMyError(
        (RETCODE)SQLBindParameter((HSTMT)hstmt,(UWORD)ipar,(SWORD)fParamType,(SWORD)fCType,
            (SWORD)fSqlType,(UDWORD)Precision,(SWORD)Scale,(PTR)rgbValue,(SDWORD)BufferLen,
            (SDWORD FAR *)&DATASS),
        "SQLBindParameter",henv,hdbc,hstmt);
    return;
}

// BrowseConnect
void odbcBrowseConnect(HENV henv,HDBC hdbc,STRING ConnStrIn,
    STRING FAR *ConnStrOut)
{
    UCHAR szConnStrOut[SQL_MAX_MESSAGE_LENGTH]="0";
    SWORD pcbConnStrOut;
    odbc_check_loading("odbcBrowseConnect");
    odbcMyError(
        (RETCODE)SQLBrowseConnect((HDBC)hdbc,(UCHAR FAR *)ConnStrIn,(SWORD)odbc_len_str(ConnStrIn),
            (UCHAR FAR *)szConnStrOut,(SWORD)SQL_MAX_MESSAGE_LENGTH,(SWORD FAR *)&pcbConnStrOut),
        "SQLBrowseConnect",henv,hdbc,SQL_NULL_HSTMT);
    *ConnStrOut=MEM_SaveStringGStack(szConnStrOut);
    return;
}
// Cancel
void odbcCancel(HENV henv,HDBC hdbc,HSTMT hstmt)
{
    odbc_check_loading("odbcCancel");
    odbcMyError(
        (RETCODE)SQLCancel((HSTMT)hstmt),
        "SQLCancel",henv,hdbc,hstmt);
    return;
}
// ColAttributes
void odbcColAttributes(HENV henv,HDBC hdbc,HSTMT hstmt,UNSIGNED icol,UNSIGNED dataType,ODBC_COLUMN_DATA FAR **Data)
{
    UWORD        fDescType;
    UCHAR        rgbDesc[SQL_MAX_MESSAGE_LENGTH]="0";
	 SWORD        pcbDesc;
    SDWORD       pfDesc;
    ODBC_COLUMN_DATA   *colData;
    odbc_check_loading("odbcColAttributes");
    switch(dataType)
    {
        case(ODBC_COLUMN_AUTO_INCREMENT): fDescType=SQL_COLUMN_AUTO_INCREMENT; break;
        case(ODBC_COLUMN_CASE_SENSITIVE): fDescType=SQL_COLUMN_CASE_SENSITIVE; break;
        case(ODBC_COLUMN_COUNT)         : fDescType=SQL_COLUMN_COUNT;          break;
        case(ODBC_COLUMN_DISPLAY_SIZE)  : fDescType=SQL_COLUMN_DISPLAY_SIZE;   break;
        case(ODBC_COLUMN_LABEL)         : fDescType=SQL_COLUMN_LABEL;          break;
        case(ODBC_COLUMN_LENGTH)        : fDescType=SQL_COLUMN_LENGTH;         break;
        case(ODBC_COLUMN_MONEY)         : fDescType=SQL_COLUMN_MONEY;          break;
        case(ODBC_COLUMN_NAME)          : fDescType=SQL_COLUMN_NAME;           break;
        case(ODBC_COLUMN_NULLABLE)      : fDescType=SQL_COLUMN_NULLABLE;       break;
        case(ODBC_COLUMN_OWNER_NAME)    : fDescType=SQL_COLUMN_OWNER_NAME;     break;
        case(ODBC_COLUMN_PRECISION)     : fDescType=SQL_COLUMN_PRECISION;      break;
        case(ODBC_COLUMN_QUALIFIER_NAME): fDescType=SQL_COLUMN_QUALIFIER_NAME; break;
        case(ODBC_COLUMN_SCALE)         : fDescType=SQL_COLUMN_SCALE;          break;
        case(ODBC_COLUMN_SEARCHABLE)    : fDescType=SQL_COLUMN_SEARCHABLE;     break;
        case(ODBC_COLUMN_TABLE_NAME)    : fDescType=SQL_COLUMN_TABLE_NAME;     break;
        case(ODBC_COLUMN_TYPE)          : fDescType=SQL_COLUMN_TYPE;           break;
        case(ODBC_COLUMN_TYPE_NAME)     : fDescType=SQL_COLUMN_TYPE_NAME;      break;
        case(ODBC_COLUMN_UNSIGNED)      : fDescType=SQL_COLUMN_UNSIGNED;       break;
        case(ODBC_COLUMN_UPDATABLE)     : fDescType=SQL_COLUMN_UPDATABLE;      break;
        default:
            GlobErr=ODBC_UNKNOWN_COLUMN_TYPE;
            odbcMyError(ODBC_ERROR,"odbcColAttributes",SQL_NULL_HENV,SQL_NULL_HDBC,SQL_NULL_HSTMT);
            break;
    }
    odbcMyError(
        (RETCODE)SQLColAttributes((HSTMT)hstmt,(UWORD)icol,(UWORD)fDescType,(PTR)rgbDesc,
            (SWORD)SQL_MAX_MESSAGE_LENGTH,(SWORD FAR *)&pcbDesc,(SDWORD FAR *)&pfDesc),
        "SQLColAttributes",henv,hdbc,hstmt);
    colData=MEM_AllocGStack(sizeof(ODBC_COLUMN_DATA));
    DATACOLF=(unsigned char)dataType;
    switch(dataType)
    {
        case(ODBC_COLUMN_AUTO_INCREMENT):
            if(pfDesc) DATACOLAI=TRUE; else DATACOLAI=FALSE;
            break;
        case(ODBC_COLUMN_CASE_SENSITIVE):
            if(pfDesc) DATACOLCS=TRUE; else DATACOLCS=FALSE;
            break;
        case(ODBC_COLUMN_COUNT):
            DATACOLCO=pfDesc;
            break;
        case(ODBC_COLUMN_DISPLAY_SIZE):
            odbc_mem_copy(&pfDesc,&DATACOLDS,sizeof(long));
            break;
        case(ODBC_COLUMN_LABEL):
            DATACOLLA=MEM_SaveStringGStack(rgbDesc);
            break;
        case(ODBC_COLUMN_LENGTH):
            odbc_mem_copy(&pfDesc,&DATACOLLE,sizeof(long));
            break;
        case(ODBC_COLUMN_MONEY):
            if(pfDesc) DATACOLMO=TRUE; else DATACOLMO=FALSE;
            break;
        case(ODBC_COLUMN_NAME):
            DATACOLNA=MEM_SaveStringGStack(rgbDesc);
            break;
        case(ODBC_COLUMN_NULLABLE):
            switch(pfDesc)
            {
                case(SQL_NO_NULLS)          : DATACOLNU=ODBC_NO_NULLS;          break;
                case(SQL_NULLABLE)          : DATACOLNU=ODBC_NULLABLE;          break;
                case(SQL_NULLABLE_UNKNOWN)  : DATACOLNU=ODBC_NULLABLE_UNKNOWN;  break;
            }
            break;
        case(ODBC_COLUMN_OWNER_NAME):
            DATACOLON=MEM_SaveStringGStack(rgbDesc);
            break;
        case(ODBC_COLUMN_PRECISION):
            odbc_mem_copy(&pfDesc,&DATACOLPR,sizeof(long));
            break;
        case(ODBC_COLUMN_QUALIFIER_NAME):
            DATACOLQN=MEM_SaveStringGStack(rgbDesc);
            break;
        case(ODBC_COLUMN_SCALE):
            odbc_mem_copy(&pfDesc,&DATACOLSC,sizeof(long));
            break;
        case(ODBC_COLUMN_SEARCHABLE):
            switch(pfDesc)
            {
                case(SQL_UNSEARCHABLE)      : DATACOLSE=ODBC_UNSEARCHABLE;      break;
                case(SQL_LIKE_ONLY)         : DATACOLSE=ODBC_LIKE_ONLY;         break;
                case(SQL_ALL_EXCEPT_LIKE)   : DATACOLSE=ODBC_ALL_EXCEPT_LIKE;   break;
                case(SQL_SEARCHABLE)        : DATACOLSE=ODBC_SEARCHABLE;        break;
            }
            break;
        case(ODBC_COLUMN_TABLE_NAME):
            DATACOLTN=MEM_SaveStringGStack(rgbDesc);
            break;
        case(ODBC_COLUMN_TYPE):
            switch(pfDesc)
            {
                case(SQL_CHAR):
                case(SQL_VARCHAR):
                    DATACOLTY=ODBC_STRING;
                    break;
                case(SQL_LONGVARCHAR):
                    DATACOLTY=ODBC_MEMO;
                    break;
                case(SQL_BIT):
                    DATACOLTY=ODBC_BIT;
                    break;
                case(SQL_TINYINT):
                    DATACOLTY=ODBC_BYTE;
                    break;
                case(SQL_SMALLINT):
                    DATACOLTY=ODBC_INTEGER;
                    break;
                case(SQL_INTEGER):
                    DATACOLTY=ODBC_LONG;
                    break;
                case(SQL_REAL):
                case(SQL_FLOAT):
                    DATACOLTY=ODBC_FLOAT;
                    break;
                case(SQL_DOUBLE):
                    DATACOLTY=ODBC_REAL;
                    break;
                case(SQL_DATE):
                    DATACOLTY=ODBC_DATE;
                    break;
                case(SQL_TIME):
                    DATACOLTY=ODBC_TIME;
                    break;
                case(SQL_TIMESTAMP):
                    DATACOLTY=ODBC_TIMESTAMP;
                    break;
                case(SQL_BINARY):
                case(SQL_VARBINARY):
                case(SQL_LONGVARBINARY):
                    DATACOLTY=ODBC_BINARY;
                    break;
                case(SQL_DECIMAL):
                case(SQL_NUMERIC):
                case(SQL_BIGINT):
                    DATACOLTY=ODBC_NUMERIC;
                    break;
            }
            break;
        case(ODBC_COLUMN_TYPE_NAME):
            DATACOLTA=MEM_SaveStringGStack(rgbDesc);
            break;
        case(ODBC_COLUMN_UNSIGNED):
            if(pfDesc) DATACOLNU=TRUE; else DATACOLNU=FALSE;
            break;
        case(ODBC_COLUMN_UPDATABLE):
            switch(pfDesc)
            {
                case(SQL_ATTR_READONLY)           : DATACOLUP=ODBC_ATTR_READONLY;           break;
                case(SQL_ATTR_WRITE)              : DATACOLUP=ODBC_ATTR_WRITE;              break;
                case(SQL_ATTR_READWRITE_UNKNOWN)  : DATACOLUP=ODBC_ATTR_READWRITE_UNKNOWN;  break;
            }
            break;
    }
    *Data=colData;
    return;
}
// ColumnPrivileges
void odbcColumnPrivileges(HENV henv,HDBC hdbc,HSTMT hstmt,STRING TableQualifier,
    STRING TableOwner,STRING TableName,STRING ColumnName)
{
    STRING szTableQualifier;
    SWORD cbTableQualifier;
    STRING szTableOwner;
    SWORD cbTableOwner;
    STRING szTableName;
    SWORD cbTableName;
    STRING szColumnName;
    SWORD cbColumnName;
    odbc_check_loading("odbcColumnPrivileges");
    if(odbc_cmp_str(TableQualifier,"NULL_STRING"))
    {
        szTableQualifier=0;
        cbTableQualifier=0;
    }
    else
    {
        szTableQualifier=TableQualifier;
        cbTableQualifier=odbc_len_str(szTableQualifier);
    }
    if(odbc_cmp_str(TableOwner,"NULL_STRING"))
    {
        szTableOwner=0;
        cbTableOwner=0;
    }
    else
    {
        szTableOwner=TableOwner;
        cbTableOwner=odbc_len_str(szTableOwner);
    }
    if(odbc_cmp_str(TableName,"NULL_STRING"))
    {
        szTableName=0;
        cbTableName=0;
    }
    else
    {
        szTableName=TableName;
        cbTableName=odbc_len_str(szTableName);
    }
    if(odbc_cmp_str(ColumnName,"NULL_STRING"))
    {
        szColumnName=0;
        cbColumnName=0;
    }
    else
    {
        szColumnName=ColumnName;
        cbColumnName=odbc_len_str(szColumnName);
    }
    odbcMyError(
        (RETCODE)SQLColumnPrivileges((HSTMT)hstmt,(UCHAR FAR *)szTableQualifier,(SWORD)cbTableQualifier,
            (UCHAR FAR *)szTableOwner,(SWORD)cbTableOwner,(UCHAR FAR *)szTableName,(SWORD)cbTableName,
            (UCHAR FAR *)szColumnName,(SWORD)cbColumnName),
        "SQLColumnPrivileges",henv,hdbc,hstmt);
    return;
}
// Columns
void odbcColumns(HENV henv,HDBC hdbc,HSTMT hstmt,STRING TableQualifier,
    STRING TableOwner,STRING TableName,STRING ColumnName)
{
    STRING szTableQualifier;
    SWORD cbTableQualifier;
    STRING szTableOwner;
    SWORD cbTableOwner;
    STRING szTableName;
    SWORD cbTableName;
    STRING szColumnName;
    SWORD cbColumnName;
    odbc_check_loading("odbcColumns");
    if(odbc_cmp_str(TableQualifier,"NULL_STRING"))
    {
        szTableQualifier=0;
        cbTableQualifier=0;
    }
    else
    {
        szTableQualifier=TableQualifier;
        cbTableQualifier=odbc_len_str(szTableQualifier);
    }
    if(odbc_cmp_str(TableOwner,"NULL_STRING"))
    {
        szTableOwner=0;
        cbTableOwner=0;
    }
    else
    {
        szTableOwner=TableOwner;
        cbTableOwner=odbc_len_str(szTableOwner);
    }
    if(odbc_cmp_str(TableName,"NULL_STRING"))
    {
        szTableName=0;
        cbTableName=0;
    }
    else
    {
        szTableName=TableName;
        cbTableName=odbc_len_str(szTableName);
    }
    if(odbc_cmp_str(ColumnName,"NULL_STRING"))
    {
        szColumnName=0;
        cbColumnName=0;
    }
    else
    {
        szColumnName=ColumnName;
        cbColumnName=odbc_len_str(szColumnName);
    }
    odbcMyError(
        (RETCODE)SQLColumns((HSTMT)hstmt,(UCHAR FAR *)szTableQualifier,(SWORD)cbTableQualifier,
            (UCHAR FAR *)szTableOwner,(SWORD)cbTableOwner,(UCHAR FAR *)szTableName,(SWORD)cbTableName,
            (UCHAR FAR *)szColumnName,(SWORD)cbColumnName),
        "SQLColumns",henv,hdbc,hstmt);
    return;
}
// Connect
void odbcConnect(HENV henv,HDBC hdbc,STRING szDSN,STRING szUID,STRING szAuthStr)
{
    odbc_check_loading("odbcConnect");
    odbcMyError(
        (RETCODE)SQLConnect((HDBC)hdbc,(UCHAR FAR *)szDSN,(SWORD)odbc_len_str(szDSN),
            (UCHAR FAR *)szUID,(SWORD)odbc_len_str(szUID),(UCHAR FAR *)szAuthStr,(SWORD)odbc_len_str(szAuthStr)),
        "SQLConnect",henv,hdbc,SQL_NULL_HSTMT);
    return;
}
// DataSources
void odbcDataSources(HENV henv,UNSIGNED Direction,STRING FAR *Name,STRING FAR *Description)
{
    UWORD fDirection;
    UCHAR szDSN[SQL_MAX_MESSAGE_LENGTH]="0";
    SWORD pcbDSN;
    UCHAR szDescription[SQL_MAX_MESSAGE_LENGTH]="0";
    SWORD pcbDescription;
    odbc_check_loading("odbcDataSources");
    switch(Direction)
    {
        case(ODBC_FETCH_FIRST) : fDirection=SQL_FETCH_FIRST; break;
        case(ODBC_FETCH_NEXT)  : fDirection=SQL_FETCH_NEXT;  break;
        default:
            GlobErr=ODBC_UNKNOWN_DIRECTION;
            odbcMyError(ODBC_ERROR,"odbcDataSources",SQL_NULL_HENV,SQL_NULL_HDBC,SQL_NULL_HSTMT);
            break;
    }
    odbcMyError(
        (RETCODE)SQLDataSources((HENV)henv,(UWORD)fDirection,(UCHAR FAR *)szDSN,
            (SWORD)SQL_MAX_MESSAGE_LENGTH,(SWORD FAR *)&pcbDSN,(UCHAR FAR *)szDescription,
            (SWORD)SQL_MAX_MESSAGE_LENGTH,(SWORD FAR *)&pcbDescription),
        "SQLDataSources",henv,SQL_NULL_HDBC,SQL_NULL_HSTMT);
    *Name=MEM_SaveStringGStack(szDSN);
    *Description=MEM_SaveStringGStack(szDescription);
    return;
}
// DescribeParam
void odbcDescribeParam(HENV henv,HDBC hdbc,HSTMT hstmt,UNSIGNED ipar,
    INTEGER FAR *Type,UDWORD FAR *Precision,INTEGER FAR *Scale,
    INTEGER FAR *Nullable)
{
	 SWORD pfSqlType;
    UDWORD pcbColDef;
    SWORD pibScale;
    SWORD pfNullable;
    odbc_check_loading("odbcDescribeParam");
    odbcMyError(
        (RETCODE)SQLDescribeParam((HSTMT)hstmt,(UWORD)ipar,(SWORD FAR *)&pfSqlType,
            (UDWORD FAR *)&pcbColDef,(SWORD FAR *)&pibScale,(SWORD FAR *)&pfNullable),
        "SQLDescribeParam",henv,hdbc,hstmt);
    switch(pfSqlType)
    {
        case(SQL_CHAR):
        case(SQL_VARCHAR):
            *Type=ODBC_STRING;
            break;
        case(SQL_LONGVARCHAR):
            *Type=ODBC_MEMO;
            break;
        case(SQL_BIT):
            *Type=ODBC_BIT;
            break;
        case(SQL_TINYINT):
            *Type=ODBC_BYTE;
            break;
        case(SQL_SMALLINT):
            *Type=ODBC_INTEGER;
            break;
        case(SQL_INTEGER):
            *Type=ODBC_LONG;
            break;
        case(SQL_REAL):
        case(SQL_FLOAT):
            *Type=ODBC_FLOAT;
            break;
        case(SQL_DOUBLE):
            *Type=ODBC_REAL;
            break;
        case(SQL_DATE):
            *Type=ODBC_DATE;
            break;
        case(SQL_TIME):
            *Type=ODBC_TIME;
            break;
        case(SQL_TIMESTAMP):
            *Type=ODBC_TIMESTAMP;
            break;
        case(SQL_BINARY):
        case(SQL_VARBINARY):
        case(SQL_LONGVARBINARY):
            *Type=ODBC_BINARY;
            break;
        case(SQL_DECIMAL):
        case(SQL_NUMERIC):
        case(SQL_BIGINT):
            *Type=ODBC_NUMERIC;
            break;
    }
    *Precision=pcbColDef;
    *Scale=pibScale;
    switch(pfNullable)
    {
        case(SQL_NO_NULLS)        : *Nullable=ODBC_NO_NULLS;          break;
        case(SQL_NULLABLE)        : *Nullable=ODBC_NULLABLE;          break;
        case(SQL_NULLABLE_UNKNOWN): *Nullable=ODBC_NULLABLE_UNKNOWN;  break;
    }
    return;
}
// DescribeCol
void odbcDescribeCol(HENV henv,HDBC hdbc,HSTMT hstmt,UNSIGNED icol,STRING FAR *Name,
    INTEGER FAR *Type,UDWORD FAR *Precision,INTEGER FAR *Scale,INTEGER FAR *Nullable)
{
    UCHAR szColName[SQL_MAX_MESSAGE_LENGTH]="0";
    SWORD pcbColName;
    SWORD pfSqlType;
    UDWORD pcbColDef;
    SWORD pibScale;
    SWORD pfNullable;
    odbc_check_loading("odbcDescribeCol");
    odbcMyError(
        (RETCODE)SQLDescribeCol((HSTMT)hstmt,(UWORD)icol,(UCHAR FAR *)szColName,
            (SWORD)SQL_MAX_MESSAGE_LENGTH,(SWORD FAR *)&pcbColName,(SWORD FAR *)&pfSqlType,
            (UDWORD FAR *)&pcbColDef,(SWORD FAR *)&pibScale,(SWORD FAR *)&pfNullable),
        "SQLDescribeCol",henv,hdbc,hstmt);
    *Name=MEM_SaveStringGStack(szColName);
    switch(pfSqlType)
    {
        case(SQL_CHAR):
        case(SQL_VARCHAR):
            *Type=ODBC_STRING;
            break;
        case(SQL_LONGVARCHAR):
            *Type=ODBC_MEMO;
            break;
        case(SQL_BIT):
            *Type=ODBC_BIT;
            break;
        case(SQL_TINYINT):
            *Type=ODBC_BYTE;
            break;
        case(SQL_SMALLINT):
            *Type=ODBC_INTEGER;
            break;
        case(SQL_INTEGER):
            *Type=ODBC_LONG;
            break;
        case(SQL_REAL):
            *Type=ODBC_FLOAT;
            break;
        case(SQL_FLOAT):
        case(SQL_DOUBLE):
            *Type=ODBC_REAL;
            break;
        case(SQL_DATE):
            *Type=ODBC_DATE;
            break;
        case(SQL_TIME):
            *Type=ODBC_TIME;
            break;
        case(SQL_TIMESTAMP):
            *Type=ODBC_TIMESTAMP;
            break;
        case(SQL_BINARY):
        case(SQL_VARBINARY):
        case(SQL_LONGVARBINARY):
            *Type=ODBC_BINARY;
            break;
        case(SQL_DECIMAL):
        case(SQL_NUMERIC):
        case(SQL_BIGINT):
            *Type=ODBC_NUMERIC;
            break;
    }
    *Precision=pcbColDef;
    *Scale=pibScale;
    switch(pfNullable)
    {
        case(SQL_NO_NULLS)        : *Nullable=ODBC_NO_NULLS;          break;
        case(SQL_NULLABLE)        : *Nullable=ODBC_NULLABLE;          break;
        case(SQL_NULLABLE_UNKNOWN): *Nullable=ODBC_NULLABLE_UNKNOWN;  break;
    }
    return;
}
// Disconnect
void odbcDisconnect(HENV henv,HDBC hdbc)
{
    odbc_check_loading("odbcDisconnect");
    odbcMyError(
        (RETCODE)SQLDisconnect((HDBC)hdbc),
        "SQLDisconnect",henv,hdbc,SQL_NULL_HSTMT);
    return;
}
// DriverConnect
void odbcDriverConnect(HENV henv,HDBC hdbc,WINDOW hwnd,STRING ConnStrIn,
    UNSIGNED DriverCompletion,STRING FAR *ConnStrOut)
{
    UCHAR szConnStrOut[SQL_MAX_MESSAGE_LENGTH]="0";
    SWORD pcbConnStrOut;
    UWORD fDriverCompletion;
    odbc_check_loading("odbcDriverConnect");
    switch(DriverCompletion)
    {
        case(ODBC_DRIVER_PROMPT):
            fDriverCompletion=SQL_DRIVER_PROMPT;
            break;
        case(ODBC_DRIVER_COMPLETE):
            fDriverCompletion=SQL_DRIVER_COMPLETE;
            break;
        case(ODBC_DRIVER_COMPLETE_REQUIRED):
            fDriverCompletion=SQL_DRIVER_COMPLETE_REQUIRED;
            break;
        case(ODBC_DRIVER_NOPROMPT):
            fDriverCompletion=SQL_DRIVER_NOPROMPT;
            break;
        default:
            GlobErr=ODBC_UNKNOWN_DRIVER_COMPLETION;
            odbcMyError(ODBC_ERROR,"odbcDriverConnect",SQL_NULL_HENV,SQL_NULL_HDBC,SQL_NULL_HSTMT);
            break;
    }
    odbcMyError(
        (RETCODE)SQLDriverConnect((HDBC)hdbc,(HWND)hwnd,(UCHAR FAR *)ConnStrIn,
            (SWORD)odbc_len_str(ConnStrIn),(UCHAR FAR *)szConnStrOut,(SWORD)SQL_MAX_MESSAGE_LENGTH,
            (SWORD FAR *)&pcbConnStrOut,(UWORD)fDriverCompletion),
        "SQLDriverConnect",henv,hdbc,SQL_NULL_HSTMT);
    *ConnStrOut=MEM_SaveStringGStack(szConnStrOut);
    return;
}
// Drivers
void odbcDrivers(HENV henv,UNSIGNED Direction,STRING FAR *DriverDescription,STRING FAR *DriverAttributes)
{
    UWORD fDirection;
    UCHAR szDriverDesc[SQL_MAX_MESSAGE_LENGTH]="0";
    SWORD pcbDriverDesc;
    UCHAR szDriverAttributes[SQL_MAX_MESSAGE_LENGTH]="0";
    SWORD pcbDriverAttributes;
    odbc_check_loading("odbcDrivers");
    switch(Direction)
    {
        case(ODBC_FETCH_FIRST) : fDirection=SQL_FETCH_FIRST; break;
        case(ODBC_FETCH_NEXT)  : fDirection=SQL_FETCH_NEXT;  break;
        default:
            GlobErr=ODBC_UNKNOWN_DIRECTION;
            odbcMyError(ODBC_ERROR,"odbcDrivers",SQL_NULL_HENV,SQL_NULL_HDBC,SQL_NULL_HSTMT);
            break;
    }
    odbcMyError(
        (RETCODE)SQLDrivers((HENV)henv,(UWORD)fDirection,(UCHAR FAR *)szDriverDesc,
            (SWORD)SQL_MAX_MESSAGE_LENGTH,(SWORD FAR *)&pcbDriverDesc,(UCHAR FAR *)szDriverAttributes,
            (SWORD)SQL_MAX_MESSAGE_LENGTH,(SWORD FAR *)&pcbDriverAttributes),
        "SQLDrivers",henv,SQL_NULL_HDBC,SQL_NULL_HSTMT);
    *DriverDescription=MEM_SaveStringGStack(szDriverDesc);
    *DriverAttributes=MEM_SaveStringGStack(szDriverAttributes);
    return;
}
// Execute
void odbcExecute(HENV henv,HDBC hdbc,HSTMT hstmt)
{
    odbc_check_loading("odbcExecute");
    odbcMyError(
        (RETCODE)SQLExecute((HSTMT)hstmt),
        "SQLExecute",henv,hdbc,hstmt);
    return;
}
// ExecDirect
void odbcExecDirect(HENV henv,HDBC hdbc,HSTMT hstmt,STRING szSqlStr)
{
    odbc_check_loading("odbcExecDirect");
    odbcMyError(
        (RETCODE)SQLExecDirect((HSTMT)hstmt,(UCHAR FAR *)szSqlStr,(SDWORD)odbc_len_str(szSqlStr)),
        "SQLExecDirect",henv,hdbc,hstmt);
    return;
}
// ExtendedFetch
void odbcExtendedFetch(HENV henv,HDBC hdbc,HSTMT hstmt,UNSIGNED FetchType,
    SDWORD irow,UDWORD FAR *ShiftRow)
{
    UWORD  fFetchType;
    UDWORD pcrow;
    UWORD  rgfRowStatus;
    odbc_check_loading("odbcExtendedFetch");
    switch(FetchType)
    {
        case(ODBC_FETCH_FIRST)    : fFetchType=SQL_FETCH_FIRST;    break;
        case(ODBC_FETCH_NEXT)     : fFetchType=SQL_FETCH_NEXT;     break;
        case(ODBC_FETCH_LAST)     : fFetchType=SQL_FETCH_LAST;     break;
        case(ODBC_FETCH_PRIOR)    : fFetchType=SQL_FETCH_PRIOR;    break;
        case(ODBC_FETCH_ABSOLUTE) : fFetchType=SQL_FETCH_ABSOLUTE; break;
        case(ODBC_FETCH_RELATIVE) : fFetchType=SQL_FETCH_RELATIVE; break;
        case(ODBC_FETCH_BOOKMARK) : fFetchType=SQL_FETCH_BOOKMARK; break;
        default:
            GlobErr=ODBC_UNKNOWN_DIRECTION;
            odbcMyError(ODBC_ERROR,"odbcExtendedFetch",SQL_NULL_HENV,SQL_NULL_HDBC,SQL_NULL_HSTMT);
            break;
    }
    odbcMyError(
        (RETCODE)SQLExtendedFetch((HSTMT)hstmt,(UWORD)fFetchType,(SDWORD)irow,(UDWORD FAR *)&pcrow,
            (UWORD FAR *)&rgfRowStatus),
        "SQLExtendedFetch",henv,hdbc,hstmt);
    *ShiftRow=pcrow;
    return;
}
// Fetch
void odbcFetch(HENV henv,HDBC hdbc,HSTMT hstmt)
{
    odbc_check_loading("odbcFetch");
    odbcMyError(
        (RETCODE)SQLFetch((HSTMT)hstmt),
        "SQLFetch",henv,hdbc,hstmt);
    return;
}
// ForeignKeys
void odbcForeignKeys(HENV henv,HDBC hdbc,HSTMT hstmt,
    STRING PkTableQualifier,STRING PkTableOwner,STRING PkTableName,
    STRING FkTableQualifier,STRING FkTableOwner,STRING FkTableName)
{
    STRING szPkTableQualifier;
    SWORD cbPkTableQualifier;
    STRING szPkTableOwner;
    SWORD cbPkTableOwner;
    STRING szPkTableName;
    SWORD cbPkTableName;
    STRING szFkTableQualifier;
    SWORD cbFkTableQualifier;
    STRING szFkTableOwner;
    SWORD cbFkTableOwner;
    STRING szFkTableName;
    SWORD cbFkTableName;
    odbc_check_loading("odbcForeignKeys");
    if(odbc_cmp_str(PkTableQualifier,"NULL_STRING"))
    {
        szPkTableQualifier=0;
        cbPkTableQualifier=0;
    }
    else
    {
        szPkTableQualifier=PkTableQualifier;
        cbPkTableQualifier=odbc_len_str(szPkTableQualifier);
    }
    if(odbc_cmp_str(PkTableOwner,"NULL_STRING"))
    {
        szPkTableOwner=0;
        cbPkTableOwner=0;
    }
    else
    {
        szPkTableOwner=PkTableOwner;
        cbPkTableOwner=odbc_len_str(szPkTableOwner);
    }
    if(odbc_cmp_str(PkTableName,"NULL_STRING"))
    {
        szPkTableName=0;
        cbPkTableName=0;
    }
    else
    {
        szPkTableName=PkTableName;
        cbPkTableName=odbc_len_str(szPkTableName);
    }
    if(odbc_cmp_str(FkTableQualifier,"NULL_STRING"))
    {
        szFkTableQualifier=0;
        cbFkTableQualifier=0;
    }
    else
    {
        szFkTableQualifier=FkTableQualifier;
        cbFkTableQualifier=odbc_len_str(szFkTableQualifier);
    }
    if(odbc_cmp_str(FkTableOwner,"NULL_STRING"))
    {
        szFkTableOwner=0;
        cbFkTableOwner=0;
    }
    else
    {
        szFkTableOwner=FkTableOwner;
        cbFkTableOwner=odbc_len_str(szFkTableOwner);
    }
    if(odbc_cmp_str(FkTableName,"NULL_STRING"))
    {
        szFkTableName=0;
        cbFkTableName=0;
    }
    else
    {
        szFkTableName=FkTableName;
        cbFkTableName=odbc_len_str(szFkTableName);
    }
    odbcMyError(
        (RETCODE)SQLForeignKeys((HSTMT)hstmt,(UCHAR FAR *)szPkTableQualifier,(SWORD)cbPkTableQualifier,
            (UCHAR FAR *)szPkTableOwner,(SWORD)cbPkTableOwner,(UCHAR FAR *)szPkTableName,(SWORD)cbPkTableName,
            (UCHAR FAR *)szFkTableQualifier,(SWORD)cbFkTableQualifier,(UCHAR FAR *)szFkTableOwner,
            (SWORD)cbFkTableOwner,(UCHAR FAR *)szFkTableName,(SWORD)cbFkTableName),
        "SQLForeignKeys",henv,hdbc,hstmt);
    return;
}
// FreeConnect
void odbcFreeConnect(HENV henv,HDBC hdbc)
{
    odbc_check_loading("odbcFreeConnect");
    odbcMyError((RETCODE)SQLFreeConnect((HDBC)hdbc),"SQLFreeConnect",henv,hdbc,SQL_NULL_HSTMT);
    return;
}
// FreeEnv
void odbcFreeEnv(HENV henv)
{
    odbc_check_loading("odbcFreeEnv");
    odbcMyError((RETCODE)SQLFreeEnv((HENV)henv),"SQLFreeEnv",henv,SQL_NULL_HDBC,SQL_NULL_HSTMT);
    return;
}
// FreeStmt
void odbcFreeStmt(HENV henv,HDBC hdbc,HSTMT hstmt,UNSIGNED Option)
{
    UWORD fOption;
    odbc_check_loading("odbcFreeStmt");
    switch(Option)
    {
        case(ODBC_DROP)        : fOption=SQL_DROP;           break;
        case(ODBC_CLOSE)       : fOption=SQL_CLOSE;          break;
        case(ODBC_UNBIND)      : fOption=SQL_UNBIND;         break;
        case(ODBC_RESET_PARAMS): fOption=SQL_RESET_PARAMS;   break;
        default:
            GlobErr=ODBC_UNKNOWN_OPTION;
            odbcMyError(ODBC_ERROR,"odbcFreeStmt",SQL_NULL_HENV,SQL_NULL_HDBC,SQL_NULL_HSTMT);
            break;
    }
    odbcMyError(
        (RETCODE)SQLFreeStmt((HSTMT)hstmt,(UWORD)fOption),
        "SQLFreeStmt",henv,hdbc,hstmt);
    return;
}
// GetConnectOption
void odbcGetConnectOption(HENV henv,HDBC hdbc,UNSIGNED Option,ODBC_CO_DATA **Data)
{
    UWORD     fOption;
    UCHAR     pvParam[SQL_MAX_MESSAGE_LENGTH]="0";
    DWORD     vParam;
    ODBC_CO_DATA *Param;
    odbc_check_loading("odbcGetConnectOption");
    switch(Option)
    {
        case(ODBC_ACCESS_MODE)       : fOption=SQL_ACCESS_MODE;       break;
        case(ODBC_AUTOCOMMIT)        : fOption=SQL_AUTOCOMMIT;        break;
        case(ODBC_CURRENT_QUALIFIER) : fOption=SQL_CURRENT_QUALIFIER; break;
        case(ODBC_LOGIN_TIMEOUT)     : fOption=SQL_LOGIN_TIMEOUT;     break;
        case(ODBC_ODBC_CURSORS)      : fOption=SQL_ODBC_CURSORS;      break;
        case(ODBC_OPT_TRACE)         : fOption=SQL_OPT_TRACE;         break;
        case(ODBC_OPT_TRACEFILE)     : fOption=SQL_OPT_TRACEFILE;     break;
        case(ODBC_PACKET_SIZE)       : fOption=SQL_PACKET_SIZE;       break;
        case(ODBC_QUIET_MODE)        : fOption=SQL_QUIET_MODE;        break;
        case(ODBC_TRANSLATE_DLL)     : fOption=SQL_TRANSLATE_DLL;     break;
        case(ODBC_TRANSLATE_OPTION)  : fOption=SQL_TRANSLATE_OPTION;  break;
        case(ODBC_TXN_ISOLATION)     : fOption=SQL_TXN_ISOLATION;     break;
        default:
            GlobErr=ODBC_UNKNOWN_OPTION;
            odbcMyError(ODBC_ERROR,"odbcGetConnectOption",SQL_NULL_HENV,SQL_NULL_HDBC,SQL_NULL_HSTMT);
            break;
    }
    odbcMyError(
        (RETCODE)SQLGetConnectOption((HDBC)hdbc,(UWORD)fOption,(PTR)pvParam),
        "SQLGetConnectOption",henv,hdbc,SQL_NULL_HSTMT);
    Param=MEM_AllocGStack(sizeof(ODBC_CO_DATA));
    vParam=(DWORD)*pvParam;
    switch(Option)
    {
        case(ODBC_ACCESS_MODE)    : DATACOF=fco_l;
            switch(vParam)
            {
                case(SQL_MODE_READ_ONLY) : DATACOL=ODBC_MODE_READ_ONLY;      break;
                case(SQL_MODE_READ_WRITE): DATACOL=ODBC_MODE_READ_WRITE;     break;
                default                  : DATACOL=vParam;                   break;
            }
            break;
        case(ODBC_AUTOCOMMIT)     : DATACOF=fco_l;
            switch(vParam)
            {
                case(SQL_AUTOCOMMIT_OFF) : DATACOL=ODBC_AUTOCOMMIT_OFF;   break;
                case(SQL_AUTOCOMMIT_ON)  : DATACOL=ODBC_AUTOCOMMIT_ON;    break;
                default                  : DATACOL=vParam;                break;
            }
            break;
        case(ODBC_CURRENT_QUALIFIER)    : DATACOF=fco_s;
            DATACOS=MEM_SaveStringGStack(pvParam);
            break;
        case(ODBC_LOGIN_TIMEOUT)        : DATACOF=fco_l;
            DATACOL=vParam;
            break;
        case(ODBC_ODBC_CURSORS)         : DATACOF=fco_l;
            switch(vParam)
            {
                case(SQL_CUR_USE_IF_NEEDED) : DATACOL=ODBC_CUR_USE_IF_NEEDED;   break;
                case(SQL_CUR_USE_ODBC)      : DATACOL=ODBC_CUR_USE_ODBC;        break;
                case(SQL_CUR_USE_DRIVER)    : DATACOL=ODBC_CUR_USE_DRIVER;      break;
                default                     : DATACOL=vParam;                   break;
            }
        break;
        case(ODBC_OPT_TRACE)         : DATACOF=fco_l;
            switch(vParam)
            {
                case(SQL_OPT_TRACE_OFF)  : DATACOL=ODBC_OPT_TRACE_OFF;    break;
                case(SQL_OPT_TRACE_ON)   : DATACOL=ODBC_OPT_TRACE_ON;     break;
                default                  : DATACOL=vParam;                break;
            }
            break;
        case(ODBC_OPT_TRACEFILE)     : DATACOF=fco_s;
            DATACOS=MEM_SaveStringGStack(pvParam);
            break;
        case(ODBC_PACKET_SIZE)       : DATACOF=fco_l;
            DATACOL=vParam;
            break;
        case(ODBC_QUIET_MODE)        : DATACOF=fco_l;
            DATACOL=vParam;
            break;
        case(ODBC_TRANSLATE_DLL)        : DATACOF=fco_s;
            DATACOS=MEM_SaveStringGStack(pvParam);
            break;
        case(ODBC_TRANSLATE_OPTION)     : DATACOF=fco_l;
            DATACOL=vParam;
            break;
        case(ODBC_TXN_ISOLATION)     : DATACOF=fco_l;
            switch(vParam)
            {
                case(SQL_TXN_READ_UNCOMMITTED)    : DATACOL=ODBC_TXN_READ_UNCOMMITTED;   break;
                case(SQL_TXN_READ_COMMITTED)      : DATACOL=ODBC_TXN_READ_COMMITTED;     break;
                case(SQL_TXN_REPEATABLE_READ)     : DATACOL=ODBC_TXN_REPEATABLE_READ;    break;
                case(SQL_TXN_SERIALIZABLE)        : DATACOL=ODBC_TXN_SERIALIZABLE;       break;
//                case(SQL_TXN_VERSIONING)          : DATACOL=ODBC_TXN_VERSIONING;         break;
                default                           : DATACOL=vParam;                      break;
            }
            break;
    }
    *Data=Param;
    return;
}
// GetCursorName
void odbcGetCursorName(HENV henv,HDBC hdbc,HSTMT hstmt,STRING FAR *Cursor)
{
    UCHAR szCursor[SQL_MAX_MESSAGE_LENGTH]="0";
    SWORD pcbCursor;
    odbc_check_loading("odbcGetCursorName");
    odbcMyError(
        (RETCODE)SQLGetCursorName((HSTMT)hstmt,(UCHAR FAR *)szCursor,(SWORD)SQL_MAX_MESSAGE_LENGTH,
            (SWORD FAR *)&pcbCursor),
        "SQLGetCursorName",henv,hdbc,hstmt);
    *Cursor=MEM_SaveStringGStack(szCursor);
    return;
}
// GetData
void odbcGetData(HENV henv,HDBC hdbc,HSTMT hstmt,UNSIGNED icol,UNSIGNED dataType,UNSIGNED size,ODBC_DATA FAR **Data,UNSIGNED FAR *DataSize)
{
    SWORD        fCType;
    UCHAR        *rgbValue;
    SDWORD       pcbValue;
    unsigned     upcbValue;
    UCHAR        buffer[30];
    DATE_STRUCT     *ds;
    TIME_STRUCT     *ts;
    TIMESTAMP_STRUCT   *tss;
    ODBC_DATA    *colData;
    int i;
    unsigned char *tmp;
    float        tmp_float;

    odbc_check_loading("odbcGetData");
    switch(dataType)
    {
        case(ODBC_STRING)   :	break;
        case(ODBC_BIT)      :	break;
        case(ODBC_BYTE)     :	break;
        case(ODBC_INTEGER)  :	break;
        case(ODBC_LONG)     :	break;
        case(ODBC_FLOAT)    :	break;
        case(ODBC_REAL)     :	break;
        case(ODBC_DATE)     :	break;
        case(ODBC_TIME)     :	break;
        case(ODBC_TIMESTAMP):	break;
        case(ODBC_BINARY)   :	break;
        case(ODBC_NUMERIC)  :	break;
        case(ODBC_MEMO)     :	break;
        default:
            GlobErr=ODBC_UNKNOWN_DATA_TYPE;
            odbcMyError(ODBC_ERROR,"odbcGetData",SQL_NULL_HENV,SQL_NULL_HDBC,SQL_NULL_HSTMT);
            break;
    }
    fCType=SQL_C_DEFAULT;
    rgbValue=MEM_AllocHeap(size);
    odbcMyError(
        (RETCODE)SQLGetData((HSTMT)hstmt,(UWORD)icol,(SWORD)fCType,(PTR)rgbValue,(SDWORD)size,
            (SDWORD FAR *)&pcbValue),
        "SQLGetData",henv,hdbc,hstmt);
    colData=MEM_AllocGStack(sizeof(ODBC_DATA));
    tmp=(unsigned char *)colData;
    for(i=0;i<sizeof(ODBC_DATA);i++)
    {
        tmp[i]=0;
    }
    if(pcbValue==SQL_NULL_DATA)
        DATAF=ODBC_NULL;
    else
    {
        DATAF=(unsigned char)dataType;
        switch(dataType)
        {
            case(ODBC_STRING):
                DATAS=MEM_SaveStringGStack(rgbValue);
                break;
            case(ODBC_MEMO):
                DATAS=MEM_SaveStringGStack(rgbValue);
                break;
            case(ODBC_BIT):
                odbc_mem_copy(rgbValue,&DATAI,sizeof(char));
                break;
            case(ODBC_BYTE):
                odbc_mem_copy(rgbValue,&DATAI,sizeof(char));
                break;
            case(ODBC_INTEGER):
                odbc_mem_copy(rgbValue,&DATAI,sizeof(short));
                break;
            case(ODBC_LONG):
                odbc_mem_copy(rgbValue,&DATAL,sizeof(long int));
                break;
            case(ODBC_FLOAT):
                odbc_mem_copy(rgbValue,&tmp_float,sizeof(float));
                DATAR=(double)tmp_float;
                break;
            case(ODBC_REAL):
                odbc_mem_copy(rgbValue,&DATAR,sizeof(double));
                break;
            case(ODBC_DATE):
                ds=(DATE_STRUCT *)rgbValue;
                IO_SPrintf(buffer,"%-2d-%-2d-%-4d",ds->month,ds->day,ds->year);
                DATAS=MEM_SaveStringGStack(buffer);
                break;
            case(ODBC_TIME):
                ts=(TIME_STRUCT *)rgbValue;
                IO_SPrintf(buffer,"%-2d:%-2d:%-2d",ts->hour,ts->minute,ts->second);
                DATAS=MEM_SaveStringGStack(buffer);
                break;
            case(ODBC_TIMESTAMP):
                tss=(TIMESTAMP_STRUCT *)rgbValue;
                IO_SPrintf(buffer,"%-2d-%-2d-%-4d %-2d:%-2d:%-2d",
                    tss->month,tss->day,tss->year,tss->hour,tss->minute,tss->second);
                DATAS=MEM_SaveStringGStack(buffer);
                break;
            case(ODBC_BINARY):
                if(pcbValue==SQL_NO_TOTAL||pcbValue>(SDWORD)size)
                    upcbValue=size;
                else
                    upcbValue=pcbValue;
                DATAS=MEM_AllocGStack(upcbValue+sizeof(unsigned));
                upcbValue+=sizeof(unsigned);
                odbc_mem_copy(&upcbValue,DATAS,sizeof(unsigned));
                upcbValue-=sizeof(unsigned);
                DATAS+=sizeof(unsigned);
                odbc_mem_copy(rgbValue,DATAS,upcbValue);
                break;
            case(ODBC_NUMERIC):
				if(rgbValue[0]=='.')
				{
					odbc_copy_str("0",buffer);
					odbc_copy_str(rgbValue,buffer+1);
				}
                DATAS=MEM_SaveStringGStack(buffer);
                break;
        }
    }
    *Data=colData;
    *DataSize=(unsigned short)pcbValue;
    MEM_ReleaseHeap(rgbValue,size);
    return;
}
// GetFunctions
void odbcGetFunctions(HENV henv,HDBC hdbc,UNSIGNED Function,UNSIGNED FAR *Exists)
{
    UWORD     fFunction;
    UWORD     fExists;
    odbc_check_loading("odbcGetFunctions");
    switch(Function)
    {
        case(ODBC_API_SQLALLOCCONNECT)     : fFunction=SQL_API_SQLALLOCCONNECT;   break;
        case(ODBC_API_SQLALLOCENV)         : fFunction=SQL_API_SQLALLOCENV;       break;
        case(ODBC_API_SQLALLOCSTMT)        : fFunction=SQL_API_SQLALLOCSTMT;      break;
        case(ODBC_API_SQLBINDCOL)          : fFunction=SQL_API_SQLBINDCOL;        break;
        case(ODBC_API_SQLCANCEL)           : fFunction=SQL_API_SQLCANCEL;         break;
        case(ODBC_API_SQLCOLATTRIBUTES)    : fFunction=SQL_API_SQLCOLATTRIBUTES;  break;
        case(ODBC_API_SQLCONNECT)          : fFunction=SQL_API_SQLCONNECT;        break;
        case(ODBC_API_SQLDESCRIBECOL)      : fFunction=SQL_API_SQLDESCRIBECOL;    break;
        case(ODBC_API_SQLDISCONNECT)       : fFunction=SQL_API_SQLDISCONNECT;     break;
        case(ODBC_API_SQLERROR)            : fFunction=SQL_API_SQLERROR;          break;
        case(ODBC_API_SQLEXECDIRECT)       : fFunction=SQL_API_SQLEXECDIRECT;     break;
        case(ODBC_API_SQLEXECUTE)          : fFunction=SQL_API_SQLEXECUTE;        break;
        case(ODBC_API_SQLFETCH)            : fFunction=SQL_API_SQLFETCH;          break;
        case(ODBC_API_SQLFREECONNECT)      : fFunction=SQL_API_SQLFREECONNECT;    break;
        case(ODBC_API_SQLFREEENV)          : fFunction=SQL_API_SQLFREEENV;        break;
        case(ODBC_API_SQLFREESTMT)         : fFunction=SQL_API_SQLFREESTMT;       break;
        case(ODBC_API_SQLGETCURSORNAME)    : fFunction=SQL_API_SQLGETCURSORNAME;  break;
        case(ODBC_API_SQLNUMRESULTCOLS)    : fFunction=SQL_API_SQLNUMRESULTCOLS;  break;
        case(ODBC_API_SQLPREPARE)          : fFunction=SQL_API_SQLPREPARE;        break;
        case(ODBC_API_SQLROWCOUNT)         : fFunction=SQL_API_SQLROWCOUNT;       break;
        case(ODBC_API_SQLSETCURSORNAME)    : fFunction=SQL_API_SQLSETCURSORNAME;  break;
        case(ODBC_API_SQLSETPARAM)         : fFunction=SQL_API_SQLSETPARAM;       break;
        case(ODBC_API_SQLTRANSACT)         : fFunction=SQL_API_SQLTRANSACT;       break;
        case(ODBC_API_SQLBINDPARAMETER)    : fFunction=SQL_API_SQLBINDPARAMETER;  break;
        case(ODBC_API_SQLCOLUMNS)          : fFunction=SQL_API_SQLCOLUMNS;        break;
        case(ODBC_API_SQLDRIVERCONNECT)    : fFunction=SQL_API_SQLDRIVERCONNECT;  break;
        case(ODBC_API_SQLGETCONNECTOPTION) : fFunction=SQL_API_SQLGETCONNECTOPTION;break;
        case(ODBC_API_SQLGETDATA)          : fFunction=SQL_API_SQLGETDATA;        break;
        case(ODBC_API_SQLGETFUNCTIONS)     : fFunction=SQL_API_SQLGETFUNCTIONS;   break;
        case(ODBC_API_SQLGETINFO)          : fFunction=SQL_API_SQLGETINFO;        break;
        case(ODBC_API_SQLGETSTMTOPTION)    : fFunction=SQL_API_SQLGETSTMTOPTION;  break;
        case(ODBC_API_SQLGETTYPEINFO)      : fFunction=SQL_API_SQLGETTYPEINFO;    break;
        case(ODBC_API_SQLPARAMDATA)        : fFunction=SQL_API_SQLPARAMDATA;      break;
        case(ODBC_API_SQLPUTDATA)          : fFunction=SQL_API_SQLPUTDATA;        break;
        case(ODBC_API_SQLSETCONNECTOPTION) : fFunction=SQL_API_SQLSETCONNECTOPTION;break;
        case(ODBC_API_SQLSETSTMTOPTION)    : fFunction=SQL_API_SQLSETSTMTOPTION;  break;
        case(ODBC_API_SQLSPECIALCOLUMNS)   : fFunction=SQL_API_SQLSPECIALCOLUMNS; break;
        case(ODBC_API_SQLSTATISTICS)       : fFunction=SQL_API_SQLSTATISTICS;     break;
        case(ODBC_API_SQLTABLES)           : fFunction=SQL_API_SQLTABLES;         break;
        case(ODBC_API_SQLBROWSECONNECT)    : fFunction=SQL_API_SQLBROWSECONNECT;  break;
        case(ODBC_API_SQLCOLUMNPRIVILEGES) : fFunction=SQL_API_SQLCOLUMNPRIVILEGES;break;
        case(ODBC_API_SQLDATASOURCES)      : fFunction=SQL_API_SQLDATASOURCES;    break;
        case(ODBC_API_SQLDESCRIBEPARAM)    : fFunction=SQL_API_SQLDESCRIBEPARAM;  break;
        case(ODBC_API_SQLDRIVERS)          : fFunction=SQL_API_SQLDRIVERS;        break;
        case(ODBC_API_SQLEXTENDEDFETCH)    : fFunction=SQL_API_SQLEXTENDEDFETCH;  break;
        case(ODBC_API_SQLFOREIGNKEYS)      : fFunction=SQL_API_SQLFOREIGNKEYS;    break;
        case(ODBC_API_SQLMORERESULTS)      : fFunction=SQL_API_SQLMORERESULTS;    break;
        case(ODBC_API_SQLNATIVESQL)        : fFunction=SQL_API_SQLNATIVESQL;      break;
        case(ODBC_API_SQLNUMPARAMS)        : fFunction=SQL_API_SQLNUMPARAMS;      break;
        case(ODBC_API_SQLPARAMOPTIONS)     : fFunction=SQL_API_SQLPARAMOPTIONS;   break;
        case(ODBC_API_SQLPRIMARYKEYS)      : fFunction=SQL_API_SQLPRIMARYKEYS;    break;
        case(ODBC_API_SQLPROCEDURECOLUMNS) : fFunction=SQL_API_SQLPROCEDURECOLUMNS;break;
        case(ODBC_API_SQLPROCEDURES)       : fFunction=SQL_API_SQLPROCEDURES;     break;
        case(ODBC_API_SQLSETPOS)           : fFunction=SQL_API_SQLSETPOS;         break;
        case(ODBC_API_SQLSETSCROLLOPTIONS) : fFunction=SQL_API_SQLSETSCROLLOPTIONS;break;
        case(ODBC_API_SQLTABLEPRIVILEGES)  : fFunction=SQL_API_SQLTABLEPRIVILEGES;break;
        default:
            GlobErr=ODBC_UNKNOWN_FUNCTION;
            odbcMyError(ODBC_ERROR,"odbcGetFunctions",SQL_NULL_HENV,SQL_NULL_HDBC,SQL_NULL_HSTMT);
            break;
    }
    odbcMyError(
        (RETCODE)SQLGetFunctions((HDBC)hdbc,(UWORD)fFunction,(UWORD FAR *)&fExists),
        "SQLGetFunctions",henv,hdbc,SQL_NULL_HSTMT);
    *Exists=fExists;
    return;
}
// GetInfo
void odbcGetInfo(HENV henv,HDBC hdbc,UNSIGNED dataType,ODBC_INFO_DATA FAR **Data)
{
    UWORD        fInfoType;
    UCHAR        rgbInfoValue[SQL_MAX_MESSAGE_LENGTH]="0";
	 SWORD        pcbInfoValue;
    ODBC_INFO_DATA     *colData;
    odbc_check_loading("odbcGetInfo");
    switch(dataType)
    {
        case(ODBC_ACTIVE_CONNECTIONS)      : fInfoType=SQL_ACTIVE_CONNECTIONS;       break;
        case(ODBC_ACTIVE_STATEMENTS)       : fInfoType=SQL_ACTIVE_STATEMENTS;        break;
        case(ODBC_DATA_SOURCE_NAME)        : fInfoType=SQL_DATA_SOURCE_NAME;         break;
        case(ODBC_DRIVER_HDBC)             : fInfoType=SQL_DRIVER_HDBC;              break;
        case(ODBC_DRIVER_HENV)             : fInfoType=SQL_DRIVER_HENV;              break;
        case(ODBC_DRIVER_HLIB)             : fInfoType=SQL_DRIVER_HLIB;              break;
        case(ODBC_DRIVER_HSTMT)            : fInfoType=SQL_DRIVER_HSTMT;             break;
        case(ODBC_DRIVER_NAME)             : fInfoType=SQL_DRIVER_NAME;              break;
        case(ODBC_DRIVER_ODBC_VER)         : fInfoType=SQL_DRIVER_ODBC_VER;          break;
        case(ODBC_DRIVER_VER)              : fInfoType=SQL_DRIVER_VER;               break;
        case(ODBC_FETCH_DIRECTION)         : fInfoType=SQL_FETCH_DIRECTION;          break;
        case(ODBC_FILE_USAGE)              : fInfoType=SQL_FILE_USAGE;               break;
        case(ODBC_GETDATA_EXTENSIONS)      : fInfoType=SQL_GETDATA_EXTENSIONS;       break;
        case(ODBC_LOCK_TYPES)              : fInfoType=SQL_LOCK_TYPES;               break;
        case(ODBC_ODBC_API_CONFORMANCE)    : fInfoType=SQL_ODBC_API_CONFORMANCE;     break;
        case(ODBC_ODBC_SAG_CLI_CONFORMANCE): fInfoType=SQL_ODBC_SAG_CLI_CONFORMANCE; break;
        case(ODBC_ODBC_VER)                : fInfoType=SQL_ODBC_VER;                 break;
        case(ODBC_POS_OPERATIONS)          : fInfoType=SQL_POS_OPERATIONS;           break;
        case(ODBC_ROW_UPDATES)             : fInfoType=SQL_ROW_UPDATES;              break;
        case(ODBC_SEARCH_PATTERN_ESCAPE)   : fInfoType=SQL_SEARCH_PATTERN_ESCAPE;    break;
        case(ODBC_SERVER_NAME)             : fInfoType=SQL_SERVER_NAME;              break;
        case(ODBC_DATABASE_NAME)           : fInfoType=SQL_DATABASE_NAME;            break;
        case(ODBC_DBMS_NAME)               : fInfoType=SQL_DBMS_NAME;                break;
        case(ODBC_DBMS_VER)                : fInfoType=SQL_DBMS_VER;                 break;
        case(ODBC_ACCESSIBLE_PROCEDURES)   : fInfoType=SQL_ACCESSIBLE_PROCEDURES;    break;
        case(ODBC_ACCESSIBLE_TABLES)       : fInfoType=SQL_ACCESSIBLE_TABLES;        break;
        case(ODBC_BOOKMARK_PERSISTENCE)    : fInfoType=SQL_BOOKMARK_PERSISTENCE;     break;
        case(ODBC_CONCAT_NULL_BEHAVIOR)    : fInfoType=SQL_CONCAT_NULL_BEHAVIOR;     break;
        case(ODBC_CURSOR_COMMIT_BEHAVIOR)  : fInfoType=SQL_CURSOR_COMMIT_BEHAVIOR;   break;
        case(ODBC_CURSOR_ROLLBACK_BEHAVIOR): fInfoType=SQL_CURSOR_ROLLBACK_BEHAVIOR; break;
        case(ODBC_DATA_SOURCE_READ_ONLY)   : fInfoType=SQL_DATA_SOURCE_READ_ONLY;    break;
        case(ODBC_DEFAULT_TXN_ISOLATION)   : fInfoType=SQL_DEFAULT_TXN_ISOLATION;    break;
        case(ODBC_MULT_RESULT_SETS)        : fInfoType=SQL_MULT_RESULT_SETS;         break;
        case(ODBC_MULTIPLE_ACTIVE_TXN)     : fInfoType=SQL_MULTIPLE_ACTIVE_TXN;      break;
        case(ODBC_NEED_LONG_DATA_LEN)      : fInfoType=SQL_NEED_LONG_DATA_LEN;       break;
        case(ODBC_NULL_COLLATION)          : fInfoType=SQL_NULL_COLLATION;           break;
        case(ODBC_OWNER_TERM)              : fInfoType=SQL_OWNER_TERM;               break;
        case(ODBC_PROCEDURE_TERM)          : fInfoType=SQL_PROCEDURE_TERM;           break;
        case(ODBC_QUALIFIER_TERM)          : fInfoType=SQL_QUALIFIER_TERM;           break;
        case(ODBC_SCROLL_CONCURRENCY)      : fInfoType=SQL_SCROLL_CONCURRENCY;       break;
        case(ODBC_SCROLL_OPTIONS)          : fInfoType=SQL_SCROLL_OPTIONS;           break;
        case(ODBC_STATIC_SENSITIVITY)      : fInfoType=SQL_STATIC_SENSITIVITY;       break;
        case(ODBC_TABLE_TERM)              : fInfoType=SQL_TABLE_TERM;               break;
        case(ODBC_TXN_CAPABLE)             : fInfoType=SQL_TXN_CAPABLE;              break;
        case(ODBC_TXN_ISOLATION_OPTION)    : fInfoType=SQL_TXN_ISOLATION_OPTION;     break;
        case(ODBC_USER_NAME)               : fInfoType=SQL_USER_NAME;                break;
        case(ODBC_ALTER_TABLE)             : fInfoType=SQL_ALTER_TABLE;              break;
        case(ODBC_COLUMN_ALIAS)            : fInfoType=SQL_COLUMN_ALIAS;             break;
        case(ODBC_CORRELATION_NAME)        : fInfoType=SQL_CORRELATION_NAME;         break;
        case(ODBC_EXPRESSIONS_IN_ORDERBY)  : fInfoType=SQL_EXPRESSIONS_IN_ORDERBY;   break;
        case(ODBC_GROUP_BY)                : fInfoType=SQL_GROUP_BY;                 break;
        case(ODBC_IDENTIFIER_CASE)         : fInfoType=SQL_IDENTIFIER_CASE;          break;
        case(ODBC_IDENTIFIER_QUOTE_CHAR)   : fInfoType=SQL_IDENTIFIER_QUOTE_CHAR;    break;
        case(ODBC_KEYWORDS)                : fInfoType=SQL_KEYWORDS;                 break;
        case(ODBC_LIKE_ESCAPE_CLAUSE)      : fInfoType=SQL_LIKE_ESCAPE_CLAUSE;       break;
        case(ODBC_NON_NULLABLE_COLUMNS)    : fInfoType=SQL_NON_NULLABLE_COLUMNS;     break;
        case(ODBC_ODBC_SQL_CONFORMANCE)    : fInfoType=SQL_ODBC_SQL_CONFORMANCE;     break;
        case(ODBC_ODBC_SQL_OPT_IEF)        : fInfoType=SQL_ODBC_SQL_OPT_IEF;         break;
        case(ODBC_ORDER_BY_COLUMNS_IN_SELECT): fInfoType=SQL_ORDER_BY_COLUMNS_IN_SELECT;break;
        case(ODBC_OUTER_JOINS)             : fInfoType=SQL_OUTER_JOINS;              break;
        case(ODBC_OWNER_USAGE)             : fInfoType=SQL_OWNER_USAGE;              break;
        case(ODBC_POSITIONED_STATEMENTS)   : fInfoType=SQL_POSITIONED_STATEMENTS;    break;
        case(ODBC_PROCEDURES)              : fInfoType=SQL_PROCEDURES;               break;
        case(ODBC_QUALIFIER_LOCATION)      : fInfoType=SQL_QUALIFIER_LOCATION;       break;
        case(ODBC_QUALIFIER_NAME_SEPARATOR): fInfoType=SQL_QUALIFIER_NAME_SEPARATOR; break;
        case(ODBC_QUALIFIER_USAGE)         : fInfoType=SQL_QUALIFIER_USAGE;          break;
        case(ODBC_QUOTED_IDENTIFIER_CASE)  : fInfoType=SQL_QUOTED_IDENTIFIER_CASE;   break;
        case(ODBC_SPECIAL_CHARACTERS)      : fInfoType=SQL_SPECIAL_CHARACTERS;       break;
        case(ODBC_SUBQUERIES)              : fInfoType=SQL_SUBQUERIES;               break;
        case(ODBC_UNION)                   : fInfoType=SQL_UNION;                    break;
        case(ODBC_MAX_BINARY_LITERAL_LEN)  : fInfoType=SQL_MAX_BINARY_LITERAL_LEN;   break;
        case(ODBC_MAX_CHAR_LITERAL_LEN)    : fInfoType=SQL_MAX_CHAR_LITERAL_LEN;     break;
        case(ODBC_MAX_COLUMN_NAME_LEN)     : fInfoType=SQL_MAX_COLUMN_NAME_LEN;      break;
        case(ODBC_MAX_COLUMNS_IN_GROUP_BY) : fInfoType=SQL_MAX_COLUMNS_IN_GROUP_BY;  break;
        case(ODBC_MAX_COLUMNS_IN_ORDER_BY) : fInfoType=SQL_MAX_COLUMNS_IN_ORDER_BY;  break;
        case(ODBC_MAX_COLUMNS_IN_INDEX)    : fInfoType=SQL_MAX_COLUMNS_IN_INDEX;     break;
        case(ODBC_MAX_COLUMNS_IN_SELECT)   : fInfoType=SQL_MAX_COLUMNS_IN_SELECT;    break;
        case(ODBC_MAX_COLUMNS_IN_TABLE)    : fInfoType=SQL_MAX_COLUMNS_IN_TABLE;     break;
        case(ODBC_MAX_CURSOR_NAME_LEN)     : fInfoType=SQL_MAX_CURSOR_NAME_LEN;      break;
        case(ODBC_MAX_INDEX_SIZE)          : fInfoType=SQL_MAX_INDEX_SIZE;           break;
        case(ODBC_MAX_OWNER_NAME_LEN)      : fInfoType=SQL_MAX_OWNER_NAME_LEN;       break;
        case(ODBC_MAX_PROCEDURE_NAME_LEN)  : fInfoType=SQL_MAX_PROCEDURE_NAME_LEN;   break;
        case(ODBC_MAX_QUALIFIER_NAME_LEN)  : fInfoType=SQL_MAX_QUALIFIER_NAME_LEN;   break;
        case(ODBC_MAX_ROW_SIZE)            : fInfoType=SQL_MAX_ROW_SIZE;             break;
        case(ODBC_MAX_ROW_SIZE_INCLUDES_LONG): fInfoType=SQL_MAX_ROW_SIZE_INCLUDES_LONG;break;
        case(ODBC_MAX_STATEMENT_LEN)       : fInfoType=SQL_MAX_STATEMENT_LEN;        break;
        case(ODBC_MAX_TABLE_NAME_LEN)      : fInfoType=SQL_MAX_TABLE_NAME_LEN;       break;
        case(ODBC_MAX_TABLES_IN_SELECT)    : fInfoType=SQL_MAX_TABLES_IN_SELECT;     break;
        case(ODBC_MAX_USER_NAME_LEN)       : fInfoType=SQL_MAX_USER_NAME_LEN;        break;
        case(ODBC_CONVERT_FUNCTIONS)       : fInfoType=SQL_CONVERT_FUNCTIONS;        break;
        case(ODBC_NUMERIC_FUNCTIONS)       : fInfoType=SQL_NUMERIC_FUNCTIONS;        break;
        case(ODBC_STRING_FUNCTIONS)        : fInfoType=SQL_STRING_FUNCTIONS;         break;
        case(ODBC_SYSTEM_FUNCTIONS)        : fInfoType=SQL_SYSTEM_FUNCTIONS;         break;
        case(ODBC_TIMEDATE_ADD_INTERVALS)  : fInfoType=SQL_TIMEDATE_ADD_INTERVALS;   break;
        case(ODBC_TIMEDATE_DIFF_INTERVALS) : fInfoType=SQL_TIMEDATE_DIFF_INTERVALS;  break;
        case(ODBC_TIMEDATE_FUNCTIONS)      : fInfoType=SQL_TIMEDATE_FUNCTIONS;       break;
        case(ODBC_CONVERT_BIGINT)          : fInfoType=SQL_CONVERT_BIGINT;           break;
        case(ODBC_CONVERT_BINARY)          : fInfoType=SQL_CONVERT_BINARY;           break;
        case(ODBC_CONVERT_BIT)             : fInfoType=SQL_CONVERT_BIT;              break;
        case(ODBC_CONVERT_CHAR)            : fInfoType=SQL_CONVERT_CHAR;             break;
        case(ODBC_CONVERT_DATE)            : fInfoType=SQL_CONVERT_DATE;             break;
        case(ODBC_CONVERT_DECIMAL)         : fInfoType=SQL_CONVERT_DECIMAL;          break;
        case(ODBC_CONVERT_DOUBLE)          : fInfoType=SQL_CONVERT_DOUBLE;           break;
        case(ODBC_CONVERT_FLOAT)           : fInfoType=SQL_CONVERT_FLOAT;            break;
        case(ODBC_CONVERT_INTEGER)         : fInfoType=SQL_CONVERT_INTEGER;          break;
        case(ODBC_CONVERT_LONGVARBINARY)   : fInfoType=SQL_CONVERT_LONGVARBINARY;    break;
        case(ODBC_CONVERT_LONGVARCHAR)     : fInfoType=SQL_CONVERT_LONGVARCHAR;      break;
        case(ODBC_CONVERT_NUMERIC)         : fInfoType=SQL_CONVERT_NUMERIC;          break;
        case(ODBC_CONVERT_REAL)            : fInfoType=SQL_CONVERT_REAL;             break;
        case(ODBC_CONVERT_SMALLINT)        : fInfoType=SQL_CONVERT_SMALLINT;         break;
        case(ODBC_CONVERT_TIME)            : fInfoType=SQL_CONVERT_TIME;             break;
        case(ODBC_CONVERT_TIMESTAMP)       : fInfoType=SQL_CONVERT_TIMESTAMP;        break;
        case(ODBC_CONVERT_TINYINT)         : fInfoType=SQL_CONVERT_TINYINT;          break;
        case(ODBC_CONVERT_VARBINARY)       : fInfoType=SQL_CONVERT_VARBINARY;        break;
        case(ODBC_CONVERT_VARCHAR)         : fInfoType=SQL_CONVERT_VARCHAR;          break;
        default:
            GlobErr=ODBC_UNKNOWN_INFO_TYPE;
            odbcMyError(ODBC_ERROR,"odbcGetInfo",SQL_NULL_HENV,SQL_NULL_HDBC,SQL_NULL_HSTMT);
            break;
    }
    odbcMyError(
        (RETCODE)SQLGetInfo((HDBC)hdbc,(UWORD)fInfoType,(PTR)rgbInfoValue,(SWORD)SQL_MAX_MESSAGE_LENGTH,
            (SWORD FAR *)&pcbInfoValue),
        "SQLGetInfo",henv,hdbc,SQL_NULL_HSTMT);
    colData=MEM_AllocGStack(sizeof(ODBC_INFO_DATA));
    switch(dataType)
    {
// Integer data
        case(ODBC_ACTIVE_CONNECTIONS):
        case(ODBC_ACTIVE_STATEMENTS):
        case(ODBC_FILE_USAGE):
        case(ODBC_ODBC_API_CONFORMANCE):
        case(ODBC_ODBC_SAG_CLI_CONFORMANCE):
        case(ODBC_CONCAT_NULL_BEHAVIOR):
        case(ODBC_CURSOR_COMMIT_BEHAVIOR):
        case(ODBC_CURSOR_ROLLBACK_BEHAVIOR):
        case(ODBC_NULL_COLLATION):
        case(ODBC_TXN_CAPABLE):
        case(ODBC_CORRELATION_NAME):
        case(ODBC_GROUP_BY):
        case(ODBC_IDENTIFIER_CASE):
        case(ODBC_NON_NULLABLE_COLUMNS):
        case(ODBC_ODBC_SQL_CONFORMANCE):
        case(ODBC_QUALIFIER_LOCATION):
        case(ODBC_QUOTED_IDENTIFIER_CASE):
        case(ODBC_MAX_COLUMN_NAME_LEN):
        case(ODBC_MAX_COLUMNS_IN_GROUP_BY):
        case(ODBC_MAX_COLUMNS_IN_ORDER_BY):
        case(ODBC_MAX_COLUMNS_IN_INDEX):
        case(ODBC_MAX_COLUMNS_IN_SELECT):
        case(ODBC_MAX_COLUMNS_IN_TABLE):
        case(ODBC_MAX_CURSOR_NAME_LEN):
        case(ODBC_MAX_OWNER_NAME_LEN):
        case(ODBC_MAX_PROCEDURE_NAME_LEN):
        case(ODBC_MAX_QUALIFIER_NAME_LEN):
        case(ODBC_MAX_TABLE_NAME_LEN):
        case(ODBC_MAX_TABLES_IN_SELECT):
        case(ODBC_MAX_USER_NAME_LEN):
            DATAINFF=f_i;
            odbc_mem_copy(rgbInfoValue,&DATAINFI,sizeof(int));
            break;
// Long data
        case(ODBC_DRIVER_HDBC):
        case(ODBC_DRIVER_HENV):
        case(ODBC_DRIVER_HLIB):
        case(ODBC_DRIVER_HSTMT):
        case(ODBC_FETCH_DIRECTION):
        case(ODBC_GETDATA_EXTENSIONS):
        case(ODBC_LOCK_TYPES):
        case(ODBC_POS_OPERATIONS):
        case(ODBC_BOOKMARK_PERSISTENCE):
        case(ODBC_DEFAULT_TXN_ISOLATION):
        case(ODBC_SCROLL_CONCURRENCY):
        case(ODBC_SCROLL_OPTIONS):
        case(ODBC_STATIC_SENSITIVITY):
        case(ODBC_TXN_ISOLATION_OPTION):
        case(ODBC_ALTER_TABLE):
        case(ODBC_OWNER_USAGE):
        case(ODBC_POSITIONED_STATEMENTS):
        case(ODBC_QUALIFIER_USAGE):
        case(ODBC_SUBQUERIES):
        case(ODBC_UNION):
        case(ODBC_MAX_BINARY_LITERAL_LEN):
        case(ODBC_MAX_CHAR_LITERAL_LEN):
        case(ODBC_MAX_INDEX_SIZE):
        case(ODBC_MAX_ROW_SIZE):
        case(ODBC_MAX_STATEMENT_LEN):
        case(ODBC_CONVERT_FUNCTIONS):
        case(ODBC_NUMERIC_FUNCTIONS):
        case(ODBC_STRING_FUNCTIONS):
        case(ODBC_SYSTEM_FUNCTIONS):
        case(ODBC_TIMEDATE_ADD_INTERVALS):
        case(ODBC_TIMEDATE_DIFF_INTERVALS):
        case(ODBC_TIMEDATE_FUNCTIONS):
        case(ODBC_CONVERT_BIGINT):
        case(ODBC_CONVERT_BINARY):
        case(ODBC_CONVERT_BIT):
        case(ODBC_CONVERT_CHAR):
        case(ODBC_CONVERT_DATE):
        case(ODBC_CONVERT_DECIMAL):
        case(ODBC_CONVERT_DOUBLE):
        case(ODBC_CONVERT_FLOAT):
        case(ODBC_CONVERT_INTEGER):
        case(ODBC_CONVERT_LONGVARBINARY):
        case(ODBC_CONVERT_LONGVARCHAR):
        case(ODBC_CONVERT_NUMERIC):
        case(ODBC_CONVERT_REAL):
        case(ODBC_CONVERT_SMALLINT):
        case(ODBC_CONVERT_TIME):
        case(ODBC_CONVERT_TIMESTAMP):
        case(ODBC_CONVERT_TINYINT):
        case(ODBC_CONVERT_VARBINARY):
        case(ODBC_CONVERT_VARCHAR):
            DATAINFF=f_l;
            odbc_mem_copy(rgbInfoValue,&DATAINFI,sizeof(long));
            break;
// String data
        case(ODBC_DATA_SOURCE_NAME):
        case(ODBC_DRIVER_NAME):
        case(ODBC_DRIVER_ODBC_VER):
        case(ODBC_DRIVER_VER):
        case(ODBC_ODBC_VER):
        case(ODBC_ROW_UPDATES):
        case(ODBC_SEARCH_PATTERN_ESCAPE):
        case(ODBC_SERVER_NAME):
        case(ODBC_DATABASE_NAME):
        case(ODBC_DBMS_NAME):
        case(ODBC_DBMS_VER):
        case(ODBC_ACCESSIBLE_PROCEDURES):
        case(ODBC_ACCESSIBLE_TABLES):
        case(ODBC_DATA_SOURCE_READ_ONLY):
        case(ODBC_MULT_RESULT_SETS):
        case(ODBC_MULTIPLE_ACTIVE_TXN):
        case(ODBC_NEED_LONG_DATA_LEN):
        case(ODBC_OWNER_TERM):
        case(ODBC_PROCEDURE_TERM):
        case(ODBC_QUALIFIER_TERM):
        case(ODBC_TABLE_TERM):
        case(ODBC_USER_NAME):
        case(ODBC_COLUMN_ALIAS):
        case(ODBC_EXPRESSIONS_IN_ORDERBY):
        case(ODBC_IDENTIFIER_QUOTE_CHAR):
        case(ODBC_KEYWORDS):
        case(ODBC_LIKE_ESCAPE_CLAUSE):
        case(ODBC_ODBC_SQL_OPT_IEF):
        case(ODBC_ORDER_BY_COLUMNS_IN_SELECT):
        case(ODBC_OUTER_JOINS):
        case(ODBC_PROCEDURES):
        case(ODBC_QUALIFIER_NAME_SEPARATOR):
        case(ODBC_SPECIAL_CHARACTERS):
        case(ODBC_MAX_ROW_SIZE_INCLUDES_LONG):
            DATAINFF=f_s;
            DATAS=MEM_SaveStringGStack(rgbInfoValue);
            break;
    }
    *Data=colData;
    return;
}
// GetStmtOption
void odbcGetStmtOption(HENV henv,HDBC hdbc,HSTMT hstmt,UNSIGNED Option,UDWORD FAR *Param)
{
    UWORD  fOption;
    UCHAR  pvParam[SQL_MAX_OPTION_STRING_LENGTH]="0";
    UDWORD vParam;
    odbc_check_loading("odbcGetStmtOption");
    switch(Option)
    {
        case(ODBC_ASYNC_ENABLE)     : fOption=SQL_ASYNC_ENABLE;    break;
        case(ODBC_BIND_TYPE)        : fOption=SQL_BIND_TYPE;       break;
        case(ODBC_CONCURRENCY)      : fOption=SQL_CONCURRENCY;     break;
        case(ODBC_CURSOR_TYPE)      : fOption=SQL_CURSOR_TYPE;     break;
        case(ODBC_KEYSET_SIZE)      : fOption=SQL_KEYSET_SIZE;     break;
        case(ODBC_MAX_LENGTH)       : fOption=SQL_MAX_LENGTH;      break;
        case(ODBC_MAX_ROWS)         : fOption=SQL_MAX_ROWS;        break;
        case(ODBC_NOSCAN)           : fOption=SQL_NOSCAN;          break;
        case(ODBC_QUERY_TIMEOUT)    : fOption=SQL_QUERY_TIMEOUT;   break;
        case(ODBC_RETRIEVE_DATA)    : fOption=SQL_RETRIEVE_DATA;   break;
        case(ODBC_ROWSET_SIZE)      : fOption=SQL_ROWSET_SIZE;     break;
        case(ODBC_SIMULATE_CURSOR)  : fOption=SQL_SIMULATE_CURSOR; break;
        case(ODBC_USE_BOOKMARKS)    : fOption=SQL_USE_BOOKMARKS;   break;
        case(ODBC_GET_BOOKMARK)     : fOption=SQL_GET_BOOKMARK;    break;
        case(ODBC_ROW_NUMBER)       : fOption=SQL_ROW_NUMBER;      break;
        default:
            GlobErr=ODBC_UNKNOWN_OPTION;
            odbcMyError(ODBC_ERROR,"odbcGetStmtOption",SQL_NULL_HENV,SQL_NULL_HDBC,SQL_NULL_HSTMT);
            break;
    }
    odbcMyError(
        (RETCODE)SQLGetStmtOption((HSTMT)hstmt,(UWORD)fOption,(PTR)pvParam),
        "SQLGetStmtOption",henv,hdbc,hstmt);
    odbc_mem_copy(pvParam,&vParam,sizeof(UDWORD));
    switch(Option)
    {
        case(ODBC_ASYNC_ENABLE):
            switch(vParam)
            {
                case(SQL_ASYNC_ENABLE_OFF)  : *Param=ODBC_ASYNC_ENABLE_OFF;     break;
                case(SQL_ASYNC_ENABLE_ON)   : *Param=ODBC_ASYNC_ENABLE_ON;      break;
                default                     : *Param=vParam;                    break;
            }
            break;
        case(ODBC_BIND_TYPE):
            switch(vParam)
            {
                case(SQL_BIND_BY_COLUMN) : *Param=ODBC_BIND_BY_COLUMN;    break;
                default                  : *Param=vParam;                 break;
            }
            break;
        case(ODBC_CONCURRENCY):
            switch(vParam)
            {
                case(SQL_CONCUR_READ_ONLY)  : *Param=ODBC_CONCUR_READ_ONLY;  break;
                case(SQL_CONCUR_LOCK)       : *Param=ODBC_CONCUR_LOCK;       break;
                case(SQL_CONCUR_ROWVER)     : *Param=ODBC_CONCUR_ROWVER;     break;
                case(SQL_CONCUR_VALUES)     : *Param=ODBC_CONCUR_VALUES;     break;
                default                     : *Param=vParam;                 break;
            }
            break;
        case(ODBC_CURSOR_TYPE):
            switch(vParam)
            {
                case(SQL_CURSOR_FORWARD_ONLY)  : *Param=ODBC_CURSOR_FORWARD_ONLY;  break;
                case(SQL_CURSOR_STATIC)        : *Param=ODBC_CURSOR_STATIC;        break;
                case(SQL_CURSOR_KEYSET_DRIVEN) : *Param=ODBC_CURSOR_KEYSET_DRIVEN; break;
                case(SQL_CURSOR_DYNAMIC)       : *Param=ODBC_CURSOR_DYNAMIC;       break;
                default                        : *Param=vParam;                    break;
            }
            break;
        case(ODBC_KEYSET_SIZE):
            *Param=vParam;
            break;
        case(ODBC_MAX_LENGTH):
            *Param=vParam;
            break;
        case(ODBC_MAX_ROWS):
            *Param=vParam;
            break;
        case(ODBC_NOSCAN):
            switch(vParam)
            {
                case(SQL_NOSCAN_OFF)  : *Param=ODBC_NOSCAN_OFF;  break;
                case(SQL_NOSCAN_ON)   : *Param=ODBC_NOSCAN_ON;   break;
                default               : *Param=vParam;           break;
            }
            break;
        case(ODBC_QUERY_TIMEOUT):
            *Param=vParam;
            break;
        case(ODBC_RETRIEVE_DATA):
            switch(vParam)
            {
                case(SQL_RD_ON)    : *Param=ODBC_RD_ON;       break;
                case(SQL_RD_OFF)   : *Param=ODBC_RD_OFF;      break;
                default            : *Param=vParam;           break;
            }
            break;
        case(ODBC_ROWSET_SIZE):
            *Param=vParam;
            break;
        case(ODBC_SIMULATE_CURSOR):
            switch(vParam)
            {
                case(SQL_SC_NON_UNIQUE)  : *Param=ODBC_SC_NON_UNIQUE;  break;
                case(SQL_SC_TRY_UNIQUE)  : *Param=ODBC_SC_TRY_UNIQUE;  break;
                case(SQL_SC_UNIQUE)      : *Param=ODBC_SC_UNIQUE;      break;
                default                  : *Param=vParam;              break;
            }
            break;
        case(ODBC_USE_BOOKMARKS):
            switch(vParam)
            {
                case(SQL_UB_OFF)   : *Param=ODBC_UB_OFF;   break;
                case(SQL_UB_ON)    : *Param=ODBC_UB_ON;    break;
                default            : *Param=vParam;        break;
            }
            break;
        case(ODBC_GET_BOOKMARK):
            *Param=vParam;
            break;
        case(ODBC_ROW_NUMBER):
            *Param=vParam;
            break;
    }
    return;
}
// GetTypeInfo
void odbcGetTypeInfo(HENV henv,HDBC hdbc,HSTMT hstmt,UNSIGNED dataType)
{
    SWORD     fSqlType;
    odbc_check_loading("odbcGetTypeInfo");
    switch(dataType)
    {
        case(ODBC_STRING)   : fSqlType=SQL_CHAR;       break;
        case(ODBC_MEMO)     : fSqlType=SQL_LONGVARCHAR; break;
        case(ODBC_BIT)      : fSqlType=SQL_BIT;        break;
        case(ODBC_BYTE)     : fSqlType=SQL_TINYINT;    break;
        case(ODBC_INTEGER)  : fSqlType=SQL_INTEGER_X;  break;
        case(ODBC_LONG)     : fSqlType=SQL_INTEGER;    break;
        case(ODBC_FLOAT)    : fSqlType=SQL_REAL;       break;
        case(ODBC_REAL)     : fSqlType=SQL_FLOAT;      break;
        case(ODBC_DATE)     : fSqlType=SQL_C_DATE;     break;
        case(ODBC_TIME)     : fSqlType=SQL_TIME;       break;
        case(ODBC_TIMESTAMP): fSqlType=SQL_TIMESTAMP;  break;
        case(ODBC_BINARY)   : fSqlType=SQL_LONGVARBINARY; break;
        case(ODBC_NUMERIC)  : fSqlType=SQL_NUMERIC;    break;
        default:
            GlobErr=ODBC_UNKNOWN_DATA_TYPE;
            odbcMyError(ODBC_ERROR,"odbcGetTypeInfo",SQL_NULL_HENV,SQL_NULL_HDBC,SQL_NULL_HSTMT);
            break;
    }
    odbcMyError(
        (RETCODE)SQLGetTypeInfo((HSTMT)hstmt,(SWORD)fSqlType),
        "SQLGetTypeInfo",henv,hdbc,hstmt);
    return;
}
// MoreResults
void odbcMoreResults(HENV henv,HDBC hdbc,HSTMT hstmt)
{
    odbc_check_loading("odbcMoreResults");
    odbcMyError(
        (RETCODE)SQLMoreResults((HSTMT)hstmt),
        "SQLMoreResults",henv,hdbc,hstmt);
    return;
}
// NativeSql
void odbcNativeSql(HENV henv,HDBC hdbc,STRING SqlStrIn,STRING FAR *SqlStr)
{
    UCHAR szSqlStr[1000]="0";
    SDWORD pcbSqlStr;
    odbc_check_loading("odbcNativeSql");
    odbcMyError(
        (RETCODE)SQLNativeSql((HDBC)hdbc,(UCHAR FAR *)SqlStrIn,(SDWORD)odbc_len_str(SqlStrIn),
            (UCHAR FAR *)szSqlStr,(SDWORD)999,(SDWORD FAR *)&pcbSqlStr),
        "SQLNativeSql",henv,hdbc,SQL_NULL_HSTMT);
    *SqlStr=MEM_SaveStringGStack(szSqlStr);
    return;
}
// NumParams
void odbcNumParams(HENV henv,HDBC hdbc,HSTMT hstmt,INTEGER FAR *NumPar)
{
    SWORD pcpar;
    odbc_check_loading("odbcNumParams");
    odbcMyError(
        (RETCODE)SQLNumParams((HSTMT)hstmt,(SWORD FAR *)&pcpar),
        "SQLNumParams",henv,hdbc,hstmt);
    *NumPar=pcpar;
    return;
}
// NumResultCols
void odbcNumResultCols(HENV henv,HDBC hdbc,HSTMT hstmt,INTEGER FAR *NumCol)
{
    SWORD pccol;
    odbc_check_loading("odbcNumResultCols");
    odbcMyError(
        (RETCODE)SQLNumResultCols((HSTMT)hstmt,(SWORD FAR *)&pccol),
        "SQLNumResultCols",henv,hdbc,hstmt);
    *NumCol=pccol;
    return;
}
// ParamData
void odbcParamData(HENV henv,HDBC hdbc,HSTMT hstmt,HAM FAR *pHam)
{
    PTR prgbValue=0;
    ODBC_SAVE_DATA  *colSData;
    int i;

    odbc_check_loading("odbcParamData");
    odbcMyError(
        (RETCODE)SQLParamData((HSTMT)hstmt,(PTR FAR *)prgbValue),
        "SQLParamData",henv,hdbc,hstmt);
    for(i=0;i<100;i++)
        if(pnt_ham[i])
        {
            colSData=pnt_ham[i];
            if(DATASP==prgbValue)
            {
                *pHam=(HAM)pnt_ham[i];
                break;
            }
        }
    return;
}
// ParamOptions
void odbcParamOptions(HENV henv,HDBC hdbc,HSTMT hstmt,UDWORD crow,UDWORD pirow)
{
    odbc_check_loading("odbcParamOptions");
    odbcMyError(
        (RETCODE)SQLParamOptions((HSTMT)hstmt,(UDWORD)crow,(UDWORD FAR *)&pirow),
        "SQLParamOptions",henv,hdbc,hstmt);
    return;
}
// Prepare
void odbcPrepare(HENV henv,HDBC hdbc,HSTMT hstmt,STRING szSqlStr)
{
    odbc_check_loading("odbcPrepare");
    odbcMyError(
        (RETCODE)SQLPrepare((HSTMT)hstmt,(UCHAR FAR *)szSqlStr,(SDWORD)odbc_len_str(szSqlStr)),
    "SQLPrepare",henv,hdbc,hstmt);
    return;
}
// PrimaryKeys
void odbcPrimaryKeys(HENV henv,HDBC hdbc,HSTMT hstmt,STRING TableQualifier,
    STRING TableOwner,STRING TableName)
{
    STRING szTableQualifier;
    SWORD cbTableQualifier;
    STRING szTableOwner;
    SWORD cbTableOwner;
    STRING szTableName;
    SWORD cbTableName;
    odbc_check_loading("odbcPrimaryKeys");
    if(odbc_cmp_str(TableQualifier,"NULL_STRING"))
    {
        szTableQualifier=0;
        cbTableQualifier=0;
    }
    else
    {
        szTableQualifier=TableQualifier;
        cbTableQualifier=odbc_len_str(szTableQualifier);
    }
    if(odbc_cmp_str(TableOwner,"NULL_STRING"))
    {
        szTableOwner=0;
        cbTableOwner=0;
    }
    else
    {
        szTableOwner=TableOwner;
        cbTableOwner=odbc_len_str(szTableOwner);
    }
    if(odbc_cmp_str(TableName,"NULL_STRING"))
    {
        szTableName=0;
        cbTableName=0;
    }
    else
    {
        szTableName=TableName;
        cbTableName=odbc_len_str(szTableName);
    }
    odbcMyError(
        (RETCODE)SQLPrimaryKeys((HSTMT)hstmt,(UCHAR FAR *)szTableQualifier,(SWORD)cbTableQualifier,
            (UCHAR FAR *)szTableOwner,(SWORD)cbTableOwner,(UCHAR FAR *)szTableName,(SWORD)cbTableName),
        "SQLPrimaryKeys",henv,hdbc,hstmt);
    return;
}
// ProcedureColumns
void odbcProcedureColumns(HENV henv,HDBC hdbc,HSTMT hstmt,STRING ProcQualifier,
    STRING ProcOwner,STRING ProcName,STRING ColumnName)
{
    STRING szProcQualifier;
    SWORD cbProcQualifier;
    STRING szProcOwner;
    SWORD cbProcOwner;
    STRING szProcName;
    SWORD cbProcName;
    STRING szColumnName;
    SWORD cbColumnName;
    odbc_check_loading("odbcProcedureColumns");
    if(odbc_cmp_str(ProcQualifier,"NULL_STRING"))
    {
        szProcQualifier=0;
        cbProcQualifier=0;
    }
    else
    {
        szProcQualifier=ProcQualifier;
        cbProcQualifier=odbc_len_str(szProcQualifier);
    }
    if(odbc_cmp_str(ProcOwner,"NULL_STRING"))
    {
        szProcOwner=0;
        cbProcOwner=0;
    }
    else
    {
        szProcOwner=ProcOwner;
        cbProcOwner=odbc_len_str(szProcOwner);
    }
    if(odbc_cmp_str(ProcName,"NULL_STRING"))
    {
        szProcName=0;
        cbProcName=0;
    }
    else
    {
        szProcName=ProcName;
        cbProcName=odbc_len_str(szProcName);
    }
    if(odbc_cmp_str(ColumnName,"NULL_STRING"))
    {
        szColumnName=0;
        cbColumnName=0;
    }
    else
    {
        szColumnName=ColumnName;
        cbColumnName=odbc_len_str(szColumnName);
    }
    odbcMyError(
        (RETCODE)SQLProcedureColumns((HSTMT)hstmt,(UCHAR FAR *)szProcQualifier,(SWORD)cbProcQualifier,
            (UCHAR FAR *)szProcOwner,(SWORD)cbProcOwner,(UCHAR FAR *)szProcName,(SWORD)cbProcName,
            (UCHAR FAR *)szColumnName,(SWORD)cbColumnName),
        "SQLProcedureColumns",henv,hdbc,hstmt);
    return;
}
// Procedures
void odbcProcedures(HENV henv,HDBC hdbc,HSTMT hstmt,STRING ProcQualifier,
    STRING ProcOwner,STRING ProcName)
{
    STRING szProcQualifier;
    SWORD cbProcQualifier;
    STRING szProcOwner;
    SWORD cbProcOwner;
    STRING szProcName;
    SWORD cbProcName;
    odbc_check_loading("odbcProcedures");
    if(odbc_cmp_str(ProcQualifier,"NULL_STRING"))
    {
        szProcQualifier=0;
        cbProcQualifier=0;
    }
    else
    {
        szProcQualifier=ProcQualifier;
        cbProcQualifier=odbc_len_str(szProcQualifier);
    }
    if(odbc_cmp_str(ProcOwner,"NULL_STRING"))
    {
        szProcOwner=0;
        cbProcOwner=0;
    }
    else
    {
        szProcOwner=ProcOwner;
        cbProcOwner=odbc_len_str(szProcOwner);
    }
    if(odbc_cmp_str(ProcName,"NULL_STRING"))
    {
        szProcName=0;
        cbProcName=0;
    }
    else
    {
        szProcName=ProcName;
        cbProcName=odbc_len_str(szProcName);
    }
    odbcMyError(
        (RETCODE)SQLProcedures((HSTMT)hstmt,(UCHAR FAR *)szProcQualifier,(SWORD)cbProcQualifier,
            (UCHAR FAR *)szProcOwner,(SWORD)cbProcOwner,(UCHAR FAR *)szProcName,(SWORD)cbProcName),
        "SQLProcedures",henv,hdbc,hstmt);
    return;
}
// SetConnectOption
void odbcSetConnectOption(HENV henv,HDBC hdbc,UNSIGNED Option,ODBC_CO_DATA *Param)
{
    UWORD fOption;
    UDWORD vParam;
    odbc_check_loading("odbcSetConnectOption");
    switch(Option)
    {
        case(ODBC_ACCESS_MODE)    : fOption=SQL_ACCESS_MODE;
            switch(DATACOL)
            {
                case(ODBC_MODE_READ_ONLY)         : vParam=SQL_MODE_READ_ONLY;     break;
                case(ODBC_MODE_READ_WRITE)        : vParam=SQL_MODE_READ_WRITE;    break;
                default:
                 GlobErr=ODBC_UNKNOWN_PARAM_DATA;
                 odbcMyError(ODBC_ERROR,"odbcSetConnectOption",SQL_NULL_HENV,SQL_NULL_HDBC,SQL_NULL_HSTMT);
                 break;
            }
            break;
        case(ODBC_AUTOCOMMIT)     : fOption=SQL_AUTOCOMMIT;
            switch(DATACOL)
            {
                case(ODBC_AUTOCOMMIT_OFF)      : vParam=SQL_AUTOCOMMIT_OFF;     break;
                case(ODBC_AUTOCOMMIT_ON)       : vParam=SQL_AUTOCOMMIT_ON;      break;
                default:
                 GlobErr=ODBC_UNKNOWN_PARAM_DATA;
                 odbcMyError(ODBC_ERROR,"odbcSetConnectOption",SQL_NULL_HENV,SQL_NULL_HDBC,SQL_NULL_HSTMT);
                 break;
            }
            break;
        case(ODBC_CURRENT_QUALIFIER) : fOption=SQL_CURRENT_QUALIFIER;
            vParam=(UDWORD)DATACOS;
            break;
        case(ODBC_LOGIN_TIMEOUT)        : fOption=SQL_LOGIN_TIMEOUT;
            vParam=DATACOL;
            break;
        case(ODBC_ODBC_CURSORS)      : fOption=SQL_ODBC_CURSORS;
            switch(DATACOL)
            {
                case(ODBC_CUR_USE_IF_NEEDED)   : vParam=SQL_CUR_USE_IF_NEEDED;  break;
                case(ODBC_CUR_USE_ODBC)        : vParam=SQL_CUR_USE_ODBC;       break;
                case(ODBC_CUR_USE_DRIVER)      : vParam=SQL_CUR_USE_DRIVER;     break;
                default:
                 GlobErr=ODBC_UNKNOWN_PARAM_DATA;
                 odbcMyError(ODBC_ERROR,"odbcSetConnectOption",SQL_NULL_HENV,SQL_NULL_HDBC,SQL_NULL_HSTMT);
                 break;
            }
            break;
        case(ODBC_OPT_TRACE)      : fOption=SQL_OPT_TRACE;
            switch(DATACOL)
            {
                case(ODBC_OPT_TRACE_OFF)       : vParam=SQL_OPT_TRACE_OFF;   break;
                case(ODBC_OPT_TRACE_ON)        : vParam=SQL_OPT_TRACE_ON;    break;
                default:
                 GlobErr=ODBC_UNKNOWN_PARAM_DATA;
                 odbcMyError(ODBC_ERROR,"odbcSetConnectOption",SQL_NULL_HENV,SQL_NULL_HDBC,SQL_NULL_HSTMT);
                 break;
            }
            break;
        case(ODBC_OPT_TRACEFILE)        : fOption=SQL_OPT_TRACEFILE;
            vParam=(UDWORD)DATACOS;
            break;
        case(ODBC_PACKET_SIZE)    : fOption=SQL_PACKET_SIZE;
            vParam=DATACOL;
            break;
        case(ODBC_QUIET_MODE)     : fOption=SQL_QUIET_MODE;
            vParam=DATACOL;
            break;
        case(ODBC_TRANSLATE_DLL)  : fOption=SQL_TRANSLATE_DLL;
            vParam=(UDWORD)DATACOS;
            break;
        case(ODBC_TRANSLATE_OPTION)  : fOption=SQL_TRANSLATE_OPTION;
            vParam=DATACOL;
            break;
        case(ODBC_TXN_ISOLATION)  : fOption=SQL_TXN_ISOLATION;
            switch(DATACOL)
            {
                case(ODBC_TXN_READ_UNCOMMITTED): vParam=SQL_TXN_READ_UNCOMMITTED;  break;
                case(ODBC_TXN_READ_COMMITTED)  : vParam=SQL_TXN_READ_COMMITTED;    break;
                case(ODBC_TXN_REPEATABLE_READ) : vParam=SQL_TXN_REPEATABLE_READ;   break;
                case(ODBC_TXN_SERIALIZABLE)    : vParam=SQL_TXN_SERIALIZABLE;      break;
//                case(ODBC_TXN_VERSIONING)      : vParam=SQL_TXN_VERSIONING;        break;
                default:
                 GlobErr=ODBC_UNKNOWN_PARAM_DATA;
                 odbcMyError(ODBC_ERROR,"odbcSetConnectOption",SQL_NULL_HENV,SQL_NULL_HDBC,SQL_NULL_HSTMT);
                 break;
            }
            break;
        default:
            GlobErr=ODBC_UNKNOWN_OPTION;
            odbcMyError(ODBC_ERROR,"odbcSetConnectOption",SQL_NULL_HENV,SQL_NULL_HDBC,SQL_NULL_HSTMT);
            break;
    }
    odbcMyError(
        (RETCODE)SQLSetConnectOption((HDBC)hdbc,(UWORD)fOption,(UDWORD)vParam),
        "SQLSetConnectOption",henv,hdbc,SQL_NULL_HSTMT);
    return;
}
// PutData
void odbcPutData(HENV henv,HDBC hdbc,HSTMT hstmt,HAM Ham)
{
    ODBC_SAVE_DATA  *colSData;

    odbc_check_loading("odbcPutData");
    colSData=(ODBC_SAVE_DATA *)Ham;
    odbcMyError(
        (RETCODE)SQLPutData((HSTMT)hstmt,(PTR)DATASP,(SDWORD)DATASS),
        "SQLPutData",henv,hdbc,hstmt);
    return;
}
// RowCount
void odbcRowCount(HENV henv,HDBC hdbc,HSTMT hstmt,long FAR *NumRow)
{
    SDWORD pcrow;
    odbc_check_loading("odbcRowCount");
    odbcMyError(
        (RETCODE)SQLRowCount((HSTMT)hstmt,(SDWORD FAR *)&pcrow),
        "SQLRowCount",henv,hdbc,hstmt);
    odbc_mem_copy(&pcrow,NumRow,sizeof(long));
    return;
}
// SetCursorName
void odbcSetCursorName(HENV henv,HDBC hdbc,HSTMT hstmt,STRING Cursor)
{
    odbc_check_loading("odbcSetCursorName");
    odbcMyError(
        (RETCODE)SQLSetCursorName((HSTMT)hstmt,(UCHAR FAR *)Cursor,(SWORD)odbc_len_str(Cursor)),
        "SQLSetCursorName",henv,hdbc,hstmt);
    return;
}
// SetParam
void odbcSetParam(HENV henv,HDBC hdbc,HSTMT hstmt,UNSIGNED ipar,
	 UNSIGNED dataType,UDWORD Precision,INTEGER Scale,UNSIGNED BufferLen,HAM FAR *pHam)
{
    SWORD     fCType;
    SWORD     fSqlType;
    PTR       rgbValue;
    SDWORD    pcbValue;
    odbc_check_loading("odbcSetParam");
    switch(dataType)
    {
        case(ODBC_STRING)   : fCType=SQL_C_CHAR;       fSqlType=SQL_CHAR;      break;
        case(ODBC_BIT)      : fCType=SQL_C_BIT;        fSqlType=SQL_BIT;       break;
        case(ODBC_BYTE)     : fCType=SQL_C_UTINYINT;   fSqlType=SQL_TINYINT;   break;
        case(ODBC_INTEGER)  : fCType=SQL_C_INTEGER_X;     fSqlType=SQL_INTEGER_X; break;
        case(ODBC_LONG)     : fCType=SQL_C_LONG;    fSqlType=SQL_INTEGER;   break;
        case(ODBC_FLOAT)    : fCType=SQL_C_FLOAT;      fSqlType=SQL_REAL;      break;
        case(ODBC_REAL)     : fCType=SQL_C_DOUBLE;     fSqlType=SQL_DOUBLE;    break;
        case(ODBC_DATE)     : fCType=SQL_C_DATE;       fSqlType=SQL_DATE;      break;
        case(ODBC_TIME)     : fCType=SQL_C_TIME;       fSqlType=SQL_TIME;      break;
        case(ODBC_TIMESTAMP): fCType=SQL_C_TIMESTAMP;  fSqlType=SQL_TIMESTAMP; break;
        case(ODBC_BINARY)   : fCType=SQL_C_BINARY;     fSqlType=SQL_LONGVARBINARY;    break;
        case(ODBC_NUMERIC)  : fCType=SQL_C_CHAR;       fSqlType=SQL_NUMERIC;   break;
        case(ODBC_MEMO)     : fCType=SQL_C_CHAR;       fSqlType=SQL_LONGVARCHAR; break;
        default:
            GlobErr=ODBC_UNKNOWN_DATA_TYPE;
            odbcMyError(ODBC_ERROR,"odbcSetParam",SQL_NULL_HENV,SQL_NULL_HDBC,SQL_NULL_HSTMT);
            break;
    }
    rgbValue=odbc_alloc_ham(dataType,BufferLen,pHam);
    odbcMyError(
        (RETCODE)SQLSetParam((HSTMT)hstmt,(UWORD)ipar,(SWORD)fCType,(SWORD)fSqlType,(UDWORD)Precision,
            (SWORD)Scale,(PTR)rgbValue,(SDWORD FAR *)&pcbValue),
        "SQLSetParam",henv,hdbc,hstmt);
    return;
}
// SetPos
void odbcSetPos(HENV henv,HDBC hdbc,HSTMT hstmt,UNSIGNED irow,UNSIGNED Option,UNSIGNED Lock)
{
    UWORD fOption;
    UWORD fLock;
    odbc_check_loading("odbcSetPos");
    switch(Option)
    {
        case(ODBC_POSITION) : fOption=SQL_POSITION;    break;
        case(ODBC_REFRESH)  : fOption=SQL_REFRESH;     break;
        case(ODBC_UPDATE)   : fOption=SQL_UPDATE;      break;
        case(ODBC_DELETE)   : fOption=SQL_DELETE;      break;
        case(ODBC_ADD)      : fOption=SQL_ADD;         break;
        default:
            GlobErr=ODBC_UNKNOWN_OPTION;
            odbcMyError(ODBC_ERROR,"odbcSetPos",SQL_NULL_HENV,SQL_NULL_HDBC,SQL_NULL_HSTMT);
            break;
    }
    switch(Lock)
    {
        case(ODBC_LOCK_NO_CHANGE) : fLock=SQL_LOCK_NO_CHANGE;   break;
        case(ODBC_LOCK_EXCLUSIVE) : fLock=SQL_LOCK_EXCLUSIVE;   break;
        case(ODBC_LOCK_UNLOCK)    : fLock=SQL_LOCK_UNLOCK;      break;
        default:
            GlobErr=ODBC_UNKNOWN_LOCK;
            odbcMyError(ODBC_ERROR,"odbcSetPos",SQL_NULL_HENV,SQL_NULL_HDBC,SQL_NULL_HSTMT);
            break;
    }
    odbcMyError(
        (RETCODE)SQLSetPos((HSTMT)hstmt,(UWORD)irow,(UWORD)fOption,(UWORD)fLock),
        "SQLSetPos",henv,hdbc,hstmt);
    return;
}

// SetScrollOptions
void odbcSetScrollOptions(HENV henv,HDBC hdbc,HSTMT hstmt,UNSIGNED Concurrency,
    SDWORD crowKeyset,UNSIGNED crowRowset)
{
    UWORD fConcurrency;
    SDWORD fcrowKeyset;
    odbc_check_loading("odbcSetScrollOptions");
    switch(Concurrency)
    {
        case(ODBC_CONCUR_READ_ONLY)  : fConcurrency=SQL_CONCUR_READ_ONLY;   break;
        case(ODBC_CONCUR_LOCK)       : fConcurrency=SQL_CONCUR_LOCK;        break;
        case(ODBC_CONCUR_ROWVER)     : fConcurrency=SQL_CONCUR_ROWVER;      break;
        case(ODBC_CONCUR_VALUES)     : fConcurrency=SQL_CONCUR_VALUES;      break;
        default:
            GlobErr=ODBC_UNKNOWN_CONCURRENCY;
            odbcMyError(ODBC_ERROR,"odbcSetScrollOptions",SQL_NULL_HENV,SQL_NULL_HDBC,SQL_NULL_HSTMT);
            break;
    }
    switch(crowKeyset)
    {
        case(ODBC_SCROLL_FORWARD_ONLY)  : fcrowKeyset=SQL_SCROLL_FORWARD_ONLY; break;
        case(ODBC_SCROLL_STATIC)        : fcrowKeyset=SQL_SCROLL_STATIC;       break;
        case(ODBC_SCROLL_KEYSET_DRIVEN) : fcrowKeyset=SQL_SCROLL_KEYSET_DRIVEN;break;
        case(ODBC_SCROLL_DYNAMIC)       : fcrowKeyset=SQL_SCROLL_DYNAMIC;      break;
        default                         : fcrowKeyset=crowKeyset;              break;
    }
    odbcMyError(
        (RETCODE)SQLSetScrollOptions((HSTMT)hstmt,(UWORD)fConcurrency,(SDWORD)fcrowKeyset,(UWORD)crowRowset),
        "SQLSetScrollOptions",henv,hdbc,hstmt);
    return;
}
// SetStmtOption
void odbcSetStmtOption(HENV henv,HDBC hdbc,HSTMT hstmt,UNSIGNED Option,UDWORD Param)
{
    UWORD fOption;
    UDWORD vParam;
    odbc_check_loading("odbcSetStmtOption");
    switch(Option)
    {
        case(ODBC_ASYNC_ENABLE)        : fOption=SQL_ASYNC_ENABLE;
            switch(Param)
            {
                case(ODBC_ASYNC_ENABLE_OFF) : vParam=SQL_ASYNC_ENABLE_OFF;   break;
                case(ODBC_ASYNC_ENABLE_ON)  : vParam=SQL_ASYNC_ENABLE_ON;    break;
                default:
                 GlobErr=ODBC_UNKNOWN_PARAM_DATA;
                 odbcMyError(ODBC_ERROR,"odbcSetStmtOption",SQL_NULL_HENV,SQL_NULL_HDBC,SQL_NULL_HSTMT);
                 break;
            }
            break;
        case(ODBC_BIND_TYPE)        : fOption=SQL_BIND_TYPE;
            switch(Param)
            {
                case(ODBC_BIND_BY_COLUMN)   : vParam=SQL_BIND_BY_COLUMN;     break;
                default:
                 GlobErr=ODBC_UNKNOWN_PARAM_DATA;
                 odbcMyError(ODBC_ERROR,"odbcSetStmtOption",SQL_NULL_HENV,SQL_NULL_HDBC,SQL_NULL_HSTMT);
                 break;
            }
            break;
        case(ODBC_CONCURRENCY)      : fOption=SQL_CONCURRENCY;
            switch(Param)
            {
                case(ODBC_CONCUR_READ_ONLY) : vParam=SQL_CONCUR_READ_ONLY;   break;
                case(ODBC_CONCUR_LOCK)      : vParam=SQL_CONCUR_LOCK;        break;
                case(ODBC_CONCUR_ROWVER)    : vParam=SQL_CONCUR_ROWVER;      break;
                case(ODBC_CONCUR_VALUES)    : vParam=SQL_CONCUR_VALUES;      break;
                default:
                 GlobErr=ODBC_UNKNOWN_PARAM_DATA;
                 odbcMyError(ODBC_ERROR,"odbcSetStmtOption",SQL_NULL_HENV,SQL_NULL_HDBC,SQL_NULL_HSTMT);
                 break;
            }
            break;
        case(ODBC_CURSOR_TYPE)      : fOption=SQL_CURSOR_TYPE;
            switch(Param)
            {
                case(ODBC_CURSOR_FORWARD_ONLY) : vParam=SQL_CURSOR_FORWARD_ONLY;   break;
                case(ODBC_CURSOR_STATIC)       : vParam=SQL_CURSOR_STATIC;         break;
                case(ODBC_CURSOR_KEYSET_DRIVEN): vParam=SQL_CURSOR_KEYSET_DRIVEN;  break;
                case(ODBC_CURSOR_DYNAMIC)      : vParam=SQL_CURSOR_DYNAMIC;        break;
                default:
                 GlobErr=ODBC_UNKNOWN_PARAM_DATA;
                 odbcMyError(ODBC_ERROR,"odbcSetStmtOption",SQL_NULL_HENV,SQL_NULL_HDBC,SQL_NULL_HSTMT);
                 break;
            }
            break;
        case(ODBC_KEYSET_SIZE)      : fOption=SQL_KEYSET_SIZE;
            vParam=Param;
            break;
        case(ODBC_MAX_LENGTH)       : fOption=SQL_MAX_LENGTH;
            vParam=Param;
            break;
        case(ODBC_MAX_ROWS)      : fOption=SQL_MAX_ROWS;
            vParam=Param;
            break;
        case(ODBC_NOSCAN)        : fOption=SQL_NOSCAN;
            switch(Param)
            {
                case(ODBC_NOSCAN_OFF)    : vParam=SQL_NOSCAN_OFF;      break;
                case(ODBC_NOSCAN_ON)     : vParam=SQL_NOSCAN_ON;       break;
                default:
                 GlobErr=ODBC_UNKNOWN_PARAM_DATA;
                 odbcMyError(ODBC_ERROR,"odbcSetStmtOption",SQL_NULL_HENV,SQL_NULL_HDBC,SQL_NULL_HSTMT);
                 break;
            }
            break;
        case(ODBC_QUERY_TIMEOUT)    : fOption=SQL_QUERY_TIMEOUT;
            vParam=Param;
            break;
        case(ODBC_RETRIEVE_DATA)    : fOption=SQL_RETRIEVE_DATA;
            switch(Param)
            {
                case(ODBC_RD_ON)      : vParam=SQL_RD_ON;        break;
                case(ODBC_RD_OFF)     : vParam=SQL_RD_OFF;       break;
                default:
                 GlobErr=ODBC_UNKNOWN_PARAM_DATA;
                 odbcMyError(ODBC_ERROR,"odbcSetStmtOption",SQL_NULL_HENV,SQL_NULL_HDBC,SQL_NULL_HSTMT);
                 break;
            }
            break;
        case(ODBC_ROWSET_SIZE)      : fOption=SQL_ROWSET_SIZE;
            vParam=Param;
            break;
        case(ODBC_SIMULATE_CURSOR)     : fOption=SQL_SIMULATE_CURSOR;
            switch(Param)
            {
                case(ODBC_SC_NON_UNIQUE) : vParam=SQL_SC_NON_UNIQUE;      break;
                case(ODBC_SC_TRY_UNIQUE) : vParam=SQL_SC_TRY_UNIQUE;      break;
                case(ODBC_SC_UNIQUE)     : vParam=SQL_SC_UNIQUE;          break;
                default:
                 GlobErr=ODBC_UNKNOWN_PARAM_DATA;
                 odbcMyError(ODBC_ERROR,"odbcSetStmtOption",SQL_NULL_HENV,SQL_NULL_HDBC,SQL_NULL_HSTMT);
                 break;
            }
            break;
        case(ODBC_USE_BOOKMARKS)    : fOption=SQL_USE_BOOKMARKS;
            switch(Param)
            {
                case(ODBC_UB_OFF)     : vParam=SQL_UB_OFF;       break;
                case(ODBC_UB_ON)      : vParam=SQL_UB_ON;        break;
                default:
                 GlobErr=ODBC_UNKNOWN_PARAM_DATA;
                 odbcMyError(ODBC_ERROR,"odbcSetStmtOption",SQL_NULL_HENV,SQL_NULL_HDBC,SQL_NULL_HSTMT);
                 break;
            }
            break;
        default:
            GlobErr=ODBC_UNKNOWN_OPTION;
            odbcMyError(ODBC_ERROR,"odbcSetStmtOption",SQL_NULL_HENV,SQL_NULL_HDBC,SQL_NULL_HSTMT);
            break;
    }
    odbcMyError((RETCODE)SQLSetStmtOption((HSTMT)hstmt,(UWORD)fOption,(UDWORD)vParam),"SQLSetStmtOption",henv,hdbc,hstmt);
    return;
}
// SpecialColumns
void odbcSpecialColumns(HENV henv,HDBC hdbc,HSTMT hstmt,UNSIGNED ColType,
    STRING TableQualifier,STRING TableOwner,STRING TableName,UNSIGNED Scope,
    UNSIGNED Nullable)
{
    UWORD  fColType;
    STRING szTableQualifier;
    SWORD  cbTableQualifier;
    STRING szTableOwner;
    SWORD  cbTableOwner;
    STRING szTableName;
    SWORD  cbTableName;
    UWORD  fScope;
    UWORD  fNullable;
    odbc_check_loading("odbcSpecialColumns");
    switch(ColType)
    {
        case(ODBC_BEST_ROWID)  : fColType=SQL_BEST_ROWID; break;
        case(ODBC_ROWVER)      : fColType=SQL_ROWVER;     break;
        default:
            GlobErr=ODBC_UNKNOWN_COLUMN_TYPE;
            odbcMyError(ODBC_ERROR,"odbcSpecialColumns",SQL_NULL_HENV,SQL_NULL_HDBC,SQL_NULL_HSTMT);
            break;
    }
    if(odbc_cmp_str(TableQualifier,"NULL_STRING"))
    {
        szTableQualifier=0;
        cbTableQualifier=0;
    }
    else
    {
        szTableQualifier=TableQualifier;
        cbTableQualifier=odbc_len_str(szTableQualifier);
    }
    if(odbc_cmp_str(TableOwner,"NULL_STRING"))
    {
        szTableOwner=0;
        cbTableOwner=0;
    }
    else
    {
        szTableOwner=TableOwner;
        cbTableOwner=odbc_len_str(szTableOwner);
    }
    if(odbc_cmp_str(TableName,"NULL_STRING"))
    {
        szTableName=0;
        cbTableName=0;
    }
    else
    {
        szTableName=TableName;
        cbTableName=odbc_len_str(szTableName);
    }
    switch(Scope)
    {
        case(ODBC_SCOPE_CURROW)      : fScope=SQL_SCOPE_CURROW;       break;
        case(ODBC_SCOPE_TRANSACTION) : fScope=SQL_SCOPE_TRANSACTION;  break;
        case(ODBC_SCOPE_SESSION)     : fScope=SQL_SCOPE_SESSION;      break;
        default:
            GlobErr=ODBC_UNKNOWN_SCOPE;
            odbcMyError(ODBC_ERROR,"odbcSpecialColumns",SQL_NULL_HENV,SQL_NULL_HDBC,SQL_NULL_HSTMT);
            break;
    }
    switch(Nullable)
    {
        case(ODBC_NO_NULLS)    : fNullable=SQL_NO_NULLS;  break;
        case(ODBC_NULLABLE)    : fNullable=SQL_NULLABLE;  break;
        default:
            GlobErr=ODBC_UNKNOWN_NULLABLE;
            odbcMyError(ODBC_ERROR,"odbcSpecialColumns",SQL_NULL_HENV,SQL_NULL_HDBC,SQL_NULL_HSTMT);
            break;
    }
    odbcMyError((RETCODE)SQLSpecialColumns((HSTMT)hstmt,(UWORD)fColType,(UCHAR FAR *)szTableQualifier,
    (SWORD)cbTableQualifier,(UCHAR FAR *)szTableOwner,(SWORD)cbTableOwner,(UCHAR FAR *)szTableName,
    (SWORD)cbTableName,(UWORD)fScope,(UWORD)fNullable),
    "SQLSpecialColumns",henv,hdbc,hstmt);
    return;
}
// Statistics
void odbcStatistics(HENV henv,HDBC hdbc,HSTMT hstmt,STRING TableQualifier,
    STRING TableOwner,STRING TableName,UNSIGNED Unique,UNSIGNED Accuracy)
{
    STRING szTableQualifier;
    SWORD  cbTableQualifier;
    STRING szTableOwner;
    SWORD  cbTableOwner;
    STRING szTableName;
    SWORD  cbTableName;
    UWORD  fUnique;
    UWORD  fAccuracy;
    odbc_check_loading("odbcStatistics");
    if(odbc_cmp_str(TableQualifier,"NULL_STRING"))
    {
        szTableQualifier=0;
        cbTableQualifier=0;
    }
    else
    {
        szTableQualifier=TableQualifier;
        cbTableQualifier=odbc_len_str(szTableQualifier);
    }
    if(odbc_cmp_str(TableOwner,"NULL_STRING"))
    {
        szTableOwner=0;
        cbTableOwner=0;
    }
    else
    {
        szTableOwner=TableOwner;
        cbTableOwner=odbc_len_str(szTableOwner);
    }
    if(odbc_cmp_str(TableName,"NULL_STRING"))
    {
        szTableName=0;
        cbTableName=0;
    }
    else
    {
        szTableName=TableName;
        cbTableName=odbc_len_str(szTableName);
    }
    switch(Unique)
    {
        case(ODBC_INDEX_UNIQUE)   : fUnique=SQL_INDEX_UNIQUE;   break;
        case(ODBC_INDEX_ALL)      : fUnique=SQL_INDEX_ALL;      break;
        default:
            GlobErr=ODBC_UNKNOWN_UNIQUE;
            odbcMyError(ODBC_ERROR,"odbcStatistics",SQL_NULL_HENV,SQL_NULL_HDBC,SQL_NULL_HSTMT);
            break;
    }
    switch(Accuracy)
    {
        case(ODBC_ENSURE)   : fAccuracy=SQL_ENSURE; break;
        case(ODBC_QUICK)    : fAccuracy=SQL_QUICK;  break;
        default:
            GlobErr=ODBC_UNKNOWN_ACCURACY;
            odbcMyError(ODBC_ERROR,"odbcStatistics",SQL_NULL_HENV,SQL_NULL_HDBC,SQL_NULL_HSTMT);
            break;
    }
    odbcMyError(
        (RETCODE)SQLStatistics((HSTMT)hstmt,(UCHAR FAR *)szTableQualifier,(SWORD)cbTableQualifier,
            (UCHAR FAR *)szTableOwner,(SWORD)cbTableOwner,(UCHAR FAR *)szTableName,(SWORD)cbTableName,
            (UWORD)fUnique,(UWORD)fAccuracy),
        "SQLStatistics",henv,hdbc,hstmt);
    return;
}
// TablePrivileges
void odbcTablePrivileges(HENV henv,HDBC hdbc,HSTMT hstmt,STRING TableQualifier,
    STRING TableOwner,STRING TableName)
{
    STRING szTableQualifier;
    SWORD cbTableQualifier;
    STRING szTableOwner;
    SWORD cbTableOwner;
    STRING szTableName;
    SWORD cbTableName;
    odbc_check_loading("odbcTablePrivileges");
    if(odbc_cmp_str(TableQualifier,"NULL_STRING"))
    {
        szTableQualifier=0;
        cbTableQualifier=0;
    }
    else
    {
        szTableQualifier=TableQualifier;
        cbTableQualifier=odbc_len_str(szTableQualifier);
    }
    if(odbc_cmp_str(TableOwner,"NULL_STRING"))
    {
        szTableOwner=0;
        cbTableOwner=0;
    }
    else
    {
        szTableOwner=TableOwner;
        cbTableOwner=odbc_len_str(szTableOwner);
    }
    if(odbc_cmp_str(TableName,"NULL_STRING"))
    {
        szTableName=0;
        cbTableName=0;
    }
    else
    {
        szTableName=TableName;
        cbTableName=odbc_len_str(szTableName);
    }
    odbcMyError(
        (RETCODE)SQLTablePrivileges((HSTMT)hstmt,(UCHAR FAR *)szTableQualifier,(SWORD)cbTableQualifier,
        (UCHAR FAR *)szTableOwner,(SWORD)cbTableOwner,(UCHAR FAR *)szTableName,(SWORD)cbTableName),
    "SQLTablePrivileges",henv,hdbc,hstmt);
    return;
}
// Tables
void odbcTables(HENV henv,HDBC hdbc,HSTMT hstmt,STRING TableQualifier,
    STRING TableOwner,STRING TableName,STRING TableType)
{
    STRING szTableQualifier;
    SWORD cbTableQualifier;
    STRING szTableOwner;
    SWORD cbTableOwner;
    STRING szTableName;
    SWORD cbTableName;
    STRING szTableType;
    SWORD cbTableType;
    odbc_check_loading("odbcTables");
    if(odbc_cmp_str(TableQualifier,"NULL_STRING"))
    {
        szTableQualifier=0;
        cbTableQualifier=0;
    }
    else
    {
        szTableQualifier=TableQualifier;
        cbTableQualifier=odbc_len_str(szTableQualifier);
    }
    if(odbc_cmp_str(TableOwner,"NULL_STRING"))
    {
        szTableOwner=0;
        cbTableOwner=0;
    }
    else
    {
        szTableOwner=TableOwner;
        cbTableOwner=odbc_len_str(szTableOwner);
    }
    if(odbc_cmp_str(TableName,"NULL_STRING"))
    {
        szTableName=0;
        cbTableName=0;
    }
    else
    {
        szTableName=TableName;
        cbTableName=odbc_len_str(szTableName);
    }
    if(odbc_cmp_str(TableType,"NULL_STRING"))
    {
        szTableType=0;
        cbTableType=0;
    }
    else
    {
        szTableType=TableType;
        cbTableType=odbc_len_str(szTableType);
    }
    odbcMyError(
        (RETCODE)SQLTables((HSTMT)hstmt,(UCHAR FAR *)szTableQualifier,(SWORD)cbTableQualifier,
            (UCHAR FAR *)szTableOwner,(SWORD)cbTableOwner,(UCHAR FAR *)szTableName,(SWORD)cbTableName,
            (UCHAR FAR *)szTableType,(SWORD)cbTableType),
    "SQLTables",henv,hdbc,hstmt);
    return;
}
// Transact
void odbcTransact(HENV henv,HDBC hdbc,UNSIGNED Type)
{
    UWORD fType;
    odbc_check_loading("odbcTransact");
    switch(Type)
    {
        case(ODBC_COMMIT)   : fType=SQL_COMMIT;     break;
        case(ODBC_ROLLBACK) : fType=SQL_ROLLBACK;   break;
        default:
            GlobErr=ODBC_UNKNOWN_TRANSACT_TYPE;
            odbcMyError(ODBC_ERROR,"odbcTransact",SQL_NULL_HENV,SQL_NULL_HDBC,SQL_NULL_HSTMT);
            break;
    }
    odbcMyError(
		  (RETCODE)SQLTransact((HENV)henv,(HDBC)hdbc,(UWORD)fType),
    "SQLTransact",henv,hdbc,SQL_NULL_HSTMT);
    return;
}
// ReleaseHam
void odbcReleaseHam(HAM Ham)
{
    ODBC_SAVE_DATA  *colSData;
    int i;

    odbc_check_loading("odbcReleaseHam");
    colSData=(ODBC_SAVE_DATA FAR *)Ham;
    for(i=0;i<100;i++)
        if(pnt_ham[i]==colSData)
        {
            pnt_ham[i]=0;
            break;
        }
    if(i==100)
    {
        GlobErr=ODBC_UNKNOWN_HAM;
        odbcMyError(ODBC_ERROR,"odbcReleaseHam",SQL_NULL_HENV,SQL_NULL_HDBC,SQL_NULL_HSTMT);
        return;
    }
    MEM_ReleaseHeap(DATASP,DATASSO);
    MEM_ReleaseHeap(colSData,sizeof(ODBC_SAVE_DATA));
    odbcMyError(ODBC_SUCCESS,"odbcReleaseHam",SQL_NULL_HENV,SQL_NULL_HDBC,SQL_NULL_HSTMT);
}
// GetHam
void odbcGetHam(HAM Ham,ODBC_DATA FAR **Data)
{
    ODBC_DATA          *colData;
    ODBC_SAVE_DATA     *colSData;
    DATE_STRUCT        *ds;
    TIME_STRUCT        *ts;
    TIMESTAMP_STRUCT   *tss;
    UCHAR              buffer[SQL_MAX_MESSAGE_LENGTH]="0";
    int                i;

    odbc_check_loading("odbcGetHam");
    colData=MEM_AllocGStack(sizeof(ODBC_DATA));
    colSData=(ODBC_SAVE_DATA FAR *)Ham;
    for(i=0;i<100;i++)
        if(pnt_ham[i]==colSData)
        break;
    if(i==100)
    {
        GlobErr=ODBC_UNKNOWN_HAM;
        odbcMyError(ODBC_ERROR,"odbcGetHam",SQL_NULL_HENV,SQL_NULL_HDBC,SQL_NULL_HSTMT);
        return;
    }
    if(DATASS==SQL_NULL_DATA)
    {
        DATAF=ODBC_NULL;
    }
    else
    {
        DATAF=DATASF;
        switch(DATAF)
        {
            case(ODBC_STRING):
            case(ODBC_MEMO):
            case(ODBC_NUMERIC):
                DATAS=MEM_SaveStringGStack(DATASP);
                break;
            case(ODBC_BIT):
            case(ODBC_BYTE):
            case(ODBC_INTEGER):
                DATAI = *((int *)DATASP);
                break;
            case(ODBC_LONG):
                DATAL = *((long *)DATASP);
                break;
            case(ODBC_FLOAT):
            case(ODBC_REAL):
                odbc_mem_copy(DATASP,&DATAR,sizeof(double));
                break;
            case(ODBC_DATE):
                ds=DATASP;
                IO_SPrintf(buffer,"%-2d-%-2d-%-4d",ds->month,ds->day,ds->year);
                DATAS=MEM_SaveStringGStack(buffer);
                break;
            case(ODBC_TIME):
                ts=DATASP;
                IO_SPrintf(buffer,"%-2d:%-2d:%-2d",ts->hour,ts->minute,ts->second);
                DATAS=MEM_SaveStringGStack(buffer);
                break;
            case(ODBC_TIMESTAMP):
                tss=DATASP;
                IO_SPrintf(buffer,"%-2d-%-2d-%-4d %-2d:%-2d:%-2d",
                    tss->month,tss->day,tss->year,tss->hour,tss->minute,tss->second);
                DATAS=MEM_SaveStringGStack(buffer);
                break;
            case(ODBC_BINARY):
				DATAS=MEM_AllocGStack(DATASS+sizeof(int));
                odbc_mem_copy(&DATASS,DATAS,sizeof(int));
                odbc_mem_copy(DATASP,DATAS+sizeof(int),DATASS);
				DATAS=DATAS+sizeof(int);
                break;
        }
    }
    *Data=colData;
    odbcMyError(ODBC_SUCCESS,"odbcGetHam",SQL_NULL_HENV,SQL_NULL_HDBC,SQL_NULL_HSTMT);
    return;
}
// PutHam
void odbcPutHam(HAM Ham,ODBC_DATA FAR *Data)
{
    ODBC_DATA          *colData;
    ODBC_SAVE_DATA     *colSData;
    DATE_STRUCT        ds;
    TIME_STRUCT        ts;
    TIMESTAMP_STRUCT   tss;
    UCHAR              data[20],rest[20];
    int                i;

    odbc_check_loading("odbcPutHam");
    colData=Data;
    colSData=(ODBC_SAVE_DATA FAR *)Ham;
    for(i=0;i<100;i++)
        if(pnt_ham[i]==colSData)
        break;
    if(i==100)
    {
        GlobErr=ODBC_UNKNOWN_HAM;
        odbcMyError(ODBC_ERROR,"odbcPutHam",SQL_NULL_HENV,SQL_NULL_HDBC,SQL_NULL_HSTMT);
        return;
    }
    if (DATAF==ODBC_NULL)
    {
        DATASS=SQL_NULL_DATA;
    }
    else if (DATAF!=DATASF)
    {
        GlobErr=ODBC_UNKNOWN_PARAM_DATA;
        odbcMyError(ODBC_ERROR,"odbcPutHam",SQL_NULL_HENV,SQL_NULL_HDBC,SQL_NULL_HSTMT);
        return;
    }
    else
    {
        switch(DATAF)
        {
            case(ODBC_STRING):
            case(ODBC_MEMO):
            case(ODBC_NUMERIC):
                odbc_copy_str(DATAS,DATASP);
                DATASS=odbc_len_str(DATAS);
                break;
            case(ODBC_BIT):
            case(ODBC_BYTE):
            case(ODBC_INTEGER):
                odbc_mem_copy(&DATAI,DATASP,sizeof(short));
                DATASS=sizeof(short);
                break;
            case(ODBC_LONG):
                odbc_mem_copy(&DATAL,DATASP,sizeof(long));
                DATASS=sizeof(long);
                break;
            case(ODBC_FLOAT):
            case(ODBC_REAL):
                odbc_mem_copy(&DATAR,DATASP,sizeof(double));
                DATASS=sizeof(double);
                break;
            case(ODBC_DATE):
                odbc_cut_str(DATAS,2,data,rest);
                ds.month=odbc_atoi(data);
                odbc_cut_str(rest,2,data,rest);
                ds.day=odbc_atoi(data);
                odbc_cut_str(rest,4,data,rest);
                ds.year=odbc_atoi(data);
                odbc_mem_copy(&ds,DATASP,sizeof(DATE_STRUCT));
                DATASS=sizeof(DATE_STRUCT);
                break;
            case(ODBC_TIME):
                odbc_cut_str(DATAS,2,data,rest);
                ts.hour=odbc_atoi(data);
                odbc_cut_str(rest,2,data,rest);
                ts.minute=odbc_atoi(data);
                odbc_cut_str(rest,2,data,rest);
                ts.second=odbc_atoi(data);
                odbc_mem_copy(&ts,DATASP,sizeof(TIME_STRUCT));
                DATASS=sizeof(TIME_STRUCT);
                break;
            case(ODBC_TIMESTAMP):
                odbc_cut_str(DATAS,2,data,rest);
                tss.month=odbc_atoi(data);
                odbc_cut_str(rest,2,data,rest);
                tss.day=odbc_atoi(data);
                odbc_cut_str(rest,4,data,rest);
                tss.year=odbc_atoi(data);
                odbc_cut_str(rest,1,data,rest);
                odbc_cut_str(rest,2,data,rest);
                tss.hour=odbc_atoi(data);
                odbc_cut_str(rest,2,data,rest);
                tss.minute=odbc_atoi(data);
                odbc_cut_str(rest,2,data,rest);
                tss.second=odbc_atoi(data);
                odbc_mem_copy(&tss,DATASP,sizeof(TIMESTAMP_STRUCT));
                DATASS=sizeof(TIMESTAMP_STRUCT);
                break;
            case(ODBC_BINARY):
                DATASS=*((unsigned *)(DATAS-sizeof(int)));
                odbc_mem_copy(DATAS,DATASP,DATASS);
                break;
        }
    }
    odbcMyError(ODBC_SUCCESS,"odbcPutHam",SQL_NULL_HENV,SQL_NULL_HDBC,SQL_NULL_HSTMT);
    return;
}

void odbcAllocHul(HUL FAR *pHul)
{
	UDWORD *piRow;

	piRow=MEM_AllocHeap(sizeof(UDWORD));
	*pHul=(HUL)piRow;
	return;
}

void odbcReleaseHul(HUL Hul)
{
	UDWORD *piRow;

	(HUL)piRow=Hul;
	MEM_ReleaseHeap(piRow,sizeof(UDWORD));
	return;
}

void odbcGetHul(HUL Hul,UDWORD FAR *Data)
{
	UDWORD *piRow;

	(HUL)piRow=Hul;
	*Data=*piRow;
	return;
}

void odbcPutHul(HUL Hul,UDWORD Data)
{
	UDWORD *piRow;

	(HUL)piRow=Hul;
	*piRow=Data;
	return;
}
