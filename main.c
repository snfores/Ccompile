#include "9cc.h"

int main(int argc, char **argv) {
  if (argc != 2) {
    error_at(token->str, "引数の個数が正しくありません");
    return 1;
  }

  // トークナイズする
  user_input = argv[1];
  token = tokenize();
  program();

  codegen();

  return 0;
}
