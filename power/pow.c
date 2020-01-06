int power(int a, int b)
{
    int answer = 1;
    for (;;) 
    {
        if (b == 0) 
        {
            break;
        }
        answer *= a;
        b--;
    }
    return answer;
}

int main()
{
    return power(2, 4);
}