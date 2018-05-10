/* Jison example file */
 
/* Tokens part */
%lex
 
%%
 
/* RegEx */
 
// add newline for Windows (\r\n) and Linux/Unix/Mac (\n)
// \s includes \n space and tab, we need the NEWLINE token, so we put space and tab in white space
\r?\n					return 'NEWLINE';
[ \t]                   /* skip whitespace */ 
var 		            return 'VAR';
of 		              	return 'OF';
int                     return 'INT';
float                   return 'FLOAT';
string                  return 'STRING';
function				return 'FUNCTION';
endfunction             return 'END_FUNCTION';
[0-9]+"."[0-9]+  		return 'NUMBER_FLOAT';
[0-9]+ 					return 'NUMBER_INTEGER';
\"[^\"]*\"				return 'STRING_VALUE';
[A-Za-z][A-Za-z0-9]*  	return 'IDENTIFIER';
'='				        return '=';
"-"                   	return '-';
"+"                   	return '+';
"*"                   	return '*';
"/"                   	return '/';
"("                   	return '(';
")"	                  	return ')';
','				        return ',';
 
/lex
 
/* Grammar part, for this lab */
 
// when it is ambiguous, derive the left part
// * and / have higher priority
%left '+' '-'
%left '*' '/' 
 
%{
// function for grammar rule
var symbol_table = {};

function addVariable (variable, type)
{
  symbol_table[variable] = {
    type: type,
    value: undefined
  };
}

function addFunction (name, parameters) {
	symbol_table[name] = {
		parameters: parameters
	};
}

function deleteParameters () {
	for(let key of Object.keys(symbol_table)) {
		if (symbol_table[key].type === 'parameter') {
			delete symbol_table[key];
		}
	}
}

function isDefined (variable)
{
   return (symbol_table[variable]) ? true : false;
}

function getType (element1, element2, op) {
	let a;
	let b;

	if (element1.type === 'variable') {
		a = symbol_table[element1.value].type;
	}
	else {
		a = element1.type;
	}

	if (element2.type === 'variable') {
		b = symbol_table[element2.value].type;
	}
	else {
		b = element2.type;
	}

	if ((a === 'string' || b === 'string')) {
		if(op !== '+') {
			return 'error';
		}
		else {
			return 'string';
		}
	}

	if (a === b) {
		return a;
	}

	if(a === 'float' || b === 'float') {
		return 'float';
	}
}

%}
 
%% 
 
start
: expressions 	{
					return { 
						ast: {
							type: 'program',
							elements: $1,
							line: yylineno + 1
						},
						symbol_table: symbol_table
					};
            	}
;
            
expressions
: expressions NEWLINE statement		{
										$1.push($3); // add the expression to the array produced by expressions ($1)
										$$ = $1;
									}
| statement							{
										$$ = [];
										$$.push($1); // an array with one element
									}
;
					
statement
: expr
| variable
| assign
| function
| function_run
;
            		
 
expr
: '(' expr ')'			{
							$$ = {
								type: 'expr',
								value: $2,
								line: yylineno + 1
							};
						}
| expr '+' expr			{
							if (getType($1, $3, $2) === 'error') {
								return 'ERROR line ' + (yylineno + 1) + ': types are incompatible for operation ' + $2;
							}
							$$ = {
								type: 'expr',
								op: $2,
								left: $1,
								right: $3,
								dataType: getType($1, $3, $2),
								line: yylineno + 1
							};
						}
| expr '-' expr 		{
							if (getType($1, $3, $2) === 'error') {
								return 'ERROR line ' + (yylineno + 1) + ': types are incompatible for operation ' + $2;
							}
							$$ = {
								type: 'expr',
								op: $2,
								left: $1,
								right: $3,
								dataType: getType($1, $3, $2),
								line: yylineno + 1
							};
						}
| expr '*' expr			{
							if (getType($1, $3, $2) === 'error') {
								return 'ERROR line ' + (yylineno + 1) + ': types are incompatible for operation ' + $2;
							}
							$$ = {
								type: 'expr',
								op: $2,
								left: $1,
								right: $3,
								dataType: getType($1, $3, $2),
								line: yylineno + 1
							};
						}
| expr '/' expr 		{
							if (getType($1, $3, $2) === 'error') {
								return 'ERROR line ' + (yylineno + 1) + ': types are incompatible for operation ' + $2;
							}
							$$ = {
								type: 'expr',
								op: $2,
								left: $1,
								right: $3,
								dataType: getType($1, $3, $2),
								line: yylineno + 1
							};
						}
| NUMBER_INTEGER 		{ 
							$$ = {
									type: 'int',
									value: $1,
									line: yylineno + 1
							};
						}
| NUMBER_FLOAT 			{ 
							$$ = {
									type: 'float',
									value: $1,
									line: yylineno + 1
							};
						}
| IDENTIFIER 			{
							if(!isDefined($1)) {
								return 'ERROR at line ' + (yylineno + 1) + ': ' + $1 + ' is not defined';
							}

							$$ = {
								type: 'variable',
								value: $1,
								line: yylineno + 1
							};
						}
| STRING_VALUE 			{
							$$ = {
									type: 'string',
									value: $1,
									line: yylineno + 1
							};
						}
;
		
variable: VAR variables {
							$$ = {
								type: 'var',
								variables: $2,
								line: yylineno + 1
							};
						}
;
 
variables
: variables ',' IDENTIFIER			{
										if(isDefined($3)) {
											return 'ERROR line ' + (yylineno + 1) + ': variable ' + $3 + ' is already defined';
										}
										addVariable($3, 'none');

										$1.push({
											id: $3,
											line: yylineno + 1
										});
										$$ = $1;
									}
| IDENTIFIER 						{
										if(isDefined($1)) {
											return 'ERROR line ' + (yylineno + 1) + ': variable ' + $1 + ' is already defined';
										}
										addVariable($1, 'none');

										$$ = [];
										$$.push({
											id: $1,
											line: yylineno + 1
										})	
									}
| variables ',' IDENTIFIER OF type 	{
										if(isDefined($3)) {
											return 'ERROR line ' + (yylineno + 1) + ': variable ' + $3 + ' is already defined';
										}
										addVariable($3, $5);

										$1.push({
											id: $3,
											type: $5,
											line: yylineno + 1
										});
										$$ = $1;
									}
| IDENTIFIER OF type 				{
										if(isDefined($1)) {
											return 'ERROR line ' + (yylineno + 1) + ': variable ' + $1 + ' is already defined';
										}
										addVariable($1, $3);

										$$ = [];
										$$.push({
											id: $1,
											type: $3,
											line: yylineno + 1
										});	
									}
;
			
type
: INT 
| FLOAT
| STRING
;
			
assign
: IDENTIFIER '=' expr 	{
							if(!isDefined($1)) {
								return 'ERROR at line ' + (yylineno + 1) + ': ' + $1 + ' is not defined';
							}

							symbol_table[$1].type = $3.dataType;

							$$ = {
								type: 'assign',
								to: {
									id: $1,
									line: yylineno + 1
								},
								from: $3,
								line: yylineno + 1
							};
						}
;

function
: FUNCTION IDENTIFIER '(' parameters ')' NEWLINE expressions NEWLINE END_FUNCTION 	{
																						addFunction($2, $4);
																						$$ = {
																							type: 'function_declaration',
																							id: $2,
																							parameters: $4,
																							expressions: $7,
																							line: yylineno + 1
																						};	
																						deleteParameters();																	
																					}
;

parameters
: parameters ',' IDENTIFIER OF type 	{
											addVariable($3, 'parameter');
											$1.push({
												id: $3,
												type: $5,
												line: yylineno + 1
											});
											$$ = $1;
										}
| IDENTIFIER OF type 					{
											addVariable($1, 'parameter');
											$$ = [];
											$$.push({
												id: $1,
												type: $3,
												line: yylineno + 1
											});
										}
|										{
											$$ = [];
										}
;

function_run
: IDENTIFIER '(' parameters_run ')' 	{
											$$ = {
												type: 'function_run',
												id: $1,
												parameters: $3,
												line: yylineno + 1
											};
										}
;
												
parameters_run
: parameters_run ',' expr  				{
											$1.push($3);
											$$ = $1;
										}
| expr 									{
											$$ = [];
											$$.push($1);
										}
|										{
											$$ = [];
										}
;