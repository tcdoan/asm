int power(int a, int b, int c) 
{
    int p = 1;
    for (;;)
    {
        if (c == 0)
        {
            break;
        }
        p = p * (a+b);
        c --;
    }
    return p;
}

int main()
{
    return power (2, 2, 3);
}