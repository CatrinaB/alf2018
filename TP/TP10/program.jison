    
    

/* Jison example file */
 
/* Tokens part */
%lex
 
%%
 
/* RegEx */
 
// add newline for Windows (\r\n) and Linux/Unix/Mac (\n)
\r?\n					return 'NEWLINE';
// \s includes \n space and tab, we need the NEWLINE token, so we put space and tab in white spacve
[ \t]                   /* skip whitespace */ 
function			  return 'FUNCTION';
endfunction           return 'END_FUNCTION';
[0-9]+("."[0-9]+)?    return 'NUMBER'; 
\"[^\"]*\"			  return 'STRING_VALUE';
// add the token for the variable
[A-Za-z][A-Za-z0-9]*  return 'IDENTIFIER';
"="				      return '=';
"-"                   return '-';
"+"                   return '+';
"*"                   return '*';
"/"                   return '/';
"("                   return '(';
")"	                  return ')';
","				      return ',';
"{"					  return '{';
"}"					  return '}';
 
 
 
/lex
 
/* Grammar part, for this lab */
 
// when it is ambiguous, derive the left part
%left '+' '-'
// * and / have higher priority
%left '*' '/' 
 
%% 
 
start: expressions { 
				$$ = 
				{
				    type:'script',
				    statements: $1
				};
                 return $$; 
            };
 
expressions: statement NEWLINE expressions	{
                                                $3.splice (0, 0, $1);
                                                $$ = $3;
										}
			| statement NEWLINE		{
									$$ = [$1];
								}
			| statement	{
						$$ = [$1];
					};
 
statement:  expr  {
                    
                }
			| function {

					}
            | assign {
                       
                    };
 
 
expr:	'(' expr ')'	{
							$$ = $2;	
						}
	  | expr '+' expr	{ 
				$$ = {
				    type: 'expr',
				    op: '+',
				    left: $1,
				    right: $3
				};
			}
      | expr '-' expr 	{
        				$$ = {
    				    type: 'expr',
    				    op: '-',
    				    left: $1,
    				    right: $3
    				};
      			}
      | expr '*' expr	{ 
    			$$ = {
				    type: 'expr',
				    op: '*',
				    left: $1,
				    right: $3
				};
			}
      | expr '/' expr 	{
    				$$ = {
    				    type: 'expr',
    				    op: '/',
    				    left: $1,
    				    right: $3
    				};
      			}
      | IDENTIFIER
                {
                    $$ = {
        	  		    type: 'id',
        	  		    value: $1
        	  		};
                }
      | NUMBER 	{ 
	  		$$ = {
	  		    type: 'number',
	  		    value: parseFloat ($1)
	  		};
	  	}
	   | STRING_VALUE {
			$$ = {
	  		    type: 'string',
	  		    value: $1.substring (1, $1.length-2)
	  		};
		}
		| function_run;
 
assign: IDENTIFIER '=' expr
            {
                $$ = {
                    type: 'assign',
                    to: $1,
                    from: $3
                };
            };
 
function_run: IDENTIFIER '(' parameters_run ')' {
													$$ = {
													    type: 'function_run',
													    id: $1,
													    parameters: $3
													};
												};
 
parameters_run: expr ',' parameters_run
				{
				    $3.splice (0, 0, $1);
					$$ = $3;
				}
			| expr
				{
					$$ = [$1];
				}
			|	{
					$$ = [];
				};
function: FUNCTION IDENTIFIER '(' parameters ')' '{' expressions '}' {
    $$ = {
        type: 'function',
		name: $2,
        parameters: $4,
        statements: $7
    };
};

parameters: IDENTIFIER ',' parameters
				{
				    $3.splice (0, 0, $1);
					$$ = $3;
				}
			| IDENTIFIER
				{
					$$ = [$1];
				}
			|	{
					$$ = [];
				};