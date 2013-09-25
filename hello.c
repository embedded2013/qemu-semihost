#include <stdio.h>
#include <fcntl.h>
#include <unistd.h>
#include <inttypes.h>

#define READ_COUNTER_ADDR 0x40050000

#define COUNTER_TIMES 5
int32_t *read_counter = (int32_t *) READ_COUNTER_ADDR;
int main(void)
{
	/* test QEMU counter device */
	for (int i = 0; i < COUNTER_TIMES; i++) {
		printf("The device has been accessed for %"PRId32" times!\n", *read_counter);
	}
	int32_t now = *read_counter;
	if (now == 0) {
		printf("ERROR - No Read Counter detected\n");
	}
	else if (now == COUNTER_TIMES + 1) {
		printf("OK - Read Counter works as intended\n");
	}
	else {
		printf("ERROR - Something is wrong with Read Counter\n");
	}

	/* test semihost call: open, read, close */
	{
		int fd = open("/etc/hosts", O_RDONLY);
		char buf[16] = { 0, };
		int bytesRead = read(fd, buf, 9);
		printf("read from /etc/hosts: %s\n", buf);
		close(fd);
	}

	return 0;
}
