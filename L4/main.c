#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>
#include <ctype.h>
#include <inttypes.h>

extern double opt(double* masyvas, uint64_t  kiek);
extern uint64_t arvisi(double* masyvas, uint64_t kiek);

int main() {
    FILE *fptr;
    int num, which = 0;
    fptr = fopen("input.dat", "r");
    uint64_t n;
    fscanf(fptr, "%llu", &n);
    double input[n];

    for (int i = 0; i < n; i++) {
        double num;
        fscanf(fptr, "%lf", &num);
        input[i] = num;
    }
    double x = opt(input, n);
    uint64_t z = arvisi(input, n);
    printf("%.10f\n", x);
    printf("%" PRIu64 "\n", z);

    fclose(fptr);

    return 0;
}

