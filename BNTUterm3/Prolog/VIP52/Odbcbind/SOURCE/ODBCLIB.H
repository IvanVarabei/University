/******************************************************************************

		Copyright (c) 1984 - 1998 Prolog Development Center A/S

 FileName:	ODBCLIB.h
 Purpose:	ODBC binding
 Written by:	Sergey Alexeev
 Build:		008.981026
 Comments:	Tested with Borland C++ v.4.5 and MSC 5.0
******************************************************************************/
// Constants for odbcGetData (DataType)
#define ODBC_STRING     1
#define ODBC_BIT        2
#define ODBC_BYTE       3
#define ODBC_INTEGER    4
#define ODBC_LONG       5
#define ODBC_FLOAT      6
#define ODBC_REAL       7
#define ODBC_DATE       8
#define ODBC_TIME       9
#define ODBC_TIMESTAMP  10
#define ODBC_BINARY     11
#define ODBC_NUMERIC    12
#define ODBC_MEMO	    13
#define ODBC_NULL       14
// Constants for odbcColAttributes (DataType)
#define ODBC_COLUMN_AUTO_INCREMENT  1
#define ODBC_COLUMN_CASE_SENSITIVE  2
#define ODBC_COLUMN_COUNT        3
#define ODBC_COLUMN_DISPLAY_SIZE 4
#define ODBC_COLUMN_LABEL        5
#define ODBC_COLUMN_LENGTH       6
#define ODBC_COLUMN_MONEY        7
#define ODBC_COLUMN_NAME         8
#define ODBC_COLUMN_NULLABLE     9
#define ODBC_COLUMN_OWNER_NAME      10
#define ODBC_COLUMN_PRECISION    11
#define ODBC_COLUMN_QUALIFIER_NAME  12
#define ODBC_COLUMN_SCALE        13
#define ODBC_COLUMN_SEARCHABLE      14
#define ODBC_COLUMN_TABLE_NAME      15
#define ODBC_COLUMN_TYPE         16
#define ODBC_COLUMN_TYPE_NAME    17
#define ODBC_COLUMN_UNSIGNED     18
#define ODBC_COLUMN_UPDATABLE    19

#define ODBC_NO_NULLS         1
#define ODBC_NULLABLE         2
#define ODBC_NULLABLE_UNKNOWN 3

#define ODBC_UNSEARCHABLE     1
#define ODBC_LIKE_ONLY        2
#define ODBC_ALL_EXCEPT_LIKE  3
#define ODBC_SEARCHABLE       4

#define ODBC_ATTR_READONLY    1
#define ODBC_ATTR_WRITE       2
#define ODBC_ATTR_READWRITE_UNKNOWN 3
// Constants for odbcDataSources and odbcDrivers(direction)
#define ODBC_FETCH_FIRST   1
#define ODBC_FETCH_NEXT    2
// Constants for odbcGetInfo (DataType)
#define ODBC_ACTIVE_CONNECTIONS  1
#define ODBC_ACTIVE_STATEMENTS   2
#define ODBC_DATA_SOURCE_NAME 3
#define ODBC_DRIVER_HDBC   4
#define ODBC_DRIVER_HENV   5
#define ODBC_DRIVER_HLIB   6
#define ODBC_DRIVER_HSTMT  7
#define ODBC_DRIVER_NAME   8
#define ODBC_DRIVER_ODBC_VER  9
#define ODBC_DRIVER_VER    10
#define ODBC_FETCH_DIRECTION  11
#define ODBC_FILE_USAGE    12
#define ODBC_GETDATA_EXTENSIONS  13
#define ODBC_LOCK_TYPES    14
#define ODBC_ODBC_API_CONFORMANCE   15
#define ODBC_ODBC_SAG_CLI_CONFORMANCE  16
#define ODBC_ODBC_VER         17
#define ODBC_POS_OPERATIONS      18
#define ODBC_ROW_UPDATES      19
#define ODBC_SEARCH_PATTERN_ESCAPE  20
#define ODBC_SERVER_NAME      21
#define ODBC_DATABASE_NAME    22
#define ODBC_DBMS_NAME        23
#define ODBC_DBMS_VER         24
#define ODBC_ACCESSIBLE_PROCEDURES  25
#define ODBC_ACCESSIBLE_TABLES      26
#define ODBC_BOOKMARK_PERSISTENCE   27
#define ODBC_CONCAT_NULL_BEHAVIOR   28
#define ODBC_CURSOR_COMMIT_BEHAVIOR 29
#define ODBC_CURSOR_ROLLBACK_BEHAVIOR  30
#define ODBC_DATA_SOURCE_READ_ONLY  31
#define ODBC_DEFAULT_TXN_ISOLATION  32
#define ODBC_MULT_RESULT_SETS    33
#define ODBC_MULTIPLE_ACTIVE_TXN 34
#define ODBC_NEED_LONG_DATA_LEN     35
#define ODBC_NULL_COLLATION      36
#define ODBC_OWNER_TERM       37
#define ODBC_PROCEDURE_TERM      38
#define ODBC_QUALIFIER_TERM      39
#define ODBC_SCROLL_CONCURRENCY     40
#define ODBC_SCROLL_OPTIONS      41
#define ODBC_STATIC_SENSITIVITY     42
#define ODBC_TABLE_TERM       43
#define ODBC_TXN_CAPABLE      44
#define ODBC_TXN_ISOLATION_OPTION   45
#define ODBC_USER_NAME        46
#define ODBC_ALTER_TABLE      47
#define ODBC_COLUMN_ALIAS     48
#define ODBC_CORRELATION_NAME    49
#define ODBC_EXPRESSIONS_IN_ORDERBY 50
#define ODBC_GROUP_BY         51
#define ODBC_IDENTIFIER_CASE     52
#define ODBC_IDENTIFIER_QUOTE_CHAR  53
#define ODBC_KEYWORDS         54
#define ODBC_LIKE_ESCAPE_CLAUSE     55
#define ODBC_NON_NULLABLE_COLUMNS   56
#define ODBC_ODBC_SQL_CONFORMANCE   57
#define ODBC_ODBC_SQL_OPT_IEF    58
#define ODBC_ORDER_BY_COLUMNS_IN_SELECT   59
#define ODBC_OUTER_JOINS      60
#define ODBC_OWNER_USAGE      61
#define ODBC_POSITIONED_STATEMENTS  62
#define ODBC_PROCEDURES       63
#define ODBC_QUALIFIER_LOCATION     64
#define ODBC_QUALIFIER_NAME_SEPARATOR  65
#define ODBC_QUALIFIER_USAGE     66
#define ODBC_QUOTED_IDENTIFIER_CASE 67
#define ODBC_SPECIAL_CHARACTERS     68
#define ODBC_SUBQUERIES       69
#define ODBC_UNION         70
#define ODBC_MAX_BINARY_LITERAL_LEN 71
#define ODBC_MAX_CHAR_LITERAL_LEN   72
#define ODBC_MAX_COLUMN_NAME_LEN 73
#define ODBC_MAX_COLUMNS_IN_GROUP_BY   74
#define ODBC_MAX_COLUMNS_IN_ORDER_BY   75
#define ODBC_MAX_COLUMNS_IN_INDEX   76
#define ODBC_MAX_COLUMNS_IN_SELECT  77
#define ODBC_MAX_COLUMNS_IN_TABLE   78
#define ODBC_MAX_CURSOR_NAME_LEN 79
#define ODBC_MAX_INDEX_SIZE      80
#define ODBC_MAX_OWNER_NAME_LEN     81
#define ODBC_MAX_PROCEDURE_NAME_LEN 82
#define ODBC_MAX_QUALIFIER_NAME_LEN 83
#define ODBC_MAX_ROW_SIZE     84
#define ODBC_MAX_ROW_SIZE_INCLUDES_LONG   85
#define ODBC_MAX_STATEMENT_LEN      86
#define ODBC_MAX_TABLE_NAME_LEN     87
#define ODBC_MAX_TABLES_IN_SELECT   88
#define ODBC_MAX_USER_NAME_LEN      89
#define ODBC_CONVERT_FUNCTIONS      90
#define ODBC_NUMERIC_FUNCTIONS      91
#define ODBC_STRING_FUNCTIONS    92
#define ODBC_SYSTEM_FUNCTIONS    93
#define ODBC_TIMEDATE_ADD_INTERVALS 94
#define ODBC_TIMEDATE_DIFF_INTERVALS   95
#define ODBC_TIMEDATE_FUNCTIONS     96
#define ODBC_CONVERT_BIGINT      97
#define ODBC_CONVERT_BINARY      98
#define ODBC_CONVERT_BIT      99
#define ODBC_CONVERT_CHAR     100
#define ODBC_CONVERT_DATE     101
#define ODBC_CONVERT_DECIMAL     102
#define ODBC_CONVERT_DOUBLE      103
#define ODBC_CONVERT_FLOAT    104
#define ODBC_CONVERT_INTEGER     105
#define ODBC_CONVERT_LONGVARBINARY  106
#define ODBC_CONVERT_LONGVARCHAR 107
#define ODBC_CONVERT_NUMERIC     108
#define ODBC_CONVERT_REAL     109
#define ODBC_CONVERT_SMALLINT    110
#define ODBC_CONVERT_TIME     111
#define ODBC_CONVERT_TIMESTAMP      112
#define ODBC_CONVERT_TINYINT     113
#define ODBC_CONVERT_VARBINARY      114
#define ODBC_CONVERT_VARCHAR     115
// Constants for odbcFreeStmt (Option)
#define ODBC_DROP    1
#define ODBC_CLOSE      2
#define ODBC_UNBIND     3
#define ODBC_RESET_PARAMS  4
// Constants for odbcExtendeFetch (FetchType) and odbcDataSources (direction)
#define ODBC_FETCH_LAST    3
#define ODBC_FETCH_PRIOR   4
#define ODBC_FETCH_ABSOLUTE   5
#define ODBC_FETCH_RELATIVE   6
#define ODBC_FETCH_BOOKMARK   7
// Constants for odbcSetPos (Option)
#define ODBC_POSITION   1
#define ODBC_REFRESH 2
#define ODBC_UPDATE  3
#define ODBC_DELETE  4
#define ODBC_ADD  5
// Constants for odbcSetPos (Lock)
#define ODBC_LOCK_NO_CHANGE   1
#define ODBC_LOCK_EXCLUSIVE   2
#define ODBC_LOCK_UNLOCK   3
// Constants for odbcSetScrollOptions (Concurrency)
#define ODBC_CONCUR_READ_ONLY 1
#define ODBC_CONCUR_LOCK   2
#define ODBC_CONCUR_ROWVER 3
#define ODBC_CONCUR_VALUES 4
// Constants for odbcSetScrollOptions (crowKeyset)
#define ODBC_SCROLL_FORWARD_ONLY -3
#define ODBC_SCROLL_STATIC    -2
#define ODBC_SCROLL_KEYSET_DRIVEN   -1
#define ODBC_SCROLL_DYNAMIC      0
// Constants for odbcSetStmtOption (Option)
//    Constants for odbcSetStmtOption (Param)
#define ODBC_ASYNC_ENABLE     1
   #define ODBC_ASYNC_ENABLE_OFF    1
   #define ODBC_ASYNC_ENABLE_ON     2
#define ODBC_BIND_TYPE        2
   #define ODBC_BIND_BY_COLUMN      1
#define ODBC_CONCURRENCY      3
   #define ODBC_CONCUR_READ_ONLY    1
   #define ODBC_CONCUR_LOCK      2
   #define ODBC_CONCUR_ROWVER    3
   #define ODBC_CONCUR_VALUES    4
#define ODBC_CURSOR_TYPE      4
   #define ODBC_CURSOR_FORWARD_ONLY 1
   #define ODBC_CURSOR_STATIC    2
   #define ODBC_CURSOR_KEYSET_DRIVEN   3
   #define ODBC_CURSOR_DYNAMIC      4
#define ODBC_KEYSET_SIZE      5
#define ODBC_MAX_LENGTH       6
#define ODBC_MAX_ROWS         7
#define ODBC_NOSCAN        8
   #define ODBC_NOSCAN_OFF       1
   #define ODBC_NOSCAN_ON        2
#define ODBC_QUERY_TIMEOUT    9
#define ODBC_RETRIEVE_DATA    10
   #define ODBC_RD_ON         1
   #define ODBC_RD_OFF        2
#define ODBC_ROWSET_SIZE      11
#define ODBC_SIMULATE_CURSOR     12
   #define ODBC_SC_NON_UNIQUE    1
   #define ODBC_SC_TRY_UNIQUE    2
   #define ODBC_SC_UNIQUE        3
#define ODBC_USE_BOOKMARKS    13
	#define ODBC_UB_OFF        1
   #define ODBC_UB_ON         2
// Constants for odbcSetConnectOption (Option)
//    Constants for odbcSetConnectOption (Param)
#define ODBC_ACCESS_MODE      1
   #define ODBC_MODE_READ_ONLY      1
   #define ODBC_MODE_READ_WRITE     2
#define ODBC_AUTOCOMMIT       2
   #define ODBC_AUTOCOMMIT_OFF      1
   #define ODBC_AUTOCOMMIT_ON    2
#define ODBC_CURRENT_QUALIFIER      3
#define ODBC_LOGIN_TIMEOUT    4
#define ODBC_ODBC_CURSORS     5
   #define ODBC_CUR_USE_IF_NEEDED      1
   #define ODBC_CUR_USE_ODBC     2
   #define ODBC_CUR_USE_DRIVER      3
#define ODBC_OPT_TRACE        6
   #define ODBC_OPT_TRACE_OFF    1
   #define ODBC_OPT_TRACE_ON     2
#define ODBC_OPT_TRACEFILE    7
#define ODBC_PACKET_SIZE      8
#define ODBC_QUIET_MODE       9
#define ODBC_TRANSLATE_DLL    10
#define ODBC_TRANSLATE_OPTION    11
#define ODBC_TXN_ISOLATION    12
   #define ODBC_TXN_READ_UNCOMMITTED   1
   #define ODBC_TXN_READ_COMMITTED     2
   #define ODBC_TXN_REPEATABLE_READ 3
   #define ODBC_TXN_SERIALIZABLE    4
   #define ODBC_TXN_VERSIONING      5
// Constants for odbcGetConnectOption (Option)
#define ODBC_ACCESS_MODE      1
#define ODBC_AUTOCOMMIT       2
#define ODBC_CURRENT_QUALIFIER      3
#define ODBC_LOGIN_TIMEOUT    4
#define ODBC_ODBC_CURSORS     5
#define ODBC_OPT_TRACE        6
#define ODBC_OPT_TRACEFILE    7
#define ODBC_PACKET_SIZE      8
#define ODBC_QUIET_MODE       9
#define ODBC_TRANSLATE_DLL    10
#define ODBC_TRANSLATE_OPTION    11
#define ODBC_TXN_ISOLATION    12
// Constants for odbcGetStmtOption (Option)
#define ODBC_ASYNC_ENABLE     1
#define ODBC_BIND_TYPE        2
#define ODBC_CONCURRENCY      3
#define ODBC_CURSOR_TYPE      4
#define ODBC_KEYSET_SIZE      5
#define ODBC_MAX_LENGTH       6
#define ODBC_MAX_ROWS         7
#define ODBC_NOSCAN        8
#define ODBC_QUERY_TIMEOUT    9
#define ODBC_RETRIEVE_DATA    10
#define ODBC_ROWSET_SIZE      11
#define ODBC_SIMULATE_CURSOR     12
#define ODBC_USE_BOOKMARKS    13
#define ODBC_GET_BOOKMARK     14
#define ODBC_ROW_NUMBER       15
// Constants for odbcTransact (Type)
#define ODBC_COMMIT  1
#define ODBC_ROLLBACK   2
// Constants for odbcGetFunctions (Function)
// The following table lists valid values for fFunction for ODBC core functions.
#define ODBC_API_SQLALLOCCONNECT 1
#define ODBC_API_SQLALLOCENV     2
#define ODBC_API_SQLALLOCSTMT    3
#define ODBC_API_SQLBINDCOL      4
#define ODBC_API_SQLCANCEL    5
#define ODBC_API_SQLCOLATTRIBUTES   6
#define ODBC_API_SQLCONNECT      7
#define ODBC_API_SQLDESCRIBECOL     8
#define ODBC_API_SQLDISCONNECT      9
#define ODBC_API_SQLERROR     10
#define ODBC_API_SQLEXECDIRECT      11
#define ODBC_API_SQLEXECUTE      12
#define ODBC_API_SQLFETCH     13
#define ODBC_API_SQLFREECONNECT     14
#define ODBC_API_SQLFREEENV      15
#define ODBC_API_SQLFREESTMT     16
#define ODBC_API_SQLGETCURSORNAME   17
#define ODBC_API_SQLNUMRESULTCOLS   18
#define ODBC_API_SQLPREPARE      19
#define ODBC_API_SQLROWCOUNT     20
#define ODBC_API_SQLSETCURSORNAME   21
#define ODBC_API_SQLSETPARAM     22
#define ODBC_API_SQLTRANSACT     23
// The following table lists valid values for fFunction for ODBC extension level 1 functions.
#define ODBC_API_SQLBINDPARAMETER   24
#define ODBC_API_SQLCOLUMNS      25
#define ODBC_API_SQLDRIVERCONNECT   26
#define ODBC_API_SQLGETCONNECTOPTION   27
#define ODBC_API_SQLGETDATA      28
#define ODBC_API_SQLGETFUNCTIONS 29
#define ODBC_API_SQLGETINFO      30
#define ODBC_API_SQLGETSTMTOPTION   31
#define ODBC_API_SQLGETTYPEINFO     32
#define ODBC_API_SQLPARAMDATA    33
#define ODBC_API_SQLPUTDATA      34
#define ODBC_API_SQLSETCONNECTOPTION   35
#define ODBC_API_SQLSETSTMTOPTION   36
#define ODBC_API_SQLSPECIALCOLUMNS  37
#define ODBC_API_SQLSTATISTICS      38
#define ODBC_API_SQLTABLES    39
// The following table lists valid values for fFunction for ODBC extension level 2 functions.
#define ODBC_API_SQLBROWSECONNECT   40
#define ODBC_API_SQLCOLUMNPRIVILEGES   41
#define ODBC_API_SQLDATASOURCES     42
#define ODBC_API_SQLDESCRIBEPARAM   43
#define ODBC_API_SQLDRIVERS      44
#define ODBC_API_SQLEXTENDEDFETCH   45
#define ODBC_API_SQLFOREIGNKEYS     46
#define ODBC_API_SQLMORERESULTS     47
#define ODBC_API_SQLNATIVESQL    48
#define ODBC_API_SQLNUMPARAMS    49
#define ODBC_API_SQLPARAMOPTIONS 50
#define ODBC_API_SQLPRIMARYKEYS     51
#define ODBC_API_SQLPROCEDURECOLUMNS   52
#define ODBC_API_SQLPROCEDURES      53
#define ODBC_API_SQLSETPOS    54
#define ODBC_API_SQLSETSCROLLOPTIONS   55
#define ODBC_API_SQLTABLEPRIVILEGES 56
// Constants for odbcSpecialColumns (ColType)
#define ODBC_BEST_ROWID    1
#define ODBC_ROWVER     2
// Constants for odbcSpecialColumns (Scope)
#define ODBC_SCOPE_CURROW  1
#define ODBC_SCOPE_TRANSACTION   2
#define ODBC_SCOPE_SESSION 3
// Constants for odbcSpecialColumns (Nullable)
#define ODBC_NO_NULLS      1
#define ODBC_NULLABLE      2
// Constants for odbcStatistics (Unique)
#define ODBC_INDEX_UNIQUE  1
#define ODBC_INDEX_ALL     2
// Constants for odbcStatistics (Accuracy)
#define ODBC_ENSURE     1
#define ODBC_QUICK      2
// Constants for odbcDriverConnect (DriverCompletion)
#define ODBC_DRIVER_PROMPT    1
#define ODBC_DRIVER_COMPLETE     2
#define ODBC_DRIVER_COMPLETE_REQUIRED  3
#define ODBC_DRIVER_NOPROMPT     4
// Constants for odbcBindParameter (ParamType)
#define ODBC_PARAM_INPUT      1
#define ODBC_PARAM_INPUT_OUTPUT     2

// ***** Data Type Definitions *****
typedef int INTEGER;
typedef unsigned UNSIGNED;
typedef unsigned char far * STRING;
typedef int PDC_BOOLEAN;
typedef long WINDOW;
typedef unsigned long HAM;
typedef UDWORD HUL;

typedef struct data_struct
{
    unsigned char fno;
    union
    {
        STRING     s;
        INTEGER    i;
        long       l;
        double     r;
    } u;
} ODBC_DATA;

typedef struct data_column_struct
{
    unsigned char fno;
    union
    {
        PDC_BOOLEAN   ai;
        PDC_BOOLEAN   cs;
        UNSIGNED      co;
        long          ds;
        STRING        la;
        long          le;
        PDC_BOOLEAN   mo;
        STRING        na;
        UNSIGNED      nu;
        STRING        on;
        long          pr;
        STRING        qn;
        long          sc;
        UNSIGNED      se;
        STRING        tn;
        UNSIGNED      ty;
        STRING        ta;
        PDC_BOOLEAN   un;
        UNSIGNED      up;
    } u;
} ODBC_COLUMN_DATA;

typedef struct data_info_struct
{
    unsigned char fno;
    union
    {
        INTEGER    i;
        long       l;
        STRING     s;
    } u;
} ODBC_INFO_DATA;

typedef struct data_co_struct
{
    unsigned char fno;
    union
    {
        UDWORD  l;
        STRING  s;
    } u;
} ODBC_CO_DATA;

// ***** Global Functions Prototypes *****
void odbcInit(void);
void odbcDestroy(void);

void odbcGetError(INTEGER FAR *ErrCode,STRING FAR *ErrFunc,STRING FAR *ErrMess);//(o,o,o)

void odbcAllocConnect(HENV henv,HDBC FAR *phdbc);           //(i,o)
void odbcAllocEnv(HENV FAR *phenv);                //(o)
void odbcAllocStmt(HENV henv,HDBC hdbc,HSTMT FAR *phstmt);        //(i,i,o)
void odbcBindCol(HENV henv,HDBC hdbc,HSTMT hstmt,UNSIGNED icol,UNSIGNED dataType,   //(i,i,i,i,i,i,o)
	UNSIGNED BufferLen,HAM FAR *Ham);
void odbcBindParameter(HENV henv,HDBC hdbc,HSTMT hstmt,UNSIGNED ipar,      //(i,i,i,i,i,i,i,i,i,o)
	UNSIGNED ParamType,UNSIGNED dataType,UDWORD Precision,INTEGER Scale,
	UNSIGNED BufferLen,HAM FAR *Ham);
void odbcBrowseConnect(HENV henv,HDBC hdbc,STRING ConnStrIn,         //(i,i,i,o)
	STRING FAR *ConnStrOut);
void odbcCancel(HENV henv,HDBC hdbc,HSTMT hstmt);           //(i,i,i)
void odbcColAttributes(HENV henv,HDBC hdbc,HSTMT hstmt,UNSIGNED icol,      //(i,i,i,i,i,o)
	UNSIGNED dataType,ODBC_COLUMN_DATA FAR **Data);
void  odbcColumnPrivileges(HENV henv,HDBC hdbc,HSTMT hstmt,       //(i,i,i,i,i,i,i)
   STRING TableQualifier,STRING TableOwner,STRING TableName,
   STRING ColumnName);
void odbcColumns(HENV henv,HDBC hdbc,HSTMT hstmt,STRING TableQualifier,    //(i,i,i,i,i,i,i)
   STRING TableOwner,STRING TableName,STRING ColumnName);
void odbcConnect(HENV henv,HDBC hdbc,STRING szDSN,          //(i,i,i,i,i)
   STRING szUID,STRING szAuthStr);
void odbcDataSources(HENV henv,UNSIGNED Direction,STRING FAR *Name,     //(i,i,o,o)
   STRING FAR *Description);
void odbcDescribeCol(HENV henv,HDBC hdbc,HSTMT hstmt,UNSIGNED icol,     //(i,i,i,i,o,o,o,o,o)
   STRING FAR *Name,INTEGER FAR *Type,UDWORD FAR *Precision,
   INTEGER FAR *Scale,INTEGER FAR *Nullable);
void odbcDescribeParam(HENV henv,HDBC hdbc,HSTMT hstmt,UNSIGNED ipar,      //(i,i,i,i,o,o,o,o)
   INTEGER FAR *Type,UDWORD FAR *Precision,INTEGER FAR *Scale,
   INTEGER FAR *Nullable);
void odbcDisconnect(HENV henv,HDBC hdbc);             //(i,i)
void odbcDriverConnect(HENV henv,HDBC hdbc,WINDOW hwnd,STRING ConnStrIn,      //(i,i,i,i,i,o)
   UNSIGNED DriverCompletion,STRING FAR *ConnStrOut);
void odbcDrivers(HENV henv,UNSIGNED Direction,STRING FAR *DriverDescription,  //(i,i,o,o)
   STRING FAR *DriverAttributes);
void odbcExecute(HENV henv,HDBC hdbc,HSTMT hstmt);          //(i,i,i)
void odbcExecDirect(HENV henv,HDBC hdbc,HSTMT hstmt,STRING szSqlStr);      //(i,i,i,i)
void odbcExtendedFetch(HENV henv,HDBC hdbc,HSTMT hstmt,UNSIGNED FetchType,    //(i,i,i,i,i,o)
   SDWORD irow,UDWORD FAR *pcrow);
void odbcFetch(HENV henv,HDBC hdbc,HSTMT hstmt);            //(i,i,i)
void odbcForeignKeys(HENV henv,HDBC hdbc,HSTMT hstmt,          //(i,i,i,i,i,i,i,i,i)
   STRING PkTableQualifier,STRING PkTableOwner,STRING PkTableName,
   STRING FkTableQualifier,STRING FkTableOwner,STRING FkTableName);
void odbcFreeConnect(HENV henv,HDBC hdbc);               //(i,i)
void odbcFreeEnv(HENV henv);                    //(i)
void odbcFreeStmt(HENV henv,HDBC hdbc,HSTMT hstmt,UNSIGNED Option);     //(i,i,i,i)
void odbcGetConnectOption(HENV henv,HDBC hdbc,UNSIGNED Option,       //(i,i,i,o)
   ODBC_CO_DATA **Param);
void odbcGetCursorName(HENV henv,HDBC hdbc,HSTMT hstmt,STRING FAR *Cursor);   //(i,i,i,o)
void odbcGetData(HENV henv,HDBC hdbc,HSTMT hstmt,UNSIGNED icol,UNSIGNED dataType,   //(i,i,i,i,i,i,o,o)
   UNSIGNED size,ODBC_DATA FAR **Data,UNSIGNED FAR *DataSize);
void odbcGetFunctions(HENV henv,HDBC hdbc,UNSIGNED Function,UNSIGNED FAR *Exists);  //(i,i,i,o)
void odbcGetInfo(HENV henv,HDBC hdbc,UNSIGNED dataType,ODBC_INFO_DATA FAR **Data);  //(i,i,i,o)
void odbcGetStmtOption(HENV henv,HDBC hdbc,HSTMT hstmt,UNSIGNED Option,    //(i,i,i,i,o)
   UDWORD FAR *Param);
void odbcGetTypeInfo(HENV henv,HDBC hdbc,HSTMT hstmt,UNSIGNED dataType);      //(i,i,i,i)
void odbcMoreResults(HENV henv,HDBC hdbc,HSTMT hstmt);            //(i,i,i)
void odbcNativeSql(HENV henv,HDBC hdbc,STRING SqlStrIn,STRING FAR *SqlStr);   //(i,i,i,o)
void odbcNumParams(HENV henv,HDBC hdbc,HSTMT hstmt,INTEGER FAR *NumPar);     //(i,i,i,o)
void odbcNumResultCols(HENV henv,HDBC hdbc,HSTMT hstmt,INTEGER FAR *NumCol);  //(i,i,i,o)
void odbcParamData(HENV henv,HDBC hdbc,HSTMT hstmt,HAM FAR *Ham);    //(i,i,i,o)
void odbcParamOptions(HENV henv,HDBC hdbc,HSTMT hstmt,UDWORD crow,HUL pirow);//(i,i,i,i,i)
void odbcPrepare(HENV henv,HDBC hdbc,HSTMT hstmt,STRING szSqlStr);      //(i,i,i,i)
void odbcPrimaryKeys(HENV henv,HDBC hdbc,HSTMT hstmt,STRING TableQualifier,   //(i,i,i,i,i,i)
   STRING TableOwner,STRING TableName);
void odbcProcedureColumns(HENV henv,HDBC hdbc,HSTMT hstmt,STRING ProcQualifier, //(i,i,i,i,i,i,i)
   STRING ProcOwner,STRING ProcName,STRING ColumnName);
void odbcProcedures(HENV henv,HDBC hdbc,HSTMT hstmt,STRING ProcQualifier,  //(i,i,i,i,i,i)
   STRING ProcOwner,STRING ProcName);
void odbcPutData(HENV henv,HDBC hdbc,HSTMT hstmt,HAM Ham);        //(i,i,i,i)
void odbcRowCount(HENV henv,HDBC hdbc,HSTMT hstmt,long FAR *NumRow); //(i,i,i,o)
void odbcSetConnectOption(HENV henv,HDBC hdbc,UNSIGNED Option,ODBC_CO_DATA *Param);//(i,i,i,i)
void odbcSetCursorName(HENV henv,HDBC hdbc,HSTMT hstmt,STRING Cursor);     //(i,i,i,i)
void odbcSetParam(HENV henv,HDBC hdbc,HSTMT hstmt,UNSIGNED ipar,     //(i,i,i,i,i,i,i,i,o)
	UNSIGNED dataType,UDWORD Precision,INTEGER Scale,
   UNSIGNED BufferLen,HAM FAR *Ham);
void odbcSetPos(HENV henv,HDBC hdbc,HSTMT hstmt,UNSIGNED irow,UNSIGNED Option,   //(i,i,i,i,i,i)
   UNSIGNED Lock);
void odbcSetScrollOptions(HENV henv,HDBC hdbc,HSTMT hstmt,UNSIGNED Concurrency,  //(i,i,i,i,i,i)
   SDWORD crowKeyset,UNSIGNED crowRowset);
void odbcSetStmtOption(HENV henv,HDBC hdbc,HSTMT hstmt,UNSIGNED Option,    //(i,i,i,i,i)
   UDWORD Param);
void odbcSpecialColumns(HENV henv,HDBC hdbc,HSTMT hstmt,UNSIGNED ColType,     //(i,i,i,i,i,i,i,i,i)
   STRING TableQualifier,STRING TableOwner,STRING TableName,UNSIGNED Scope,
   UNSIGNED Nullable);
void odbcStatistics(HENV henv,HDBC hdbc,HSTMT hstmt,STRING TableQualifier, //(i,i,i,i,i,i,i,i)
   STRING TableOwner,STRING TableName,UNSIGNED Unique,UNSIGNED Accuracy);
void odbcTablePrivileges(HENV henv,HDBC hdbc,HSTMT hstmt,STRING TableQualifier,  //(i,i,i,i,i,i)
   STRING TableOwner,STRING TableName);
void odbcTables(HENV henv,HDBC hdbc,HSTMT hstmt,STRING TableQualifier,     //(i,i,i,i,i,i,i)
   STRING TableOwner,STRING TableName,STRING TableType);
void odbcTransact(HENV henv,HDBC hdbc,UNSIGNED Type);          //(i,i,i)

void odbcReleaseHam(HAM Ham);                   //(i)
void odbcGetHam(HAM Ham,ODBC_DATA FAR **Data);              //(i,o)
void odbcPutHam(HAM Ham,ODBC_DATA FAR *Data);               //(i,i)

void odbcAllocHul(HUL FAR *pHul);					//(o)
void odbcReleaseHul(HUL Hul);						//(i)
void odbcGetHul(HUL Hul,UDWORD FAR *Data);			//(i,o)
void odbcPutHul(HUL Hul,UDWORD Data);				//(i,i)




