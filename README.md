# An Introduction to Symbolic Execution

Material for an introduction to [symbolic execution], a [presentation at HO26][HO26].

<!-- TODO: Reference the media.ccc.de recording here. -->

This repository includes the files required to experiment with the live demonstration from the presentation.
Specifically, it includes the setup required to verify the [Base64] implementation provided by the [RIOT operating system][RIOT].
The original, unmodified source code is [available on GitHub][RIOT base64].

## Usage

Ideally, use this repository with [Guix](https://guix.gnu.org):

	$ guix time-machine -C channels.scm -- shell -m manifest.scm

Within the Guix shell run the following commands:

	$ make sim

Alternatively, you can also try to use [KLEE's Docker image]:

	$ docker run --rm  -v "$(pwd):/code" -it klee/klee

Within the container run:

	$ cd /code
	$ make sim

## Tweaking the Example

The example uses a fixed-size input buffer size, defaulting to 3 bytes.
This size can be configured through the `INPUT_SIZE` variable, for example:

	$ INPUT_SIZE=2 make -B

For an input size of 3 bytes, 625 execution paths should be discovered.
On my hardware, this takes around 2 minutes.
Depending on the size, the number of execution paths, and the time required to discover them will vary.

Further, it is possible to experiment with various KLEE optimizations to speed up this example.
A technique particularly beneficial to this example is [state merging].
To enable state merging, invoke `make` as follows:

	$ CFLAGS=-DKLEE_STATE_MERGING make -B

This will merge multiple execution paths of `getsymbol` / `getcode` into a single conjugated SMT-LIB expression.
Thereby, increasing SMT-LIB query complexity by reducing the number of execution paths.

To play around with other optimizations, refer to the [KLEE documentation].

## More Information

The following material provides additional background information:

* [Symbolic Execution for Software Testing: Three Decades Later](https://doi.org/10.1145/2408776.2408795)
* [A Survey of Symbolic Execution Techniques](https://doi.org/10.1145/3182657)

Further, the [KLEE documentation] includes additional practical examples:

1. [Testing a Regular Expression Library]
2. [Testing GNU coreutils]

[symbolic execution]: https://notes.8pit.net/notes/xg1j.html
[HO26]: https://talks.hackover.de/ho26/talk/CKUL8T/
[Guix]: https://guix.gnu.org
[KLEE's Docker image]: https://hub.docker.com/r/klee/klee
[Base64]: https://doi.org/10.17487/RFC4648
[RIOT]: https://riot-os.org
[RIOT base64]: https://github.com/RIOT-OS/RIOT/blob/2026.04/sys/base64/base64.c
[state merging]: https://arxiv.org/pdf/1610.00502#page=22
[KLEE documentation]: https://klee-se.org/releases/docs/v3.2/docs/
[Testing a Regular Expression Library]: https://klee-se.org/tutorials/testing-regex/
[Testing GNU coreutils]: https://klee-se.org/releases/docs/v3.2/tutorials/testing-coreutils/
