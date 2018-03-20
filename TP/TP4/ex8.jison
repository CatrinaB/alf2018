%lex
 
%%
 
\s+                     //
\r?\n                   //
[0-9]+                  return 'INTEGER_NUMBER';
[0-9]+\.[0-9]+          return 'REAL_NUMBER'; 
for                     return 'FOR';
if                      return 'IF';
while                   return 'WHILE';
else                    return 'ELSE';
function                return 'FUNCTION';
[a-zA-Z_][a-zA-Z0-9_]*  return 'FUNCTION_NAME';
\$[a-zA-Z0-9]+          return 'IDENTIFIER';
"[^"]+"|'[^']+'         return 'STRING_VALUE';
'('                     return '(';
')'                     return ')';
'{'                     return '{';
'}'                     return '}';
','                     return ',';
';'                     return ';';
'+'                     return '+';
'-'                     return '-';
'*'                     return '*';
'/'                     return '/';
'%'                     return '%';
'='                     return '=';
<<EOF>>                 return 'EOF';  
 
/lex
 
%% 
 
start:;