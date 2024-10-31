%option noyywrap
%option nounput
%option noinput
%top{
    #include <stdarg.h>
    #include "common.h"
    #include "parser.h"
}

%{
    extern dump_type_t dump_type;

    inline void dump_tokens(const char* format, ...) {
        va_list args;
        va_start(args, format);
        if (dump_type == TOKENS)
            vfprintf(yyout, format, args);
        va_end(args);
    }

%}

/* definitions section */
DECIMIAL ([1-9][0-9]*|0)
ID [[:alpha:]_][[:alpha:][:digit:]_]*
EOL (\r\n|\n|\r)
WHITE [\t ]
COMMENT_SINGLE "//".*
COMMENT_MULTI "/*"([^*]|\*+[^*/])*\*+"/"
/* 可以根据需要定义其他词法单元的正则表达式 */

%%
    /* rules section */
"int" {
    dump_tokens("INT\t%s\n", yytext);
    return INT;
}

"if" {
    dump_tokens("IF\t%s\n", yytext);
    return IF;
}

"else" {
    dump_tokens("ELSE\t%s\n", yytext);
    return ELSE;
}

"return" {
    dump_tokens("RETURN\t%s\n", yytext);
    return RETURN;
}

"&&" {
    dump_tokens("AND\t%s\n", yytext);
    return AND;
}

"=" {
    dump_tokens("ASSIGN\t%s\n", yytext);
    return ASSIGN;
}

"<" {
    dump_tokens("LESS\t%s\n", yytext);
    return LESS;
}

"+" {
    dump_tokens("ADD\t%s\n", yytext);
    return ADD;
}

";" {
    dump_tokens("SEMICOLON\t%s\n", yytext);
    return SEMICOLON;
}

"(" {
    dump_tokens("LPAREN\t%s\n", yytext);
    return LPAREN;
}

")" {
    dump_tokens("RPAREN\t%s\n", yytext);
    return RPAREN;
}

"{" {
    dump_tokens("LBRACE\t%s\n", yytext);
    return LBRACE;
}

"}" {
    dump_tokens("RBRACE\t%s\n", yytext);
    return RBRACE;
}

{DECIMIAL} {
    dump_tokens("DECIMAL\t%s\n", yytext);
    return DECIMAL;
}

{ID} {
    dump_tokens("ID\t%s\n", yytext);
    return IDENTIFIER;
}

{EOL} {
    yylineno++; // 行号增加
}

{WHITE} /* 忽略空白字符 */

{COMMENT_SINGLE} /* 忽略单行注释 */

{COMMENT_MULTI} /* 忽略多行注释 */


%%