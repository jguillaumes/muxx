#ifndef _TASK_QUEUES_H

#include "types.h"
#include "muxx.h"
#include "muxxdef.h"


#ifndef NULL
#define NULL ((void *)0)
#endif

struct TQUEUE_S {
  PTCB head;
  PTCB tail;
  int count;
};

typedef struct TQUEUE_S TQUEUE;
typedef struct TQUEUE_S *PTQUEUE;

void muxx_qAddTask(PTQUEUE, PTCB);
PTCB muxx_qGetTask(PTQUEUE);


#define _TASK_QUEUES_H
#endif
