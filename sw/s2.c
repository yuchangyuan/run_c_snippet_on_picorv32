void __attribute__ ((noinline)) out_char(char c)
{
    // place holder here
    // to be replace by actual IO code
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
