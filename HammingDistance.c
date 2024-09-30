#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <string.h>

char* generate_string(int length){
    char* string = (char*)malloc((length+1) * sizeof(char));
    const char charset[] = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";

    for (int i  = 0; i < length; i++){
        int index = rand() % (sizeof(charset) - 1);
        string[i] = charset[index];
    }
    string[length] = '\0';
    return string;
}

int hammingDistance(const char* s1, const char* s2, int length){
    int distance = 0;
    for (int i = 0; i < length; i++){
        if(s1[i] != s2[i]){
            distance++;
        }
    }
    return distance;
}

int main(int argc, char* argv[]){

    printf("Number of arguments: %d\n", argc);
    for (int i = 0; i < argc; i++) {
        printf("Argument %d: %s\n", i, argv[i]);
    }

    if(argc != 4){
        printf("Usage: %s <number_of_strings> <string_length> <random_seed>\n", argv[0]);
    }
    
    int N = atoi(argv[1]);
    int L = atoi(argv[2]);
    int s = atoi(argv[3]);

    srand(s);

    char** strings = (char**)malloc(N * sizeof(char*));

    for (int i = 0; i < N; i++){
        strings[i] = generate_string(L);
        printf("String %d: %s\n", i + 1, strings[i]);
    }

    long long checksum = 0;
    int pairs = 0;

    for (int i = 0; i < N; i++){
        for (int j = i + 1; j < N; j++){
            int distance = hammingDistance(strings[i], strings[j], L);
            checksum += distance;
            pairs++;
        }
    }

    double average = (double)checksum / pairs;
    printf("\nChecksum (sum of all Hamming distances): %lld\n", checksum);
    printf("Average Hamming distance: %.2f\n", average);

    for(int i = 0; i < N; i++){
        free(strings[i]);
    }
    free(strings);
}
