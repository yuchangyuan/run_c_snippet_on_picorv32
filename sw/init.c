#include <stdint.h>

extern int32_t _sdata;
extern int32_t _edata;
extern int32_t _sbss;
extern int32_t _ebss;

void init()
{
    // init .data
    int32_t *src = (int32_t *)(128*1024);
    int32_t *dst = &_sdata;

    while (dst < &_edata) {
        *(dst++) = *(src++);
    }

    // init .bss
    int32_t *p = &_sbss;
    while (p < &_ebss) {
        *(p++) = 0;
    }
}
