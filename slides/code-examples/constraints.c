#include <assert.h>
#include <limits.h>
#include <klee/klee.h>

void somefunc(int n) {
  if (n < 0)
    n = n * -1;
  else
    n = 1;

  if (n <= 0) // && n != INT_MIN
    assert(0 && "reachable");
}

int main(void) {
  int n;
  klee_make_symbolic(&n, sizeof(n), "n");
  somefunc(n);
  return 0;
}
