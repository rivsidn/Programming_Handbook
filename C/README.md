


### TODO

```
#include <stdio.h>

int main()
{
	printf("%ld\n", (unsigned long)0x7FFFFFFF/1000/3600/24);
    //为什么结果不同
	printf("%ld\n", ((unsigned long)1<<31)/1000/3600/24);
	printf("%ld\n", (unsigned long)(1<<31)/1000/3600/24);

	return 0;
}

```
