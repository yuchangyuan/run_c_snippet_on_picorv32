MEMORY {
    rom0(rx): ORIGIN = 0K,  LENGTH = 128K
    ram(rwx): ORIGIN = 256K, LENGTH = 256K
}

SECTIONS {
    .init : {
        . = ALIGN(4);
        start.o(*)
        . = ALIGN(4);
    } > rom0

    .text : {
        . = ALIGN(4);

        *(.text)
        *(.text*)
        . = ALIGN(4);

    } > rom0

    .rodata : {
        . = ALIGN(4);

        *(.rodata)
        *(.rodata*)
        *(.srodata)
        *(.srodata*)

        . = ALIGN(4);
    } > rom0

    .data : {
        . = ALIGN(4);
        _sdata = .;

        *(.data)
        *(.data*)
        *(.sdata)
        *(.sdata*)

        . = ALIGN(4);
        _edata = .;
    } > ram

    .bss : {
        . = ALIGN(4);
        _sbss = .;

        *(.bss)
        *(.bss*)
        *(.sbss)
        *(.sbss*)
        *(COMMON)

        . = ALIGN(4);
        _ebss = .;
    } > ram
}
