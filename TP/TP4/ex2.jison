%lex
 
%%
 
\s+                     //
\r\n                    //
[0-9]+(\.[0-9]+)?       return 'NUMBER'; 
[A-Za-z]+               return 'WORDS';
[\!\?\.,;:]             return 'PUNCTUATION';
<<EOF>>                 return 'EOF';  
 
/lex
 
%% 
 
start:;