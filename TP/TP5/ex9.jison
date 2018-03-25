%lex
 
%%
 
\s+                     //
[0-9]+\.[0-9]+          return 'REAL_NUMBER';
[0-9]+                  return 'INTEGER_NUMBER';
\"[^\"]+\"|\'[^\']+\'   return 'STRING_VALUE';
int                     return 'INT';
double                  return 'DOUBLE';
string                  return 'STRING';
boolean                 return 'BOOLEAN';
true                    return 'TRUE';
false                   return 'FALSE';
[A-Za-z][A-Za-z0-9]*    return 'IDENTIFIER';
';'                     return ';';
'<-'                    return 'ATTRIBUTION';
'+'                     return '+';
'-'                     return '-';
'*'                     return '*';
'/'                     return '/';
'%'                     return '%';
'&&'                    return 'AND';
'||'                    return 'OR';
'!'                     return 'NOT';
'('                     return '(';
')'                     return ')';
<<EOF>>                 return 'EOF';

/lex

%left '+' '-'
%left '*' '/' '%'
%left AND OR
%right NOT

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
| expr_boolean
;

declaration
: INT IDENTIFIER ATTRIBUTION expr               { 
                                                    if(!Number.isInteger($4)) {
                                                        $4 = Math.floor($4);
                                                        console.log('Warning: possible loss of data');
                                                    }
                                                    console.log($1 + ' ' + $2 + ' ' + $3 + ' ' + $4);
                                                }
| DOUBLE IDENTIFIER ATTRIBUTION expr            {
                                                    console.log($1 + ' ' + $2 + ' ' + $3 + ' ' + $4);
                                                }
| STRING IDENTIFIER ATTRIBUTION expr_string     { 
                                                    console.log($1 + ' ' + $2 + ' ' + $3 + ' ' + $4);
                                                }
| BOOLEAN IDENTIFIER ATTRIBUTION expr_boolean   { 
                                                    console.log($1 + ' ' + $2 + ' ' + $3 + ' ' + $4);
                                                }                                               
;

boolean_value
: TRUE
| FALSE
;

expr_boolean
: expr_boolean AND expr_boolean                 {
                                                    console.log('Operator: ' + $2);
                                                    console.log('Operands: ' + $1 + ', ' + $3);
                                                    $$ = JSON.parse($1) && JSON.parse($3);
                                                    console.log($$)
                                                }
| expr_boolean OR expr_boolean                  {
                                                    console.log('Operator: ' + $2);
                                                    console.log('Operands: ' + $1 + ', ' + $3);
                                                    $$ = JSON.parse($1) || JSON.parse($3);
                                                    console.log($$)
                                                }
| NOT expr_boolean                              {
                                                    console.log('Operator: ' + $1);
                                                    console.log('Operand: ' + $2);
                                                    $$ = !JSON.parse($2);
                                                    console.log($$)
                                                }
| boolean_value
;

expr
: expr '+' expr                                 {
                                                    console.log('Operator: ' + $2);
                                                    console.log('Operands: ' + $1 + ', ' + $3);
                                                    var variables = [];
                                                    if(isNaN($1)) {
                                                        variables.push($1);
                                                    }
                                                    if(isNaN($3)) {
                                                        variables.push($3);
                                                    }
                                                    if(variables.length !== 0) {
                                                        console.log('The expression contains variables: ' + variables.toString());
                                                    }
                                                    else {
                                                        $$ = parseFloat($1) + parseFloat($3);
                                                        console.log($$);
                                                    }
                                                }
| expr '-' expr                                 {
                                                    console.log('Operator: ' + $2);
                                                    console.log('Operands: ' + $1 + ', ' + $3);
                                                    var variables = [];
                                                    if(isNaN($1)) {
                                                        variables.push($1);
                                                    }
                                                    if(isNaN($3)) {
                                                        variables.push($3);
                                                    }
                                                    if(variables.length !== 0) {
                                                        console.log('The expression contains variables: ' + variables.toString());
                                                    }
                                                    else {
                                                        $$ = parseFloat($1) - parseFloat($3);
                                                        console.log($$);
                                                    }
                                                }
| expr '*' expr                                 {
                                                    console.log('Operator: ' + $2);
                                                    console.log('Operands: ' + $1 + ', ' + $3);
                                                    var variables = [];
                                                    if(isNaN($1)) {
                                                        variables.push($1);
                                                    }
                                                    if(isNaN($3)) {
                                                        variables.push($3);
                                                    }
                                                    if(variables.length !== 0) {
                                                        console.log('The expression contains variables: ' + variables.toString());
                                                    }
                                                    else {
                                                        $$ = parseFloat($1) * parseFloat($3);
                                                        console.log($$);
                                                    }
                                                }
| expr '/' expr                                 {
                                                    console.log('Operator: ' + $2);
                                                    console.log('Operands: ' + $1 + ', ' + $3);
                                                    var variables = [];
                                                    if(isNaN($1)) {
                                                        variables.push($1);
                                                    }
                                                    if(isNaN($3)) {
                                                        variables.push($3);
                                                    }
                                                    if(variables.length !== 0) {
                                                        console.log('The expression contains variables: ' + variables.toString());
                                                    }
                                                    else {
                                                        $$ = parseFloat($1) / parseFloat($3);
                                                        console.log($$);
                                                    }
                                                }
| expr '%' expr                                 {
                                                    console.log('Operator: ' + $2);
                                                    console.log('Operands: ' + $1 + ', ' + $3);
                                                    var variables = [];
                                                    if(isNaN($1)) {
                                                        variables.push($1);
                                                    }
                                                    if(isNaN($3)) {
                                                        variables.push($3);
                                                    }
                                                    if(variables.length !== 0) {
                                                        console.log('The expression contains variables: ' + variables.toString());
                                                    }
                                                    else {
                                                        $$ = parseFloat($1) % parseFloat($3);
                                                        console.log($$);
                                                    }
                                                }
| '(' expr ')'                                  {
                                                    $$ = $2;
                                                }
| INTEGER_NUMBER                                {
                                                    $$ = $1;
                                                }
| REAL_NUMBER                                   {
                                                    $$ = $1;
                                                }
| IDENTIFIER                                    {
                                                    $$ = $1;
                                                }
;

expr_string
: expr_string '+' expr_string                   {
                                                    $$ = $1 + $3;
                                                }
| STRING_VALUE                                  {
                                                    $$ = JSON.parse($1);
                                                }
;