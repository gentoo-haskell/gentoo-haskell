#ifdef mingw32_HOST_OS
#include <windows.h>
#endif
#include <sql.h>

extern int sqlSucceeded(SQLRETURN ret);
extern SQLRETURN sqlFreeHandleEnv(SQLHANDLE hdl);

typedef struct TAG_finalizeonce {
  void *encapobj;
  int refcount;
  int isfinalized;
  void *extrainfo;
  struct TAG_finalizeonce *parent;
} finalizeonce;

extern finalizeonce *wrapobjodbc(void *obj, finalizeonce *parentobj);
extern finalizeonce *wrapobjodbc_extra(void *obj, void *extra,
                                       finalizeonce *parentobj);

extern SQLRETURN sqlFreeHandleDbc_app(finalizeonce *res);
extern void sqlFreeHandleDbc_finalizer(finalizeonce *res);

extern void sqlFreeHandleSth_app(finalizeonce *res);
extern void sqlFreeHandleSth_finalizer(finalizeonce *res);

extern SQLINTEGER nullData;
extern void *getSqlOvOdbc3(void);

extern SQLRETURN disableAutoCommit(SQLHDBC conn);
extern SQLRETURN simpleSqlTables(SQLHSTMT stmt);
extern SQLRETURN simpleSqlColumns(SQLHSTMT stmt, SQLCHAR *tablename, 
                                  SQLSMALLINT tnlen);

