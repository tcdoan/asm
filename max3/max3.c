int find_max(int a[])
{
    int i = 0;
    int max = a[i];
    
    while (1) // same as for (;;)
    {
        if (a[i] == 0)
        {
            break;
        }

        if (a[i] > max)
        {
            max = a[i];
        }
        i++;
    }
    return max;
}

int main()
{
    int x[] = {1, 4, 6, 8, 7, 5, 15, 8, 4, 2, 5, 0};
    return find_max(x);
}