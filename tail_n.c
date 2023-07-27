#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <fcntl.h>

#define MAX_LINE_LENGTH 1024

void printLastLines(int fd, const char *filename, int numLines) {
    int i, n, m, totalLines = 0, startLine;

    char buffer[MAX_LINE_LENGTH];

    while ((n = read(fd, buffer, sizeof(buffer))) > 0) {
        for (i = 0; i < n; i++) {
            if (buffer[i] == '\n') {
                totalLines++;
                if (strcmp(filename, "") == 0) {
                    printf("\n");
                }
            } else {
                if (strcmp(filename, "") == 0) {
                    if (buffer[i] == '\0') {
                        return;
                    }
                    if (buffer[i] != '\n') {
                        printf("%c", buffer[i]);
                    } else {
                        printf("\n");
                    }
                }
            }
        }
    }

    close(fd);

    startLine = totalLines - numLines;
    int lineCount = 0;
    int fd2 = open(filename, 0);

    while ((m = read(fd2, buffer, sizeof(buffer))) > 0) {
        for (i = 0; i < m; i++) {
            if (buffer[i] == '\n') {
                lineCount++;
            }
            if (lineCount >= startLine) {
                if (buffer[i] != '\n' && lineCount >= startLine) {
                    printf("%c", buffer[i]);
                } else {
                    printf("\n");
                    lineCount++;
                }
            }
        }
    }

    close(fd2);

    if (n < 0) {
        printf("tail: error while reading\n");
        return;
    }
}

int main(int argc, char *argv[]) {
    int fd, i;

    if (argc <= 1) {
        printLastLines(0, "", 10);
        return 1;
    } else if (argc == 2) {
        for (i = 1; i < argc; i++) {
            if ((fd = open(argv[i], 0)) < 0) {
                printf("Error opening the file: %s\n", argv[i]);
                return 1;
            }
            printLastLines(fd, argv[i], 10);
            close(fd);
        }
    } else if (argc == 3) {
        char numStr[MAX_LINE_LENGTH];
        strcpy(numStr, argv[1]);
        char *numArg = numStr + 1;
        int numLines = atoi(numArg);

        for (i = 2; i < argc; i++) {
            if ((fd = open(argv[i], 0)) < 0) {
                printf("Error opening the file: %s\n", argv[i]);
                return 1;
            }
            printLastLines(fd, argv[i], numLines);
            close(fd);
        }
    } else {
        printf("Usage: %s [-x] <filename>\n", argv[0]);
    }

    return 0;
}
