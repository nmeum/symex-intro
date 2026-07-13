#include <stdbool.h>
#include <klee/klee.h>

int myfunc(bool a, bool b) {
  int x = 23, y = 42;

  if (a)
    x = 0;
  else
    y = 0;

  if (b)
    return 5 / x;
  else
    return 5 / y;
}

int main(void) {
  bool a, b;

  klee_make_symbolic(&a, sizeof(a), "a");
  klee_make_symbolic(&b, sizeof(b), "b");

  myfunc(a, b);
  return 0;
}
