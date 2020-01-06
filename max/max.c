
static int a[] = {1, 4, 3, 7, 9, 10, 6, 8, 9, 0};

int main()
{    
    int i = 0;
    int max = a[i];
    for(;;)
    {
        if (a[i] == 0)
        {
            break;
        }
        if ( a[i] > max )
        {
            max = a[i];
        }
        i++;
    }
    return max;
}
