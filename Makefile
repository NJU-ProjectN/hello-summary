ISA ?= x86
ISAS = x86 riscv
SRC = src/$(ISA).md
BUILD_DIR = ./build
TMP_FILE = $(BUILD_DIR)/tmp.md
TARGET = $(BUILD_DIR)/$(ISA).html
PROJECT_ROOT = $(PWD)

$(TARGET): $(SRC) | $(BUILD_DIR)
	cat $^ src/version.md > $(TMP_FILE)
	markmap --offline --no-open -o $@ $(TMP_FILE)
	rm $(TMP_FILE)

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
