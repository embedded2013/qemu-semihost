all:
	@echo "Please execute ./test.sh"

clean:
	rm -f hello.elf

distclean: clean
	rm -rf qemu/build
