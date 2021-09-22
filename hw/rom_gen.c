#include <stdio.h>
#include <stdint.h>
#include <stdbool.h>
#include <stdlib.h>

bool get_u32(uint32_t *res)
{
    int i;

    *res = 0;

    for (i = 0; i < 4; ++i) {
        int c = getchar();

        if (c < 0) {
            return (i > 0);
        }
        else {
            *res += ((uint32_t)c) << (i * 8);
        }
    }

    return true;
}

int main(int argc, char **argv)
{
    uint32_t word;
    int addr;

    if (argc != 2) {
        fprintf(stderr, "please specify rom name\n");
        exit(-1);
    }

    printf("module %s(\n"
           "input clk,\n"
           "output reg [31:0] q,\n"
           "input [29:0] addr);\n",
           argv[1]);

    printf("always @(posedge clk) begin\n");
    printf("case (addr)\n");

    addr = 0;
    while (get_u32(&word)) {
        printf("    29'h%8x: q <= 32'h%08x;\n",
               addr++, word);
    }

    printf("    default:      q <= 32'd0;\n"
           "endcase\n");
    printf("end\n");
    printf("endmodule\n");

    return 0;
}
