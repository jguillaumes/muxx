BEGIN      { 
    print "\t.NOLIST ";
    print "/*";
    print " * This is a generated file - DO NOT EDIT ";
    print " * Edit muxxdef.h and run \"make\" to regenerate it."
    print "*/"
	}
END        { print "\t.LIST " }
/\/\*/     { print }
/\*\*/     { print }
/\*\//     { print }
/#define.*[0-9]+/    {
    print "\t" $2 " = " $3 $4 $5 $6 $7 $8;
}
/[ \t]+\n/   { print }
