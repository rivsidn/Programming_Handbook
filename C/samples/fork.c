#include <stdio.h>
#include <sys/types.h>
#include <unistd.h>

void parent()
{
	int i;
	volatile int sum = 0;

	for (i = 0; i < 1000000; i++) {
//	while (1) {
		sum += i;
	}
}

void child()
{
	int i;
	volatile int sum = 0;

	for (i = 0; i < 1000000; i++) {
//	while (1) {
		sum += i;
	}
	return;
}

int main()
{
	pid_t pid = fork();

	if (pid == 0) {
		child();
	} else if (pid > 0) {
		parent();
	} else {
		//error
	}

	return 0;
}
