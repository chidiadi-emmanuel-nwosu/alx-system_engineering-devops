#include <stdio.h>
#include <unistd.h>

/**
 * infinite_while - infinite loop
 *
 * Return: 0
 */
int infinite_while(void)
{
	while (1)
	{
		sleep(1);
	}
	return (0);
}



/**
 * main - entry point
 *
 * Return: 0 on success
 */
int main(void)
{
	int i = 0;

	while (i < 5)
	{
		if (fork() == 0)
		{
			printf("Zombie process created, PID: %i\n", getpid());
			return (0);
		}
		i++;
	}
	infinite_while();

	return (0);
}
