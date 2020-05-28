#include <stdio.h>
#include <unistd.h>
#include <errno.h>
#include <sys/wait.h>
#include <sys/types.h>

int main() {
    int pid = fork();
    switch(pid) {
        case -1:
            perror("fork");
            return -1;
        case 0:
            // Child
            return 13;
        default: {
            // Parent
            int status;
            waitpid(pid, &status, 0);
            printf("exit normally? %s\n", (WIFEXITED(status) ? "true" : "false"));
            printf("child exitcode = %i\n", WEXITSTATUS(status));
            break;
        }
    }
    return 0;
}
