// Compute a^b
void power(int a, int b, int *c)
{
    *c = 1;
    for (;;)
    {
        if (b == 0)
        {
            break;
        }
        *c = (*c) * a;
        b--;
    }    
}

int main() 
{
    int x = 0;
    power(2,4, &x);
    return x;
}

