#!/bin/bash

TEXT1="../common/text1.txt"
TEXT2="../common/text2.txt"
PATTERN="../common/pattern.txt"
MY_OUTPUT="my_grep.txt"
ORI_OUTPUT="ori_grep.txt"
COMPARE="compare_grep.txt"
TEST="../common/test"

echo "\033[3;36mdid you compile my grep?"
echo "o-o-okey, start testing...\033[0m"


echo "\033[3;36mtesting 1 file\033[0m"

echo "w/o flags"
./s21_grep opera $TEXT1 > $MY_OUTPUT
grep opera $TEXT1 > $ORI_OUTPUT
shasum $MY_OUTPUT $ORI_OUTPUT > $COMPARE
$TEST $COMPARE

echo "flag: -e"
./s21_grep -e --line $TEXT2 > $MY_OUTPUT
grep -e --line $TEXT2 > $ORI_OUTPUT
shasum $MY_OUTPUT $ORI_OUTPUT > $COMPARE
$TEST $COMPARE

echo "flag: -i"
./s21_grep -i lInE $TEXT1 > $MY_OUTPUT
grep -i lInE $TEXT1 > $ORI_OUTPUT
shasum $MY_OUTPUT $ORI_OUTPUT > $COMPARE
$TEST $COMPARE

echo "flag: -v"
./s21_grep -v line $TEXT1 > $MY_OUTPUT
grep -v line $TEXT1 > $ORI_OUTPUT
shasum $MY_OUTPUT $ORI_OUTPUT > $COMPARE
$TEST $COMPARE

echo "flag: -c"
./s21_grep -c line $TEXT1 > $MY_OUTPUT
grep -c line $TEXT1 > $ORI_OUTPUT
shasum $MY_OUTPUT $ORI_OUTPUT > $COMPARE
$TEST $COMPARE

echo "flag: -l"
./s21_grep -l line $TEXT1 > $MY_OUTPUT
grep -l line $TEXT1 > $ORI_OUTPUT
shasum $MY_OUTPUT $ORI_OUTPUT > $COMPARE
$TEST $COMPARE

echo "flag: -n"
./s21_grep -n line $TEXT1 > $MY_OUTPUT
grep -n line $TEXT1 > $ORI_OUTPUT
shasum $MY_OUTPUT $ORI_OUTPUT > $COMPARE
$TEST $COMPARE

echo "flag: -h"
./s21_grep -h line $TEXT1 > $MY_OUTPUT
grep -h line $TEXT1 > $ORI_OUTPUT
shasum $MY_OUTPUT $ORI_OUTPUT > $COMPARE
$TEST $COMPARE

echo "flag: -s"
./s21_grep -s line $TEXT1 > $MY_OUTPUT
grep -s line $TEXT1 > $ORI_OUTPUT
shasum $MY_OUTPUT $ORI_OUTPUT > $COMPARE
$TEST $COMPARE

echo "flag: -f file"
./s21_grep -f $PATTERN $TEXT1 > $MY_OUTPUT
grep -f $PATTERN $TEXT1 > $ORI_OUTPUT
shasum $MY_OUTPUT $ORI_OUTPUT > $COMPARE
$TEST $COMPARE

echo "flag: -o"
./s21_grep -o line $TEXT1 > $MY_OUTPUT
grep -o line $TEXT1 > $ORI_OUTPUT
shasum $MY_OUTPUT $ORI_OUTPUT > $COMPARE
$TEST $COMPARE

echo "flags: -e -i"
./s21_grep -i -e line $TEXT1 > $MY_OUTPUT
grep -i -e line $TEXT1 > $ORI_OUTPUT
shasum $MY_OUTPUT $ORI_OUTPUT > $COMPARE
$TEST $COMPARE

echo "flags: -o -v"
./s21_grep -v -o line $TEXT1 > $MY_OUTPUT
grep -v -o line $TEXT1 > $ORI_OUTPUT
shasum $MY_OUTPUT $ORI_OUTPUT > $COMPARE
$TEST $COMPARE

echo "flags: -c -l"
./s21_grep -c -l line $TEXT1 > $MY_OUTPUT
grep -c -l line $TEXT1 > $ORI_OUTPUT
shasum $MY_OUTPUT $ORI_OUTPUT > $COMPARE
$TEST $COMPARE

echo "flags: -o -l"
./s21_grep -o -l line $TEXT1 > $MY_OUTPUT
grep -o -l line $TEXT1 > $ORI_OUTPUT
shasum $MY_OUTPUT $ORI_OUTPUT > $COMPARE
$TEST $COMPARE

echo "flags: -n -c"
./s21_grep -n -c line $TEXT1 > $MY_OUTPUT
grep -n -c line $TEXT1 > $ORI_OUTPUT
shasum $MY_OUTPUT $ORI_OUTPUT > $COMPARE
$TEST $COMPARE

echo "flags: -n -l"
./s21_grep -n -l line $TEXT1 > $MY_OUTPUT
grep -n -l line $TEXT1 > $ORI_OUTPUT
shasum $MY_OUTPUT $ORI_OUTPUT > $COMPARE
$TEST $COMPARE

echo "flags: -e -f"
./s21_grep -e -f $TEXT1 > $MY_OUTPUT
grep -e -f $TEXT1 > $ORI_OUTPUT
shasum $MY_OUTPUT $ORI_OUTPUT > $COMPARE
$TEST $COMPARE

echo "flags: -v -n"
./s21_grep -v -n line $TEXT1 > $MY_OUTPUT
grep -v -n line $TEXT1 > $ORI_OUTPUT
shasum $MY_OUTPUT $ORI_OUTPUT > $COMPARE
$TEST $COMPARE

echo "flags: -n -o"
./s21_grep -n -o line $TEXT1 > $MY_OUTPUT
grep -n -o line $TEXT1 > $ORI_OUTPUT
shasum $MY_OUTPUT $ORI_OUTPUT > $COMPARE
$TEST $COMPARE


echo "\033[3;36mtesting 2 file\033[0m"

echo "w/o flags"
./s21_grep opera $TEXT1 $TEXT2 > $MY_OUTPUT
grep opera $TEXT1 $TEXT2 > $ORI_OUTPUT
shasum $MY_OUTPUT $ORI_OUTPUT > $COMPARE
$TEST $COMPARE

echo "flag: -e"
./s21_grep -e line $TEXT1 $TEXT2 > $MY_OUTPUT
grep -e line $TEXT1 $TEXT2 > $ORI_OUTPUT
shasum $MY_OUTPUT $ORI_OUTPUT > $COMPARE
$TEST $COMPARE

echo "flag: -i"
./s21_grep -i lInE $TEXT1 $TEXT2 > $MY_OUTPUT
grep -i lInE $TEXT1 $TEXT2 > $ORI_OUTPUT
shasum $MY_OUTPUT $ORI_OUTPUT > $COMPARE
$TEST $COMPARE

echo "flag: -v"
./s21_grep -v line $TEXT1 $TEXT2 > $MY_OUTPUT
grep -v line $TEXT1 $TEXT2 > $ORI_OUTPUT
shasum $MY_OUTPUT $ORI_OUTPUT > $COMPARE
$TEST $COMPARE

echo "flag: -c"
./s21_grep -c line $TEXT1 $TEXT2 > $MY_OUTPUT
grep -c line $TEXT1 $TEXT2 > $ORI_OUTPUT
shasum $MY_OUTPUT $ORI_OUTPUT > $COMPARE
$TEST $COMPARE

echo "flag: -l"
./s21_grep -l line $TEXT1 $TEXT2 > $MY_OUTPUT
grep -l line $TEXT1 $TEXT2 > $ORI_OUTPUT
shasum $MY_OUTPUT $ORI_OUTPUT > $COMPARE
$TEST $COMPARE

echo "flag: -n"
./s21_grep -n line $TEXT1 $TEXT2 > $MY_OUTPUT
grep -n line $TEXT1 $TEXT2 > $ORI_OUTPUT
shasum $MY_OUTPUT $ORI_OUTPUT > $COMPARE
$TEST $COMPARE

echo "flag: -h"
./s21_grep -h line $TEXT1 $TEXT2 > $MY_OUTPUT
grep -h line $TEXT1 $TEXT2 > $ORI_OUTPUT
shasum $MY_OUTPUT $ORI_OUTPUT > $COMPARE
$TEST $COMPARE

echo "flag: -s"
./s21_grep -s line $TEXT1 $TEXT2 > $MY_OUTPUT
grep -s line $TEXT1 $TEXT2 > $ORI_OUTPUT
shasum $MY_OUTPUT $ORI_OUTPUT > $COMPARE
$TEST $COMPARE

echo "flag: -f file"
./s21_grep -f $PATTERN $TEXT1 $TEXT2 > $MY_OUTPUT
grep -f $PATTERN $TEXT1 $TEXT2 > $ORI_OUTPUT
shasum $MY_OUTPUT $ORI_OUTPUT > $COMPARE
$TEST $COMPARE

echo "flag: -o"
./s21_grep -o line $TEXT1 $TEXT2 > $MY_OUTPUT
grep -o line $TEXT1 $TEXT2 > $ORI_OUTPUT
shasum $MY_OUTPUT $ORI_OUTPUT > $COMPARE
$TEST $COMPARE

echo "flags: -e -i"
./s21_grep -i -e line $TEXT1 $TEXT2 > $MY_OUTPUT
grep -i -e line $TEXT1 $TEXT2 > $ORI_OUTPUT
shasum $MY_OUTPUT $ORI_OUTPUT > $COMPARE
$TEST $COMPARE

echo "flags: -o -v"
./s21_grep -v -o line $TEXT1 $TEXT2 > $MY_OUTPUT
grep -v -o line $TEXT1 $TEXT2 > $ORI_OUTPUT
shasum $MY_OUTPUT $ORI_OUTPUT > $COMPARE
$TEST $COMPARE

echo "flags: -c -l"
./s21_grep -c -l line $TEXT1 $TEXT2 > $MY_OUTPUT
grep -c -l line $TEXT1 $TEXT2 > $ORI_OUTPUT
shasum $MY_OUTPUT $ORI_OUTPUT > $COMPARE
$TEST $COMPARE

echo "flags: -o -l"
./s21_grep -o -l line $TEXT1 $TEXT2 > $MY_OUTPUT
grep -o -l line $TEXT1 $TEXT2 > $ORI_OUTPUT
shasum $MY_OUTPUT $ORI_OUTPUT > $COMPARE
$TEST $COMPARE

echo "flags: -n -c"
./s21_grep -n -c line $TEXT1 $TEXT2 > $MY_OUTPUT
grep -n -c line $TEXT1 $TEXT2 > $ORI_OUTPUT
shasum $MY_OUTPUT $ORI_OUTPUT > $COMPARE
$TEST $COMPARE

echo "flags: -n -l"
./s21_grep -n -l line $TEXT1 $TEXT2 > $MY_OUTPUT
grep -n -l line $TEXT1 $TEXT2 > $ORI_OUTPUT
shasum $MY_OUTPUT $ORI_OUTPUT > $COMPARE
$TEST $COMPARE

echo "flags: -e -f"
./s21_grep -e -f $TEXT1 $TEXT2 > $MY_OUTPUT
grep -e -f $TEXT1 $TEXT2 > $ORI_OUTPUT
shasum $MY_OUTPUT $ORI_OUTPUT > $COMPARE
$TEST $COMPARE

echo "flags: -v -n"
./s21_grep -v -n line $TEXT1 $TEXT2 > $MY_OUTPUT
grep -v -n line $TEXT1 $TEXT2 > $ORI_OUTPUT
shasum $MY_OUTPUT $ORI_OUTPUT > $COMPARE
$TEST $COMPARE

echo "flags: -n -o"
./s21_grep -n -o line $TEXT1 $TEXT2 > $MY_OUTPUT
grep -n -o line $TEXT1 $TEXT2 > $ORI_OUTPUT
shasum $MY_OUTPUT $ORI_OUTPUT > $COMPARE
$TEST $COMPARE

rm -rf *.txt

# echo "w/o file"
# ./s21_grep g