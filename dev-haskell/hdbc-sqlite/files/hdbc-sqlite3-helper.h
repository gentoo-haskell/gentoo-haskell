#include <sqlite3.h>

extern int sqlite3_bind_text2(sqlite3_stmt* a, int b, const char *c, int d);

/* Clever trick: the obj is the first element in the struct, so the pointer
   to the struct is the same as the pointer to the obj. */

typedef struct TAG_finalizeonce {
  void *encapobj;
  int refcount;
  int isfinalized;
  struct TAG_finalizeonce *parent;
} finalizeonce;


extern int sqlite3_open2(const char *filename, finalizeonce **ppo);
extern int sqlite3_close_app(finalizeonce *ppdb);
extern void sqlite3_close_finalizer(finalizeonce *ppdb);
extern void sqlite3_conditional_finalizer(finalizeonce *ppdb);

extern void sqlite3_busy_timeout2(finalizeonce *ppdb, int ms);
extern int sqlite3_prepare2(finalizeonce *fdb, const char *zSql,
                            int nBytes, finalizeonce **ppo,
                            const char **pzTail);
extern int sqlite3_finalize_app(finalizeonce *ppst);
extern void sqlite3_finalize_finalizer(finalizeonce *ppst);


