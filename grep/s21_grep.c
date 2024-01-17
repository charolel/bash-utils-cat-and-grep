#include <getopt.h>
#include <regex.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "../common/common.h"

#define MAX 9999

typedef struct flags {
  int e;
  int i;
  int v;
  int c;
  int l;
  int n;
  int h;
  int s;
  int f;
  int o;
} flags;

typedef struct numbers {
  int res;
  int num;
  int i;
  int line_num;
  int file_numbers;
  int length;
  char* pattern_for_o;
} numbers;

void choose_flag(int argc, char* argv[], int* err);
int* f_patterns(char* file_pattern, char* pattern, int* err);
void grep(flags f, numbers n, char* pattern, int argc, char* argv[]);
numbers output_string(flags f, numbers n, regex_t preg, size_t nmatch,
                      regmatch_t* pmatch, char* string, char** argv);
void f_o_multiple_matches(numbers n, regex_t preg, char* string, size_t nmatch,
                          regmatch_t* pmatch);

int main(int argc, char* argv[]) {
  int err = 1;
  err = error(argc);
  if (err == 1) {
    choose_flag(argc, argv, &err);
  }
  return 0;
}

void choose_flag(int argc, char* argv[], int* err) {
  int flag = 0;
  char pattern[MAX] = {0};
  char file_pattern[MAX] = {0};
  flags f = {0};

  while ((flag = getopt(argc, argv, "e:ivclnhsf:o")) != -1) {
    if (flag == 'e') {
      f.e = 1;
      sprintf(pattern, optarg);
    }
    if (flag == 'i') f.i = 1;
    if (flag == 'v') f.v = 1;
    if (flag == 'c') f.c = 1;
    if (flag == 'l') f.l = 1;
    if (flag == 'n') f.n = 1;
    if (flag == 'h') f.h = 1;
    if (flag == 's') f.s = 1;
    if (flag == 'f') {
      f.f = 1;
      sprintf(file_pattern, optarg);
      err = f_patterns(file_pattern, pattern, err);
    }
    if (flag == 'o') f.o = 1;
    if (flag == '?') {
      printf(
          "usage: grep [-ivclnhso] [-e pattern] [-f file] [pattern] [file "
          "...]");
      *err = 0;
    }
  }

  if (*err == 1) {
    if (!f.f && !f.e) sprintf(pattern, argv[optind]);
    numbers n = {0};

    if (!f.f && !f.e && (argc - optind - 1 > 0)) {
      n.file_numbers = argc - optind - 1;
      n.i = optind + 1;
    } else if ((f.f || f.e) && (argc - optind > 0)) {
      n.file_numbers = argc - optind;
      n.i = optind;
    }

    grep(f, n, pattern, argc, argv);
  }
}

int* f_patterns(char* file_pattern, char* pattern, int* err) {
  FILE* file_patt = fopen(file_pattern, "r");
  if (file_patt != NULL) {
    int i = 0;
    char c;
    while ((c = fgetc(file_patt)) != EOF) {
      if (c == '\n' || c == '\r') {
        pattern[i++] = '|';
      } else {
        pattern[i++] = c;
      }
    }
    fclose(file_patt);
  } else {
    *err = 0;
    printf("error reading file_pattern");
  }
  return err;
}

void grep(flags f, numbers n, char* pattern, int argc, char* argv[]) {
  FILE* file = NULL;
  char string[MAX] = {0};
  int cflags = REG_EXTENDED;

  regex_t preg;
  size_t nmatch = 1;
  regmatch_t pmatch[1];

  if (f.o && f.v) f.o = 0;             // WARNING
  if (f.o) n.pattern_for_o = pattern;  // ---?
  if (f.i == 1) cflags = REG_ICASE | REG_EXTENDED;

  if ((n.res = regcomp(&preg, pattern, cflags)) != 0)
    printf("regcomp() error: (%d)\n", n.res);

  else {
    if (n.file_numbers > 0) {
      for (; n.i < argc; n.i++) {  // Werror ругался на n.i в начале о.О
        file = open_file(file, n.i, argv);
        if (file != NULL) {
          while (fgets(string, MAX, file) != NULL) {
            n.line_num += 1;
            n = output_string(f, n, preg, nmatch, pmatch, string, argv);
          }

          if ((n.res == 0 && !f.l && !f.v && !f.c && !f.o) ||
              (n.res == REG_NOMATCH && f.v)) {
            char buff_EOF[MAX] = {0};  // ---
            fgets(buff_EOF, MAX, file);
            if (buff_EOF[0] == '\0') printf("\n");
          }

          if (f.c) {
            if (!f.h && n.file_numbers > 1) printf("%s:", argv[n.i]);
            if (f.l && n.num > 0) n.num = 1;
            printf("%d\n", n.num);
          }

          if (f.l && n.num > 0) printf("%s\n", argv[n.i]);
          fclose(file);
        } else if (!f.s)
          printf("error reading text file\n");
        n.num = 0;
        n.line_num = 0;
      }
    } else {
      while (fgets(string, MAX, stdin) != NULL) {  // print ctrl + D to exit!!
        output_string(f, n, preg, nmatch, pmatch, string, argv);
      }
    }
  }
  regfree(&preg);
}

numbers output_string(flags f, numbers n, regex_t preg, size_t nmatch,
                      regmatch_t* pmatch, char* string, char** argv) {
  if ((n.res = regexec(&preg, string, nmatch, pmatch, 0)) == 0) {
    n.num += 1;

    if (!f.c && !f.v && !f.l) {
      if (n.file_numbers > 1 && !f.h) printf("%s:", argv[n.i]);

      if (f.n) printf("%d:", n.line_num);

      if (f.o) {
        f_o_multiple_matches(n, preg, string, nmatch, pmatch);
      }

      for (int j = 0; j < (n.length = strlen(string)); j++) {
        if (!f.o && j >= pmatch[0].rm_so && j < pmatch[0].rm_eo)
          printf("%c", string[j]);
        // для НЕ теста можно написать \033[1;31m%c\033[0m
        else if (!f.o)
          printf("%c", string[j]);
      }
    }
    if ((n.file_numbers == 0 || f.o) && !(f.o && f.l))
      printf("\n");  // мб проблемы с f.o
  } else if (n.res == REG_NOMATCH && f.v) {
    if (n.file_numbers > 1 && !f.h) printf("%s:", argv[n.i]);
    if (f.n) printf("%d:", n.line_num);
    printf("%s", string);
  }
  return n;
}

void f_o_multiple_matches(numbers n, regex_t preg, char* string, size_t nmatch,
                          regmatch_t* pmatch) {
  char regs[MAX] = {0};
  int i = 0, j = 0, end;

  for (j = 0; j < (n.length = strlen(string)); j++) {
    if (j >= pmatch[0].rm_so && j < pmatch[0].rm_eo) regs[i++] = string[j];
  }
  regs[i++] = '\n';

  string += pmatch[0].rm_eo;
  while ((n.res = regexec(&preg, string, nmatch, pmatch, 0)) == 0) {
    for (j = 0; j < pmatch[0].rm_eo; j++) {
      if (j >= pmatch[0].rm_so && j < pmatch[0].rm_eo) {
        regs[i++] = string[j];
      }
    }
    regs[i++] = '\n';
    string += pmatch[0].rm_eo;
  }

  end = strlen(regs) - 1;
  if (regs[end] == '\n') regs[end] = '\0';

  printf("%s", regs);
}
