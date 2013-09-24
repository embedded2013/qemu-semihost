#include "hw/arm/arm.h"
#include "qemu-common.h"
#include "hw/sysbus.h"

#define READ_COUNTER_ADDR 0x40050000
#define READ_COUNTER_SIZE 4

typedef struct {
  SysBusDevice busdev;
  MemoryRegion iomem;
  uint32_t count;
} ReadCounter;

static uint64_t read_counter_read(void *opaque, hwaddr offset, unsigned size)
{
  ReadCounter *cnt = (ReadCounter *) opaque;
  cnt->count++;
  return cnt->count;
}

static void read_counter_write(void *opaque, hwaddr offset,
                               uint64_t value, unsigned size)
{
  hw_error("read_counter: Attempted to write to a readonly device\n");
}

static const MemoryRegionOps read_counter_ops = {
  .read = read_counter_read,
  .write = read_counter_write,
  .endianness = DEVICE_NATIVE_ENDIAN
};

static int read_counter_init(SysBusDevice *dev)
{
  ReadCounter *cnt = FROM_SYSBUS(ReadCounter, dev);
  cnt->count = 0;

  memory_region_init_io(&cnt->iomem,
                        &read_counter_ops,
                        cnt,
                        "read_counter",
                        READ_COUNTER_SIZE);
  sysbus_init_mmio(dev, &cnt->iomem);
  sysbus_mmio_map(dev, 0, READ_COUNTER_ADDR);
  return 0;
}

static void read_counter_class_init(ObjectClass *klass, void *data)
{
  DeviceClass *dc = DEVICE_CLASS(klass);
  SysBusDeviceClass *k = SYS_BUS_DEVICE_CLASS(klass);

  k->init = read_counter_init;
  dc->desc = "Counts the number of read requests";
}

static TypeInfo read_counter_info = {
  .name = "read_counter",
  .parent = TYPE_SYS_BUS_DEVICE,
  .instance_size = sizeof(ReadCounter),
  .class_init = read_counter_class_init,
};

static void read_counter_register_types(void)
{
  type_register_static(&read_counter_info);
}

type_init(read_counter_register_types)
