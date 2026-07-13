(use-modules (guix packages)
             (gnu packages base)
             (gnu packages check)
             (gnu packages linux)
             (gnu packages llvm))

(packages->manifest
  (list
    coreutils
    clang-16
    llvm-16
    gnu-make
    klee))
