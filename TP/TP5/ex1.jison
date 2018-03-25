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
<<EOF>>                 return 'EOF';

/lex
 
%% 
 
start
: declaration ';'   { 
                        return $$; 
                    };

declaration
: INT IDENTIFIER ATTRIBUTION INTEGER_NUMBER     { console.log($1 + ' ' + $2 + ' ' + $3 + ' ' + $4); }
| DOUBLE IDENTIFIER ATTRIBUTION REAL_NUMBER     { console.log($1 + ' ' + $2 + ' ' + $3 + ' ' + $4); }
| STRING IDENTIFIER ATTRIBUTION STRING_VALUE    { console.log($1 + ' ' + $2 + ' ' + $3 + ' ' + $4); }
;
