BEGIN      { 
	fname = ARGV[1];
	split(fname, comps, "\\.");
	print "#ifndef _"comps[1]"_H";
    	print "/*";
    	print " * This is a generated file - DO NOT EDIT ";
    	print " * Edit the " ARGV[1] " file and run \"make\" to regenerate it."
    	print "*/"
};
END	{
	print "#define _"comps[1]"_H";
	print "#endif";
}
/.*.=.*/    {
    gsub("\\.","_",$1);
    print "#define " $1 "\t\t" $3; 
}
