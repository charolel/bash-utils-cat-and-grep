CC = gcc
CFLAGS = -Wall -Werror -Wextra
CLANG = clang-format

# SRC := $(shell find . -name "*.c")

all: s21_grep

s21_grep: s21_grep.c ../common/common.c 
	gcc s21_grep.c ../common/common.c -o s21_grep $(CFLAGS)

clang:
	clang-format -i *.c
	clang-format -i ../common/*.c
	clang-format -i ../common/*.h
	clang-format -n *.c
	clang-format -n ../common/*.c
	clang-format -n ../common/*.h

test: all
	gcc ../common/test.c -o ../common/test $(CFLAGS)
	sh test_grep.sh
	rm -rf ../common/test

check:
	leaks --atExit -- ./s21_grep opera ../common/text1.txt
	cppcheck --enable=all --suppress=missingIncludeSystem ./s21_grep.c

clean:
	rm -rf s21_grep

rebuild:
	make clean
	make all