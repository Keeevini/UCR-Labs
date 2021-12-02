#include "types.h"
#include "user.h"

#define WNOHANG 1

int main(int argc, char *argv[]){

	printf(1, "\nTest Program TEST\n");

	int pid;
	int status = 10;

	pid = fork();
	if (pid) {
		int secondPID = waitpid(pid, &status, 0);
		
		printf(1, "\nparent pid: %d child pid: %d status: %d", getpid(), secondPID, status);
		sleep(2);
		printf(1, "\n");
		exit(0);

	}
	else {
		printf(1, "\nchild pid: %d status: %d", getpid(), status);
		sleep(2);
		printf(1, "\n");
		exit(0);
	}

}
