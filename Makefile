# target: help - List all options.
help:
	@egrep "^# target:" Makefile

# target: clean - Delete any generated boxes.
.PHONY : clean
clean:
	@rm -f *.box

# target: all - Generate all boxes.
all: precise64

# target: precise64 - Ubuntu 12.04 (Precise) 64-bit
precise64: packer_precise64_virtualbox.box

packer_precise64_virtualbox.box: precise64/standard.json
	packer build precise64/standard.json
