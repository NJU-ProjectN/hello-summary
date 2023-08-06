ISA ?= x86
ISAS = x86 riscv
SRC = src/$(ISA).md
BUILD_DIR = ./build
TARGET = $(BUILD_DIR)/$(ISA).html
PROJECT_ROOT = $(PWD)

$(TARGET): $(SRC) | $(BUILD_DIR)
	markmap --offline --no-open -o $@ $^

$(BUILD_DIR):
	mkdir -p $@

all:
	for f in $(ISAS); do \
		$(MAKE) ISA=`basename $$f .md`; \
	done

daemon:
	while true; do \
		inotifywait -e modify $(SRC); \
		make; \
		done

clean:
	rm -rf $(BUILD_DIR)
