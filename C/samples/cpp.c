#include <stdio.h>

#define PRINT_FILE_LINE() printf("File: %s, Line: %d\n", __FILE__, __LINE__)

int main()
{
	PRINT_FILE_LINE();
#include "header.h"
	PRINT_FILE_LINE();

	return 0;
}



