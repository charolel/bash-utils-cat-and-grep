#include <stdio.h>
#include <string.h>

void testing(FILE *file);

int main(int argc, char *argv[]) {
  FILE *file;
  char file_path[30] = {"./"};

  if (argc > 1) {
    strcat(file_path, argv[1]);
    file = fopen(file_path, "r");
    if (file != NULL) {
      testing(file);
    } else
      printf("ERROR\n");
    fclose(file);
  } else
    printf("error\n");

  return 0;
}

void testing(FILE *file) {
  int res = 1, max = 65, max_save = 42;
  char buf_my[65] = {0};
  char sha_my[42] = {0};

  char buf_ori[65] = {0};
  char sha_ori[42] = {0};

  fgets(buf_my, max, file);
  for (int i = 0; i < max_save - 1; i++) {
    sha_my[i] = buf_my[i];
  }
  // sha_my[42] = '\0';
  // вызывает утечку памяти, вылетаю за массив

  fgets(buf_ori, max, file);
  for (int i = 0; i < max_save - 1; i++) {
    sha_ori[i] = buf_ori[i];
  }
  // sha_ori[42] = '\0';

  res = strcmp(sha_my, sha_ori);
  // printf("there strings\nmy:%s,\nori:%s\n", buf_my, buf_ori);
  // printf("my:%s,\nori:%s\n", sha_my, sha_ori);

  if (res == 0)
    printf("\033[1;32mУспех\n\033[0m");
  else
    printf("\033[1;31mНеудача\n\033[0m");
}