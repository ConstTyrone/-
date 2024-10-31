#include <iostream>
#include <string.h>
#include <unistd.h>
#include "common.h"

extern FILE *yyin;
extern FILE *yyout;

int yylex();

char outfile[256] = "a.out";
dump_type_t dump_type = ASM;

int main(int argc, char *argv[])
{
    int opt;
    while ((opt = getopt(argc, argv, "to:")) != -1)
    {
        switch (opt)
        {
        case 'o':
            strncpy(outfile, optarg, sizeof(outfile) - 1);
            outfile[sizeof(outfile) - 1] = '\0'; // Ensure null-termination
            break;
        case 't':
            dump_type = TOKENS;
            break;
        default:
            fprintf(stderr, "Usage: %s [-o outfile] infile\n", argv[0]);
            exit(EXIT_FAILURE);
            break;
        }
    }
    if (optind >= argc)
    {
        fprintf(stderr, "no input file\n");
        exit(EXIT_FAILURE);
    }
    yyin = fopen(argv[optind], "r");
    if (!yyin)
    {
        fprintf(stderr, "%s: No such file or directory\n", argv[optind]);
        exit(EXIT_FAILURE);
    }
    yyout = fopen(outfile, "w");
    if (!yyout)
    {
        fprintf(stderr, "%s: fail to open output file\n", outfile);
        fclose(yyin); // Close the input file before exiting
        exit(EXIT_FAILURE);
    }
    while (yylex() != 0) {
        yylex();// 处理词法单元
    }

    fclose(yyin); // Close the input file
    fclose(yyout); // Close the output file
    return 0;
}
