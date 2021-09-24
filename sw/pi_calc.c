#include <stdint.h>
#include <math.h>

static void out_char(char c)
{
    volatile char *out = (volatile char *)(512 * 1024);
    *out = c;
}

void put_uint_ln(uint32_t x)
{
    char buf[20];
    int i;

    i = 0;
    while (x != 0) {
        buf[i++] = (x % 10) + '0';
        x /= 10;
    }


    while (i > 0) {
        out_char(buf[--i]);
    }

    out_char('\n');
}

// hack here, but we not use
int __errno;

int main()
{
    int i;

    const uint32_t a = 4000000000;
    uint32_t sum = a;

    volatile double x = 0.5;

    put_uint_ln(asin(x) * 6 * 1000000000);

    i = 3;
    while (1) {
        put_uint_ln(sum);

        sum -= a / i; i += 2;
        sum += a / i; i += 2;
    }
}
