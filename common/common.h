#ifndef COMMON
#define COMMON

#include <stdio.h>

// void just_do_it(int argc, char *argv[]);
int error(int argc);
FILE *check_file(FILE *file, int argc, char *argv[]);
FILE *open_file(FILE *file, int i, char *argv[]);

#endif