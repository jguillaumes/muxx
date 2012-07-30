static const char   *newline = "\n\r";
static const short  nls = 2;

int conptstr(char const *string, short length) {
  register short i;
  register short rc;

  rc = 0;
  for(i=0;i<length && rc==0; i++) {
    rc = conptchr(string[i]);
  }
  return rc;
}

int conptlin() {
  return conptstr(newline,nls);
}

int conptstrl(char const *string, short length) {
  register short rc=0; 
  
  rc = conptstr(string, length);
  if (rc == 0) rc = conptlin();
  return rc;
}

