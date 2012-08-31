function trim(s,  c) {
    s = split(s,c,/[:blank:]+/);
    print "s: " s
    for (x in c) print "[" c[x] "]";

    return c[1];
}


BEGIN      { 
    print "\t.NOLIST ";
    print "/*";
    print " * This is a generated file - DO NOT EDIT ";
    print " * Edit the .h file and run \"make\" to regenerate the .s"
    print "*/"
	}
END        { print "\t.LIST " }
/\/\*/     { print }
/\*\*/     { print }
/\*\//     { print }
/#define[ \t]+[A-Za-z0-9]+.*/ {
    n = match($0,/#define[:blank:]*/);
    l = substr($0,n+RLENGTH+1);

    n = match(l, /[A-Za-z0-9]+(_[A-Za-z0-9]*)*/);
    macro = substr(l,n,RLENGTH);
    l = substr(l, n+RLENGTH+1);

    n = match(l, /[^[:blank:]]+[:blank:]?/);
    value = substr(l,n,RLENGTH);
    l = substr(l, n+RLENGTH+1);

    n = match(l, /\/\/.*/)
    comm = substr(l,n,RLENGTH);
    
    if (n!=0)
	print macro " = " value "\t\t" comm;
    else
       	print macro " = " value
}
/[ \t]+\n/   { print }

