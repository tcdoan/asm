#include <stdio.h>

// void read_matrix(char* filename, int** x);


void multiply_matrix (int **a, int **b,int **c)
{
    // movl %esp, %ebp

    c[0][0] = a[0][0]*b[0][0] + a[0][1]*b[1][0];
    c[0][1] = a[0][0]*b[0][1] + a[0][1]*b[1][1];
    c[1][0] = a[1][0]*b[0][0] + a[1][1]*b[1][0];
    c[1][1] = a[1][0]*b[0][1] + a[1][1]*b[1][1];
}

int main(void)
{
    int a[2][2];
    int b[2][2];
    int c[2][2];

    a[0][0] = 1;
    a[0][1] = 2;
    a[1][0] = 1;
    a[1][1] = 2;

    b[0][0] = 1;
    b[0][1] = 2;
    b[1][0] = 1;
    b[1][1] = 3;

    multiply_matrix(a, b, c);
    printf("%d %d\n", c[0][0], c[0][1]);
    printf("%d %d\n", c[1][0], c[1][1]);
}


