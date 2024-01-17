#!/bin/bash

TEXT="../common/text.txt"
MY_OUTPUT="my_cat.txt"
ORI_OUTPUT="ori_cat.txt"
COMPARE="compare_cat.txt"
TEST="../common/test"

echo "\033[3;36mdid you compile my cat?"
echo "o-o-okey, start testing...\033[0m"
echo "flags: -b -n"
./s21_cat -b -n $TEXT > $MY_OUTPUT
cat -b -n $TEXT > $ORI_OUTPUT
shasum $MY_OUTPUT $ORI_OUTPUT > $COMPARE
$TEST $COMPARE

echo "flags: -b -e... like my life"
./s21_cat -b -e $TEXT > $MY_OUTPUT
cat -b -e $TEXT > $ORI_OUTPUT
shasum $MY_OUTPUT $ORI_OUTPUT > $COMPARE
$TEST $COMPARE

echo "flag: -v (with ascii)"
./s21_cat -v ../common/ascii_test.txt > $MY_OUTPUT
cat -v ../common/ascii_test.txt > $ORI_OUTPUT
shasum $MY_OUTPUT $ORI_OUTPUT > $COMPARE
$TEST $COMPARE

echo "flags: -n -t -s"
./s21_cat -n -t -s $TEXT > $MY_OUTPUT
cat -n -t -s $TEXT > $ORI_OUTPUT
shasum $MY_OUTPUT $ORI_OUTPUT > $COMPARE
$TEST $COMPARE

echo "flag: -T"
./s21_cat -T -v $TEXT > $MY_OUTPUT
cat -t $TEXT > $ORI_OUTPUT
shasum $MY_OUTPUT $ORI_OUTPUT > $COMPARE
$TEST $COMPARE

echo "flag: -E"
./s21_cat -E -v $TEXT > $MY_OUTPUT
cat -e $TEXT > $ORI_OUTPUT
shasum $MY_OUTPUT $ORI_OUTPUT > $COMPARE
$TEST $COMPARE

echo "flag: --number-nonblank"
./s21_cat --number-nonblank $TEXT > $MY_OUTPUT
cat -b $TEXT > $ORI_OUTPUT
shasum $MY_OUTPUT $ORI_OUTPUT > $COMPARE
$TEST $COMPARE

echo "flag: --number"
./s21_cat --number $TEXT > $MY_OUTPUT
cat -n $TEXT > $ORI_OUTPUT
shasum $MY_OUTPUT $ORI_OUTPUT > $COMPARE
$TEST $COMPARE

echo "flag: --squeeze-blank"
./s21_cat --squeeze-blank $TEXT > $MY_OUTPUT
cat -s $TEXT > $ORI_OUTPUT
shasum $MY_OUTPUT $ORI_OUTPUT > $COMPARE
$TEST $COMPARE

rm -rf *.txt