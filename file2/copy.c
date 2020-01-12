#include <stdio.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <unistd.h>
#include <stdlib.h>

void convert_upper(char *buffer, int num_bytes)
{
    for (int i = 0; i < num_bytes; i++)
    {
        int c = buffer[i];
        if (c < 'a' ||  c > 'z')
        {
            continue;
        }
        int upper = c - 32;
        buffer[i] = upper;
    }
}

void write_buffer(char *buffer, int fd, int num_bytes)
{
  write(fd, buffer, num_bytes);
}

int main(int agrv, char* argv[])
{
    int fd1 = open(argv[1],O_RDONLY);
    int fd2 = open(argv[2], O_WRONLY | O_CREAT | O_TRUNC, 0640);    
    char *buffer = (char *) calloc(500, sizeof(char)); 
    int num_bytes = 0;
    for (;;)
    {
        num_bytes = read(fd1, buffer, 500);
        if (num_bytes == 0)
        {
            break;
        }
        convert_upper(buffer, num_bytes);
        write_buffer(buffer, fd2, num_bytes);
    }

    close(fd1);
    close(fd2);
}
