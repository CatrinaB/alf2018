%lex
 
%%
 
\s+                     //
[0-9]+\.[0-9]+          return 'REAL_NUMBER';
[0-9]+                  return 'INTEGER_NUMBER';
\"[^\"]+\"|\'[^\']+\'   return 'STRING_VALUE';
int                     return 'INT';
double                  return 'DOUBLE';
string                  return 'STRING';
[A-Za-z][A-Za-z0-9]*    return 'IDENTIFIER';
';'                     return ';';
'<-'                    return 'ATTRIBUTION';
'+'                     return '+';
'-'                     return '-';
'*'                     return '*';
'/'                     return '/';
'%'                     return '%';
<<EOF>>                 return 'EOF';

/lex

%left '+' '-'
%left '*' '/' '%'

%% 
 
start
: statements EOF    { 
                        console.log('Parsed with no errors');
                        return $$; 
                    };
statements
: statement ';' statements
| statement ';'
;

statement
: declaration
| expr
| expr_string
;

declaration
: INT IDENTIFIER ATTRIBUTION INTEGER_NUMBER     { 
                                                    console.log($1 + ' ' + $2 + ' ' + $3 + ' ' + $4);
                                                }
| DOUBLE IDENTIFIER ATTRIBUTION REAL_NUMBER     {
                                                    console.log($1 + ' ' + $2 + ' ' + $3 + ' ' + $4);
                                                }
| STRING IDENTIFIER ATTRIBUTION STRING_VALUE    { 
                                                    console.log($1 + ' ' + $2 + ' ' + $3 + ' ' + $4);
                                                }
;

expr
: expr '+' expr
| expr '-' expr
| expr '*' expr
| expr '/' expr
| expr '%' expr
| INTEGER_NUMBER
| REAL_NUMBER
;

expr_string
: expr_string '+' expr_string
| STRING_VALUE
;