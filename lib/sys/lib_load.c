#include <string.h>
#include "a.out.h"
#include "muxxlib.h"
#include "errno.h"
#include "muxx.h"
#include "externals.h"

int load(char *dev, ADDRESS laddr, ADDRESS *entry) {
  int fd=0,rc=EOK;
  WORD n=0,stext=0,sdata=0,sbss=0,space=0,imgsize=0;
  struct exec ex;
  ADDRESS dest=NULL;
  TCB tcb;

  fd = open(dev,0);
  if (fd < 0) return fd;

  n = read(fd, sizeof(ex), (char *) &ex);
  if (n != sizeof(ex)) {
    rc = errno;
  } else {
    if (ex.a_magic != A_MAGIC1 &&
	ex.a_magic != A_MAGIC2) {
      rc = EINVLOAD;
    } else {
      *entry = (ADDRESS) ex.a_entry;
      stext = ex.a_text;
      sdata = ex.a_data;
      sbss  = ex.a_bss;
      gettpi(0,&tcb);
      dest = (ADDRESS) TASK_BASE;
      if (tcb.taskType & TSZ_BIG) {
	space = 3 * PAGE_SIZE;
      } else if (tcb.taskType & TSZ_MED) {
	space = 2 * PAGE_SIZE;
      } else {                                // SMALL task
	space = PAGE_SIZE;
      }
      imgsize = stext+sdata+sbss;
      printf("Loading task from %s, code=%d, data=%d, bss=%d, entry=%o\n",
	     dev,stext,sdata,sbss,*entry);
      if (imgsize > space) {
	rc = ENOMEM;
	errno = ENOMEM;
      } else {
	n = read(fd, stext, dest);
	if (n<stext) {
	  rc = errno;
	} else {
	  dest += stext;
	  n = read(fd, sdata, dest);
	  if (n<sdata) {
	    rc = errno;
	  } else {
	    dest += sdata;
	    if (sbss > 0) {
	      memset(dest, 0, sbss);
	    } 
	  }
	}
      }
    }
  }
  close(fd);
  if (rc == EOK) 
    return imgsize;
  else
    return 0;
} 
