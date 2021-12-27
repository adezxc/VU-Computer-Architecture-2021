#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>
#include <ctype.h>

extern double opt(double* masyvas, uint64_t  kiek);
extern uint64_t arvisi(double* masyvas, uint64_t kiek);

int main() {
    FILE *fptr;
    int num, which = 0;
    fptr = fopen("input.dat", "r");
    int n;
    fscanf(fptr, "%d", &n);
    printf("%d\n", n);
    double input[n];

    for (int i = 0; i < n; i++) {
        double num;
        fscanf(fptr, "%2lf", num);
        input[i] = num;
    }


    fclose(fptr);

    return 0;
}

