//---------------------------------------------------------------------------

#include <vcl.h>
#include <iostream.h>
#include <conio.h>
#pragma hdrstop

//---------------------------------------------------------------------------

#include "IHXConverter.h"

//---------------------------------------------------------------------------

#pragma argsused
int main(int argc, char* argv[])
{
	int offset = 0;

	if (argc >= 3) {
		if (argc == 4)
			offset = atoi(argv[3]);
		CIhxConverter conv;
		conv.DoConvert(argv[1], argv[2], offset);

	} else {
		cout << "usage: ihx2bin <inputfile> <outputfile> <offset>\n";
	}

//	getch();
	return 0;
}
//---------------------------------------------------------------------------
