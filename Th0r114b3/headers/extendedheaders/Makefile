ifeq ($(OS),Windows_NT) 
	detected_OS := Windows
else
    detected_OS := $(shell sh -c 'uname 2>/dev/null || echo Unknown')
endif

all: clean patchfinder64

patchfinder64:
	@mkdir -p bin
ifeq ($(detected_OS),Darwin)
		gcc -DHAVE_MAIN patchfinder64.c -o ./bin/patchfinder64
else
		gcc -DHAVE_MAIN -DNOT_DARWIN patchfinder64.c -o ./bin/patchfinder64
endif

clean:
	rm -f bin/patchfinder64
