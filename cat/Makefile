CC = gcc
CFLAGS = -Wall -Werror -Wextra
CLANG = clang-format

# SRC := $(shell find . -name "*.c")

all: s21_cat

s21_cat: s21_cat.c ../common/common.c 
	gcc s21_cat.c ../common/common.c -o s21_cat $(CFLAGS)

clang:
	clang-format -i *.c
	clang-format -i ../common/*.c
	clang-format -i ../common/*.h
	clang-format -n *.c
	clang-format -n ../common/*.c
	clang-format -n ../common/*.h

test: all
	gcc ../common/test.c -o ../common/test $(CFLAGS)
	sh test_cat.sh
	rm -rf ../common/test

check:
	leaks --atExit -- ./s21_cat ../common/text.txt
	cppcheck --enable=all --suppress=missingIncludeSystem s21_cat.c

clean:
	rm -rf s21_cat

rebuild:
	make clean
	make all