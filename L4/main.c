#include <stdio.h>
#include <stdint.h>
#include <ctype.h>

int main() {
    FILE *fptr;
    int num, which = 0;
    fptr = fopen("input.dat", "r");
    int n = fgetc(fptr);
    printf("%c\n", n);
    int size;
    size = atoi(n);
    double input[size];


    while ( (num = fgetc(fptr)) != EOF ) {
        if (!isspace(num)) {
            int numInt = atoi(num);
            input[which] = numInt;
            which++;
        }
        else continue;
    }

    fclose(fptr);

    return 0;
}

