#ifndef _ERRNO_H

#include <errors.h>

#define errno (curtcb->taskTUCB->t_errno)
void perror(char *);

#define _ERRNO_H
#endif
