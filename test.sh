#!/bin/bash
assert() {
  expected="$1"
  input="$2"

  ./9cc "$input" > tmp.s
  cc -o tmp tmp.s
  ./tmp
  actual="$?"

  if [ "$actual" = "$expected" ]; then
    echo "$input => $actual"
  else
    echo "$input => $expected expected, but got $actual"
    exit 1
  fi
}

assert 21 "5+20-4;"
assert 41 " 12 + 34 - 5 ;"
assert 47 '5+6*7;'
assert 15 '5*(9-6);'
assert 4 '(3+5)/2;'
assert 12 '+4*+3;'
assert 20 '-(-4*5);'
assert 100 '-20++120;'
assert 1 '1==1;'
assert 0 '0==1;'
assert 0 '1!=1;'
assert 1 '0!=1;'
assert 1 '1>0;'
assert 0 '0>1;'
assert 0 '0>0;'
assert 1 '1>=0;'
assert 1 '0>=0;'
assert 0 '0>=1;'
assert 0 '1<0;'
assert 1 '0<1;'
assert 0 '0<0;'
assert 0 '1<=0;'
assert 1 '0<=0;'
assert 1 '0<=1;'
assert 5 'a=2;a+3;'

echo OK