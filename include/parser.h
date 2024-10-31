/* parser.h */
#ifndef PARSER_H
#define PARSER_H

/* Token codes */
#define END_OF_FILE 0
#define INT 257
#define IF 258
#define ELSE 259
#define RETURN 260
#define AND 261
#define ASSIGN 262
#define LESS 263
#define ADD 264
#define SEMICOLON 265
#define LPAREN 266
#define RPAREN 267
#define LBRACE 268
#define RBRACE 269
#define DECIMAL 270
#define IDENTIFIER 271

/* YYSTYPE definition */
typedef union {
    int ival;
    char* sval;
    // 可能还有其他类型，取决于你的语法
} YYSTYPE;

/* YYSTYPE pointer */
typedef YYSTYPE* YYSTYPEPtr;

#endif /* PARSER_H */
