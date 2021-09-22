static void out_char(char c)
{
    volatile char *out = (volatile char *)(512 * 1024);
    *out = c;
}

void putStrLn(char *str)
{
    char *p = str;

    while (*p) {
        out_char(*p);
        p++;
    }
}

int main()
{
    putStrLn("Hello, world!");
}
