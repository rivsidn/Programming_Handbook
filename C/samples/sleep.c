#include <unistd.h>

int main()
{
	int i = 0;

	while (i < 1) {
		sleep(1);
		i++;
	}

	return 0;
}
