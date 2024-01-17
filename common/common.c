#include "common.h"

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int error(int argc) {
  // Проверяем наличие аргументов командной строки
  int err = 1;
  if (argc == 1) {
    printf("ай-яй! пиши: ./[комп. cat или grep] [-flag] [ФАЙЛn]\n");
    err = 0;
  }
  return err;
}

FILE *check_file(FILE *file, int argc, char *argv[]) {
  // проверяем, указаны ли вообще файлы
  FILE *file_prev = file;
  for (int i = 1; i < argc; i++) {
    file = open_file(file, i, argv);
    if (file != NULL) file_prev = file;
  }
  if (file == NULL) file = file_prev;
  return file;
}

FILE *open_file(FILE *file, int i, char *argv[]) {
  file = fopen(argv[i], "r");
  return file;
}