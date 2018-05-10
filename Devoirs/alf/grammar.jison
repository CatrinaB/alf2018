%lex

%%

^(\r?\n)+$                          /* skip */
[ \t]+   							/* skip */
\{[^\{\}]*\}(\r?\n)+				/* skip */
(\r?\n)+							return 'NL';
"class" 							return 'CLASS';
"property"							return 'PROPERTY';
"message"							return 'MESSAGE';
"return"                            return 'RETURN';
"define"							return 'DEFINE';
"to"								return 'TO';
"downto"                            return 'DOWNTO';
"is"                                return 'IS';
"in"                                return 'IN';
"range"                             return 'RANGE';
"for"								return 'FOR';
"while"								return 'WHILE';
"repeat"							return 'REPEAT';
"when"                              return 'WHEN';
"begin"								return 'BEGIN';
"end"								return 'END';
"then"								return 'THEN';
"if"								return 'IF';
"else"								return 'ELSE';
"none"								return 'NONE';
int|real|logic|string|character     return 'TYPE';
true|false							return 'LOGIC_VALUE';
"mod"								return '%';
"or"								return 'OR';
"xor"								return 'XOR';
"and"								return 'AND';
"not"								return 'NOT';
[0-9]+("."[0-9]+)?  				return 'NUMBER'; 
[A-Za-z\$_][A-Za-z\$_0-9]*			return 'IDENTIFIER';
(?:'"')((?:\\\")|[^\"])(?:'"')  	return 'SYMBOL';
(?:'"')(((?:\\\")*|[^\"])*)(?:'"')	return 'STRING_VALUE';
":="								return 'ASSIGN';
":"                                 return ':';
"#"                                 return '#';
">"									return '>';
"<"									return '<';
"="					  				return '=';
"!="								return '!=';
","				          			return ',';
"-"                   				return '-';
"+"                   				return '+';
"*"                   				return '*';
"/"                   				return '/';
"("                   				return '(';
")"	                  				return ')';
"|"									return '|';
"&"									return '&';
"["                                 return '[';
"]"                                 return ']';
<<EOF>> 							return 'EOF';

/lex

%left AND
%left OR XOR
%left '=' '!='
%left '>' '>=' '<=' '<'
%right 'NOT'
%left '+' '-'
%left '*' '/' '%'
%left '#' '|'

%{
	function typeOfNumber(number){
		if(Math.floor(parseFloat(number)) === parseFloat(number)){
			return 'int';
		}
		else{
			return 'real';
		}
	}
%}

%%

start
: compilationUnit EOF 			{
									return {
												id: 'module',
												statements: $$,
												line: yylineno + 1
										   };
								}
| EOF                           {
									return {
												id: 'module',
												statements: [],
												line: yylineno + 1
										   };
								}
;

compilationUnit
: compilationUnit NL statements   	{$1.push($3); $$ = $1;}
| statements 					    {$$ = []; $$.push($1);}
;

statements
: value
| variable
| variableAssign
| array
| functionDeclaration
| if
| while
| repeat
| for
| arrayAssign
| class
| message
| returnExpr
;

value
: '(' value ')' 				{
									$$ = $2;
								}
| value '=' value 				{
									$$ = {
												id: 'exp',
												op: '=',
												left: $1,
												right: $3,
												line: yylineno + 1
										 };
								}
| value '!=' value 				{
									$$ = {
												id: 'exp',
												op: '!=',
												left: $1,
												right: $3,
												line: yylineno + 1
										 };
								}
| value '+' value 				{
									$$ = {
												id: 'exp',
												op: '+',
												left: $1,
												right: $3,
												line: yylineno + 1
										 };
								}
| value '-' value 				{
									$$ = {
												id: 'exp',
												op: '-',
												left: $1,
												right: $3,
												line: yylineno + 1
										 };
								}
| value '*' value 				{
									$$ = {
												id: 'exp',
												op: '*',
												left: $1,
												right: $3,
												line: yylineno + 1
										 };
								}
| value '/' value 				{
									$$ = {
												id: 'exp',
												op: '/',
												left: $1,
												right: $3,
												line: yylineno + 1
										 };
								}
| value '%' value 				{
									$$ = {
												id: 'exp',
												op: 'mod',
												left: $1,
												right: $3,
												line: yylineno + 1
										 };
								}
| value '>' value 				{
									$$ = {
												id: 'exp',
												op: '>',
												left: $1,
												right: $3,
												line: yylineno + 1
										 };
								}
| value '<' value 				{
									$$ = {
												id: 'exp',
												op: '<',
												left: $1,
												right: $3,
												line: yylineno + 1
										 };
								}
| value '<' '=' value 			{
									$$ = {
												id: 'exp',
												op: '<=',
												left: $1,
												right: $4,
												line: yylineno + 1
										 };
								}
| value '>' '=' value 			{
									$$ = {
												id: 'exp',
												op: '>=',
												left: $1,
												right: $4,
												line: yylineno + 1
										 };
								}
| value OR value 				{
									$$ = {
												id: 'exp',
												op: 'or',
												left: $1,
												right: $3,
												line: yylineno + 1
										 };
								}
| value XOR value 				{
									$$ = {
												id: 'exp',
												op: 'xor',
												left: $1,
												right: $3,
												line: yylineno + 1
										 };
								}
| value AND value 				{
									$$ = {
												id: 'exp',
												op: 'and',
												left: $1,
												right: $3,
												line: yylineno + 1
										 };
								}
| NOT value 					{
									$$ = {
												id: 'exp',
												op: 'not',
												value: $2,
												line: yylineno + 1
										 };
								}
| '-' value		                {
									$$ = {
												id: 'exp',
												op: 'negative',
												value: $2,
												line: yylineno + 1
										 };
								}
| NUMBER 						{
									$$ = {
												id: 'value',
												type: typeOfNumber($$),
												value: JSON.parse($$),
												line: yylineno + 1
										 };
								}
| STRING_VALUE 					{
									$$ = {
												id: 'value',
												type: 'string',
												value: JSON.parse($$),
												line: yylineno + 1
										 };
								}
| SYMBOL 						{
									$$ = {
												id: 'value',
												type: 'character',
												value: JSON.parse($$),
												line: yylineno + 1
										 };
								}
| LOGIC_VALUE					{
									$$ = {
												id: 'value',
												type: 'logic',
												value: JSON.parse($$),
												line: yylineno + 1
										 };
								}
| IDENTIFIER					{
									$$ = {
												id: 'identifier',
												title: $$,
												line: yylineno + 1
										 };
								}
| NONE 						    {
									$$ = {
												id: 'value',
												type: 'none',
												line: yylineno + 1
										 };
								}
| arrayAccess
| functionRun
| propertyAccess
;

returnExpr
: RETURN value 					{
									$$ = {
												id: 'return',
												value: $2,
												line: yylineno + 1
										 };
								}
;

variable
: DEFINE variables 				{
									$$ = {
											type: 'define',
											elements: $2,
											line: yylineno + 1
									};
								}
;

variables
: variables ',' variableDeclaration     {$1.push($3); $$ = $1;}
| variableDeclaration 			        {$$ = []; $$.push($1);}
;

variableDeclaration
: IDENTIFIER ':' type ASSIGN value 		{
											$$ = {
													type: $3,
													title: $1,
													value: $5,
													line: yylineno + 1
											};
										}
| IDENTIFIER ':' type 				    {
											$$ = {
													type: $3,
													title: $1,
													line: yylineno + 1
											};
										}
| IDENTIFIER ASSIGN value 		        {
											$$ = {
													type: 'auto',
													title: $1,
													value: $3,
													line: yylineno + 1
											};
										}
;

variableAssign
: IDENTIFIER ASSIGN value 				{
											$$ = {
													id: 'set',
													to: {
															id: 'identifier',
															title: $1,
															line: yylineno + 1
														},
													from: $3,
													line: yylineno + 1
											};
										}
| propertyAccess ASSIGN value 			{
											$$ = {
													id: 'set',
													to: $1,
													from: $3,
													line: yylineno + 1
											};
										}
;

array
: IDENTIFIER ':' type '[' NUMBER TO NUMBER ']'   	    {
															$$ = {
																	id: 'list',
																	title: $1,
																	element_type: $3,
																	from: $5,
																	to: $7,
																	line: yylineno + 1
																 };
														}
;

arrayAssign
: arrayAccess ASSIGN value               					{
															$$ = {
																	id: 'set',
																	to: $1,
																	from: $3,
																	line: yylineno + 1
															};
														}
;

arrayAccess
: IDENTIFIER '#' value   							    {
															$$ = {
																	id: 'element_of_list',
																	list: $1,
																	index: $3,
																	line: yylineno + 1
															};
														}
;

propertyAccess
: value '|' IDENTIFIER 							{
															$$ = {
																	id: 'property',
																	object: $1,
																	title: $3,
																	line: yylineno + 1
															};
														}
;

functionDeclaration
: MESSAGE IDENTIFIER ':' type functionDeclarationParameters '=' statements  			        {
																									$$ = {
																										id: 'message',
																										title: $2,
																										parameters: $5,
																										return_type: $4,
																										statements: [$7],
																										line: yylineno + 1
																									};
																								}
| MESSAGE IDENTIFIER ':' type functionDeclarationParameters NL BEGIN NL compilationUnit NL END  {
																									$$ = {
																										id: 'message',
																										title: $2,
																										parameters: $5,
																										return_type: $4,
																										statements: $9,
																										line: yylineno + 1
																									};
																								}
| MESSAGE IDENTIFIER ':' type NL BEGIN NL compilationUnit NL END  			                    {
																									$$ = {
																										id: 'message',
																										title: $2,
																										parameters: [],
																										return_type: $4,
																										statements: $8,
																										line: yylineno + 1
																									};
																								}
| MESSAGE IDENTIFIER ':' type '=' statements 						                            {
																									$$ = {
																										id: 'message',
																										title: $2,
																										parameters: [],
																										return_type: $4,
																										statements: [$6],
																										line: yylineno + 1
																									};
																								}
;

functionDeclarationParameters
: functionDeclarationParameters ',' IDENTIFIER ':' type     {
																$1.push(
																			{
                                                                                type: $5,
																				id: $3,
																				line: yylineno + 1,
																			}
																		);

																$$ = $1;
															}
| IDENTIFIER ':' type 									    {
																$$ = [];
																$$.push(
																			{
                                                                                type: $3,
																				id: $1,
																				line: yylineno + 1,
																			}
																		);
															}
;

functionRunParameters
: functionRunParameters ',' IDENTIFIER ':' value			{
																$1[$3] = $5;
																$$ = $1;
															}		
| IDENTIFIER ':' value 										{
																$$ = {};
																$$[$1] = $3;
															}
;							

functionRun
: '[' function ']' {$$ = $2;}
;

function
: IDENTIFIER IDENTIFIER functionRunParameters			    {
																$$ = {
																		id: 'dispatch',
                                                                        message: $2,
                                                                        object: $1,
																		parameters: $3,
																		line: yylineno + 1
																};

															}
| IDENTIFIER IDENTIFIER			                            {
																$$ = {
																		id: 'dispatch',
                                                                        message: $2,
                                                                        object: $1,
																		parameters: [],
																		line: yylineno + 1
																};

															}
;

class
: CLASS IDENTIFIER EXTENDS IDENTIFIER NL properties NL messages NL END  {
                                                                            $$ = {
                                                                                id: 'class',
                                                                                title: $2,
                                                                                parent: $4,
                                                                                properties: $6,
                                                                                messages: $8
                                                                            };
                                                                        }
| CLASS IDENTIFIER EXTENDS IDENTIFIER NL messages NL END                   {
                                                                            $$ = {
                                                                                id: 'class',
                                                                                title: $2,
                                                                                parent: $4,
                                                                                properties: [],
                                                                                messages: $6
                                                                            };
                                                                        }
| CLASS IDENTIFIER EXTENDS IDENTIFIER NL properties NL END              {
                                                                            $$ = {
                                                                                id: 'class',
                                                                                title: $2,
                                                                                parent: $4,
                                                                                properties: $5,
                                                                                messages: []
                                                                            };
                                                                        }
| CLASS IDENTIFIER EXTENDS IDENTIFIER NL END                            {
                                                                            $$ = {
                                                                                id: 'class',
                                                                                title: $2,
                                                                                parent: $4,
                                                                                properties: [],
                                                                                messages: []
                                                                            };
                                                                        }                                                                                                                            
| CLASS IDENTIFIER NL messages NL END                                   {
                                                                            $$ = {
                                                                                id: 'class',
                                                                                title: $2,
                                                                                parent: '',
                                                                                properties: [],
                                                                                messages: $4
                                                                            };
                                                                        }
| CLASS IDENTIFIER NL properties NL END                                 {
                                                                            $$ = {
                                                                                id: 'class',
                                                                                title: $2,
                                                                                parent: '',
                                                                                properties: $4,
                                                                                messages: []
                                                                            };
                                                                        }
| CLASS IDENTIFIER NL END                                               {
                                                                            $$ = {
                                                                                id: 'class',
                                                                                title: $2,
                                                                                parent: '',
                                                                                properties: [],
                                                                                messages: []
                                                                            };
                                                                        }
;

property
: PROPERTY variableDeclaration 								{
																$$ = $2;
															}		
;

properties
: properties NL property 									{$1.push($3); $$ = $1;}
| property 													{$$ = []; $$.push($1);}
;

messages
: messages NL functionDeclaration  							{$1.push($3); $$ = $1;}
| functionDeclaration 										{$$ = []; $$.push($1);}
;

if
: IF value NL compilationUnit NL ELSE NL compilationUnit NL END {
																	$$ = {
																			id: 'if',
																			exp: $2,
																			then: $4,
																			else: $8,
																			line: yylineno + 1
																		 }
																}
| IF value NL compilationUnit NL END 							{
																	$$ = {
																			id: 'if',
																			exp: $2,
																			then: $4,
																			line: yylineno + 1
																		 }
																}
;

while
: WHILE value NL compilationUnit NL END 									{
																				$$ = {
																						id: 'while',
																						exp: $2,
																						statements: $4,
																						line: yylineno + 1
																					};
																			}
;

repeat
: REPEAT NL compilationUnit NL WHEN value 									{
																				$$ = {
																						id: 'repeat',
																						exp: $6,
																						statements: $3,
																						line: yylineno + 1
																					};
																			}
;

for
: FOR IDENTIFIER IN RANGE '(' value direction value ')' NL compilationUnit NL END {
																				$$ = {
																						id: 'for',
																						variable: $2,
																						list: {
                                                                                            low: $6,
                                                                                            high: $8,
                                                                                            direction: $7
                                                                                        },
																						statements: $11,
																						line: yylineno + 1
																				};
																			}
| FOR IDENTIFIER IN value NL compilationUnit NL END                {
																				$$ = {
																						id: 'for',
																						variable: $2,
																						exp: $4,
																						statements: $6,
																						line: yylineno + 1
																				};
																			}
;

direction
: TO
| DOWNTO
;

type
: TYPE
| IDENTIFIER
;