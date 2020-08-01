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

assert 3 "return 3;"
assert 21 "return 5+20-4;"
assert 47 'return 5+6*7;'
assert 15 'return 5*(9-6);'
assert 4 'return (3+5)/2;'
assert 12 'return +4*+3;'
assert 20 'return -(-4*5);'
assert 100 'return -20++120;'
assert 1 'return 1==1;'
assert 0 'return 0==1;'
assert 0 'return 1!=1;'
assert 1 'return 0!=1;'
assert 1 'return 1>0;'
assert 0 'return 0>1;'
assert 0 'return 0>0;'
assert 1 'return 1>=0;'
assert 1 'return 0>=0;'
assert 0 'return 0>=1;'
assert 0 'return 1<0;'
assert 1 'return 0<1;'
assert 0 'return 0<0;'
assert 0 'return 1<=0;'
assert 1 'return 0<=0;'
assert 1 'return 0<=1;'
assert 5 'a=2;return a+3;'
assert 10 'foo = 7;return foo+3;'
assert 13 'bar = 10;foo = 3;return foo+bar;'
assert 24 'foo = 3; foo=foo+3;return foo*4;'
assert 100 'fffff = 10; abcd = 3; ieoeeeeeee=30; dfsd = abcd*ieoeeeeeee;return fffff+dfsd;'
assert 250 'fffff = 10; abcd = 5; ieoeeeeeee=30; abcd=8;dfsd = abcd*ieoeeeeeee;return fffff+dfsd;'

echo OK