#include <stdio.h>

int main() {
    int secret = 42;
    char buffer[100];
    printf("Enter your name (max 99 characters): ");
    fgets(buffer, 100, stdin);
    printf("%s", buffer);
    return 0;
}