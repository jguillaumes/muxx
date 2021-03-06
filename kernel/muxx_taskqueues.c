#include "types.h"
#include "muxx.h"
#include "queues.h"

void muxx_qAddTask(PTQUEUE queue, PTCB task) {
  PTCB last;

  if (queue->count != 0) {
    last = queue->tail;
    last->nextInQueue = task;
    task->prevInQueue = last;
    task->nextInQueue = NULL;
    queue->count += 1;
    queue->tail = task;
  } else {
    queue->head = task;
    queue->tail = task;
    queue->count = 1;
    task->prevInQueue = NULL;
    task->nextInQueue = NULL;
  }
}

PTCB muxx_qGetTask(PTQUEUE queue) {
  PTCB theTask=NULL;

  if (queue->count > 0) {
    theTask = queue->head;
    queue->head = theTask->nextInQueue;
    queue->count -= 1;
    if (queue->count == 0) {
      queue->head = NULL;
      queue->tail = NULL;
    } else {
      queue->head->prevInQueue = NULL;
    }
  }
  theTask->prevInQueue = NULL;
  theTask->nextInQueue = NULL;
  return theTask;
}

PTCB muxx_qRemoveTask(PTQUEUE queue, PTCB task) {
  PTCB theTask = NULL;

  if (queue->count == 0) return NULL;

  theTask = queue->head;

  while(theTask != task && theTask != NULL) {
    theTask = theTask->nextInQueue;
  }

  if (theTask == NULL) {
    return NULL;
  } else {
    if (theTask->prevInQueue != NULL) {
      theTask->prevInQueue = theTask->nextInQueue;
    } else {
      queue->head = theTask->nextInQueue;
    }
    if (theTask->nextInQueue != NULL) {
      theTask->nextInQueue->prevInQueue = theTask->prevInQueue;
    } else {
      queue->tail = theTask->prevInQueue;
    }
    queue->count--;
    theTask->nextInQueue = NULL;
    theTask->prevInQueue = NULL;
    return theTask;
  }
}
