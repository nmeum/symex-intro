INPUT_SIZE ?= 3
CFLAGS_SIZE = -DINPUT_SIZE=$(INPUT_SIZE)

CLANG  ?= clang
CFLAGS += -std=c99 -g -O0 -Xclang -disable-O0-optnone $(CFLAGS_SIZE)

base64.ll: base64.c
	$(CLANG) -emit-llvm -S -c -o $@ $< $(CFLAGS)
base64.c: base64.h

sim: base64.ll
	klee --solver-backend=z3 \
		--search=dfs \
		--exit-on-error \
		--use-merge \
		--libc=klee \
		--write-smt2s \
		--use-query-log=all:smt2 \
		$<

clean:
	rm -rf klee-* base64.ll

.PHONY: sim clean
