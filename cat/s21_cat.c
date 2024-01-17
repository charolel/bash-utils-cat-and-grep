#include <getopt.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "../common/common.h"

typedef struct flags {
  int b;
  int e;
  int v;
  int n;
  int t;
  int s;
} flags;

struct option long_flags[] = {{"number-nonblank", no_argument, NULL, 'b'},
                              {"number", no_argument, NULL, 'n'},
                              {"squeeze-blank", no_argument, NULL, 's'},
                              {NULL, 0, NULL, 0}};

void choose_flag(FILE *file, struct option long_flags[], char *argv[], int argc,
                 int *err);
void cat_file(flags f, FILE *file, int argc, char *argv[]);
int char_is_enter(flags f, int c, char c_prev, char c_prevprev, int number);
int char_is_symbol(flags f, int c, char c_prev, int number);

int main(int argc, char *argv[]) {
  int err = 1;
  FILE *file = NULL;
  err = error(argc);

  if (err == 1) {
    // проверяем ввод на наличие filename
    file = check_file(file, argc, argv);

    // проверяем успешность открытия файла
    if (!file) {
      printf("ошибка открытия файла\n");
      err = 0;
    }

    if (err == 1) {
      choose_flag(file, long_flags, argv, argc, &err);
    }
  }
  return 0;
}

void choose_flag(FILE *file, struct option long_flags[], char *argv[], int argc,
                 int *err) {
  int flag, option_index = 0;
  flags f = {0};

  while ((flag = getopt_long(argc, argv, "bEenTtvs", long_flags,
                             &option_index)) != -1) {
    if (flag == 'E') f.e = 1;
    if (flag == 'T') f.t = 1;
    if (flag == 'b') f.b = 1;
    if (flag == 'e') {
      f.e = 1;
      f.v = 1;
    }
    if (flag == 'v') f.v = 1;
    if (flag == 'n') f.n = 1;
    if (flag == 't') {
      f.t = 1;
      f.v = 1;
    }
    if (flag == 's') f.s = 1;
    if (flag == '?') {
      printf("usage: cat [-benstv] [file ...]");
      *err = 0;
    }
  }

  if (*err == 1) {
    cat_file(f, file, argc, argv);
  }
}

void cat_file(flags f, FILE *file, int argc, char *argv[]) {
  char c_prev = '\n', c_prevprev;
  int c, number = 1;

  for (int i = 1; i < argc; i++) {
    file = open_file(file, i, argv);

    if (file != NULL) {
      if (f.b == 1 && f.n == 1) f.n = 0;  // приоритет f.b

      while ((c = fgetc(file)) != EOF) {
        if (c == '\n') {
          number = char_is_enter(f, c, c_prev, c_prevprev, number);
        } else {  // ЕСЛИ ЭТО ЗНАК
          number = char_is_symbol(f, c, c_prev, number);
        }
        c_prevprev = c_prev;
        c_prev = c;
      }

      fclose(file);
      number = 1;
    }
  }
}

int char_is_enter(flags f, int c, char c_prev, char c_prevprev, int number) {
  if (!(f.s == 1 && c_prevprev == '\n' && c_prev == '\n')) {
    // сжимает строку (не печатает enter и пр.)
    // } else {
    if (f.n == 1 && c_prev == '\n') printf("%6d\t", number++);
    if (f.e == 1) putchar('$');
    putchar(c);
  }
  return number;
}

int char_is_symbol(flags f, int c, char c_prev, int number) {
  if ((f.b == 1 && c_prev == '\n') || (f.n == 1 && c_prev == '\n'))
    printf("%6d\t", number++);

  if (f.t == 1 && c == '\t')
    printf("^I");
  else if (f.v == 1 && (c >= 0 && c <= 31 && c != '\t')) {
    c += '@';
    printf("^%c", c);
  } else if (f.v == 1 && c == 127)  // исключение "del"
    printf("^?");

  else if (f.v == 1 && (c >= 128 && c <= 159)) {
    c -= '@';
    printf("M-^%c", c);
  } else
    putchar(c);
  return number;
}