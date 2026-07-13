CLANG  ?= clang
CFLAGS += -std=c99 -g -O0 -Xclang -disable-O0-optnone

all: constraints.bc div-by-zero.bc
%.bc: %.c
	$(CLANG) -emit-llvm -c -o $@ $< $(CPPFLAGS) $(CFLAGS)

sim: all
	klee --solver-backend=z3 \
		--libc=uclibc \
		--posix-runtime \
		--check-div-zero=true \
		$(KLEEFLAGS)

clean:
	rm -rf klee-* constraints.bc div-by-zero.bc

.PHONY: all sim clean
