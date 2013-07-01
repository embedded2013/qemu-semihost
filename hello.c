#include <stdio.h>
#include <inttypes.h>

#define READ_COUNTER_ADDR 0x40050000

int32_t* read_counter = (int32_t*)READ_COUNTER_ADDR;
int main(void) {
  printf("This is a test program for QEMU counter device\n");
  printf("See http://github.com/krasin/qemu-counter for more details\n\n");
  printf("Let's check if the Read Counter device presented\n");
  for (int i = 0; i < 10; i++) {
    printf("The device has been accessed for %"PRId32" times!\n", *read_counter);
  }
  int32_t now = *read_counter;
  if (now == 0) {
    printf("ERROR - No Read Counter detected\n");
  } else if (now == 11) {
    printf("OK - Read Counter works as intended\n");
  } else {
    printf("ERROR - Something is wrong with Read Counter\n");
  }
  return 0;
}
