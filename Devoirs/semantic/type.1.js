// jshint node: true, loopfunc: true, esnext: true

"use strict";

var error = require ('./error.js');
var assert = require ('assert');
var _ = require ('lodash');

var STATEMENT_LIST = ['if', 'module', 'for', 'while', 'repeat', 'message'];
var TYPE_RULES = [];

function set_type_rule (t1, o, t2, t3)
{
	var rule = {
		regex: new RegExp ('^('+t1+')\\.('+o+')\\.('+t2+')$'),
		value: t3
	};
	TYPE_RULES.push (rule);
}

// type rules

var MATH = '\\+|\\-|\\*|\\/|mod';
var RELATIONSHIP = '>=|<=|<|>';
var LOGIC = 'AND|OR|XOR|not';
var EQUALITY = '=|!=';
var ATTRIBUTION = ':=';

// string
set_type_rule ('string', '\\+', '.+', 'string');
set_type_rule ('.+', '\\+', 'string', 'string');

// numbers
set_type_rule ('real', MATH, 'int|real|character', 'real');
set_type_rule ('int|real|character', MATH, 'real', 'real');

set_type_rule ('character', MATH+'|'+LOGIC, 'character', 'character');
set_type_rule ('int', MATH, 'int|character', 'int');

set_type_rule ('int|character', LOGIC, 'int|character', 'int');
set_type_rule ('int|character', MATH, 'int', 'int');

// symbol
set_type_rule ('character', MATH+'|'+LOGIC, 'character', 'character');

// logic
set_type_rule ('string', RELATIONSHIP+'|'+EQUALITY, 'string', 'logic');
set_type_rule ('int|real|character', RELATIONSHIP+'|'+EQUALITY, 'int|real|character', 'logic');
set_type_rule ('logic', LOGIC+'|'+RELATIONSHIP+'|'+EQUALITY, 'logic', 'logic');

set_type_rule ('string', ATTRIBUTION, '.+', 'string');
set_type_rule ('int', ATTRIBUTION, 'int|real|character', 'int');
set_type_rule ('real', ATTRIBUTION, 'int|real|character', 'real');
set_type_rule ('character', ATTRIBUTION, 'int|real|character', 'character');
set_type_rule ('logic', ATTRIBUTION, 'logic', 'logic');

function Type (symbol)
{
	this.symbol = symbol;
	this.get_type = function (node, err)
	{
		var v; 
		if (_.indexOf (STATEMENT_LIST, node.id)>=0)
		{
			var that = this;
			if (node.statements) _.each (node.statements, function (statement)
				{
					that.get_type (statement, err);
				});
			if (node.then) _.each (node.then, function (statement)
				{
					that.get_type (statement, err);
				});
			if (node.else) _.each (node.else, function (statement)
				{
					that.get_type (statement, err);
				});
		}
		// expression
		if (node.id === 'exp')
		{
			if (node.left && node.right)
			{
				node.type = select_type (this.get_type (node.left, err), node.op, this.get_type (node.right, err));
				// console.log (node);
				if (node.type === '' && node.left.type !== '' && node.right.type !== '' && err)
				{
					err (node.line, err.TYPE_EXPRESSION, {left: node.left.type, right: node.right.type, op: node.op}, 'Type expression error '+node.left.type+' '+node.op+' '+node.right.type);
				}
			}
			else
			if (node.value)
			{
				var t = node.type;
				if (!t || t === '') t = this.get_type (node.value, err);
				node.type = select_type (t, node.op, t);
				if (node.type === '' && node.value.type !== '' && err)
				{
					err (node.line, err.TYPE_EXPRESSION, {value: node.value.type, op: node.op}, 'Type expression error '+node.op+' '+node.value.type);
				}
			}
			return node.type;
		}
		else
		if (node.id === 'if' || node.id === 'while' || node.id === 'repeat')
		{
			var et = this.get_type (node.expression, err);
			if (et !== 'logic')
			{
				if (err) err (node.line, err.TYPE_EXPRESSION, {expression: et, op: node.id}, node.id+' expression is '+et+' instead of logic');
			}
		}
		else
		if (node.id === 'for')
		{
			var tfrom = select_type ('real', ATTRIBUTION, this.get_type (node.from, err));
			v = this.symbol.search_variable_symbol (node.symbol, node.variable, node.line);
			if (v)
			{
				var tvariable = select_type (v.type, ATTRIBUTION, tfrom);
				var tto = select_type ('real', ATTRIBUTION, this.get_type (node.to, err));
				// var tstep = select_type ('real', ATTRIBUTION, this.get_type (node.step, err));
				if (tvariable === '' && v)
				{
					if (err) err (node.line, err.TYPE_EXPRESSION, {expression: node.variable.t, op: 'for', element: 'variable'}, 'for variable expression is '+node.variable.t+' instead of charcter/real/int');
				}
				if (tfrom === '' && node.from.t !== '')
				{
					if (err) err (node.line, err.TYPE_EXPRESSION, {expression: node.from.t, op: 'for', element: 'from'}, 'for from expression is '+node.from.t+' instead of charcter/real/int');
				}
				if (tto === '' && node.to.t !== '')
				{
					if (err) err (node.line, err.TYPE_EXPRESSION, {expression: node.to.t, op: 'for', element: 'to'}, 'for to expression is '+node.to.t+' instead of charcter/real/int');
				}
				// if (tstep === '' && node.step.t !== '')
				// {
				// 	if (err) err (node.line, err.TYPE_EXPRESSION, {expression: node.step.t, op: 'for', element: 'step'}, 'for step expression is '+node.step.t+' instead of charcter/real/int');
				// }
			}
			else
			if (err)
			{
				err (node.line, err.UNDEFINED_VARIABLE, {variable: node.variable}, 'Undefined variable '+node.variable);
			}
		}
		else
		if (node.id === 'value') { 
			// console.log (node); 
			return node.type;
		}
		else
		if (node.id === 'dispatch') 
		{
			var f = this.symbol.search_function_symbol (node.symbol, node.message);
			// console.log (f);
			if (f) 
			{
				for (var parameterIndex in node.parameters)
				{
					var parameter = node.parameters[parameterIndex];
					var tp = this.get_type (parameter, err);
					var p = this.symbol.search_parameter_symbol  (node.symbol, node.message, parameterIndex);
					tp = select_type (p.type, ATTRIBUTION, tp);
					if (tp === '' && p.type !== '' && parameter.type !== '' && err)
					{
						err (node.line, err.TYPE_EXPRESSION, {to: p.type, from:parameter.t, op: ':='}, 'Type expression '+p.type+' := '+parameter.t);
					}
				}
				node.type = f.type;
				return f.type;
			}
			else 
			{
				node.type = '';
				if (err)
				{
					err (node.line, err.UNDEFINED_FUNCTION, {id: node.message.title}, 'Undefined message '+node.message.title);
				}
			}
		}
		else
		if (node.id === 'identifier')
		{
			// console.log (node);
			v = this.symbol.search_variable_symbol (node.symbol, node.title, node.line);
			if (v)
			{
				node.type = v.type;
				return v.type;
			}
			else 
			{
				node.type = '';
				if (err)
				{
					err (node.line, err.UNDEFINED_VARIABLE, {variable: node.title}, 'Undefined variable '+node.title);
				}
			}
		}
		else
		if (node.id === 'property')
		{
			node.type = '';
			this.get_type (node.object, err);
			console.log (node);
			var s = this.symbol.search_type_symbol (node.symbol, node.object.type);
			if (s)
			{
				// console.log ('s');
				// console.log (s);
				if (s.type === 'class')
				{
					var element = _.find (s.elements, function (e)
					{
						if (e.title === node.element) return true;
						else return false;
					});
					if (element) 
					{
						node.type = element.type;
						return element.type;
					}
					else if (err)
					{
						// console.log (s);
						err (node.line, err.NOT_STRUCT_ELEMENT, {class: node.object.type, element: node.element}, node.element+' is not a struct\'s '+node.object.type+' element');
					}
				}
				else
				if (err)
				{
					err (node.line, err.NOT_STRUCT, {type: s.type}, s.type+' is not a class');
				}
			}
			else
			if (err)
			{
				err (node.line, err.NOT_STRUCT, {type: node.object.type}, node.object.type+' is not a class');
			}
			// else 
			// {
			// 	if (err)
			// 	{
			// 		err (node.line, err.UNDEFINED_VARIABLE, {variable: node.id}, 'Undefined variable '+node.id);
			// 	}
			// }
		}
		else
		if (node.id === 'element_of_list')
		{
			node.type = '';
			this.get_type (node.list, err);
			var array = this.symbol.search_type_symbol (node.symbol, node.list, node.line);
			// console.log ('list');
			var tarray;
			if (array)
			{
				if (array.type === 'list') 
				{
					if (err)
					{
						tarray = this.get_type (node.index, err);
						if (tarray !== 'int' && tarray !== 'character')
						{
							if (err) err (node.line, err.ARRAY_INDEX_TYPE, {array: node.list, index: tarray}, 'Array ('+node.list+') index must be int or character');
						}
					}
					node.type = array.elements_type;
					return array.elements_type;
				}
				else
				if (array.type === 'string') 
				{
					if (err)
					{
						tarray = this.get_type (node.index, err);
						if (tarray !== 'int' && tarray !== 'character')
						{
							if (err) err (node.line, err.ARRAY_INDEX_TYPE, {array: 'string', index: tarray}, 'Array ('+node.list+') index must be int or character');
						}
					}
					node.type = 'character';
					return 'character';
				}
				else
				if (err)
				{
					err (node.line, err.NOT_ARRAY, {type: node.list}, node.list+' is not list');
				}
			}
			else
			if (err)
			{
				err (node.line, err.NOT_ARRAY, {type: node.list}, node.list+' is not list');
			}
			// else if (err)
			// {
			// 	err (node.line, err.UNDEFINED_VARIABLE, node.id, 'Undefined variable '+v.id);
			// }
		}
		else
		if (node.id === 'return')
		{
			node.type = '';
			var return_type = this.symbol.return_type(node.symbol);
			if (!return_type) 
			{
				return_type = '';
				node.type = return_type;
				if (err) err (node.line, err.VALUE_OUTSIDE_FUNCTION, {}, 'return is used out of a message');
			}

			node.type = return_type;

			var tvalue = this.get_type (node.value, err);
			
			if (tvalue!== '')
			{
				tvalue = select_type (return_type, ATTRIBUTION, tvalue);
			}
			
			if (tvalue === '' && node.value !== '' && err)
			{
				err (node.line, err.TYPE_EXPRESSION, {op: 'return', required: return_type, value: node.type}, 'Type expression error value '+node.type);
			}

			return return_type;
		}
		else
		if (node.id === 'set')
		{
			// console.log (node);
			var attributiontto = this.get_type (node.to, err);
			var attributiontfrom = this.get_type (node.from, err);
			// console.log (attributiontto);
			// console.log (attributiontfrom);
			var tattribution = select_type (attributiontto, ATTRIBUTION, attributiontfrom);
			if (tattribution === '' && err)
			{
				err (node.line, err.TYPE_EXPRESSION, {op:':=', to: attributiontto, from: attributiontfrom}, 'Type expression error '+attributiontto+' := '+attributiontfrom);
			}
			// node.type = tattribution;
		}
		return '';
	};

	this.symbol_type = function ()
	{
		var solved = 0;
		var that = this;
		function solve (err)
		{
			var solved = 0;
			var symbol_table = that.symbol.symbol_table ();
			for (var index in symbol_table)
			{
				var variables = symbol_table[index].variables;
				var functions = symbol_table[index].functions;
				var types = symbol_table[index].types;
				for (var typeIndex in types)
				{
					var type = types[typeIndex];
					if (type.type === 'class')
					{
						for (var elementIndex in type.elements)
						{
							var element = type.elements[elementIndex];
							if (element.type === "")
							{
								var t = that.get_type (element.value, err);
								// console.log (t);
								if (t === "")
								{
									if (err) err (element.line, err.TYPE_RESOLUTION, {class: typeIndex, element: element.id}, 'Unable to resolve type for struct\'s '+typeIndex+' element '+element.id);
								}
								else
								{
									solved = solved + 1;
									element.type = t;
								}
							}
						}
					}
					else
					if (type.type === "")
					{
						var tvalue = that.get_type (type.value, err);
						if (tvalue === "")
						{
							// if (err) err (element.line, err.TYPE_RESOLUTION, {class: type.id, element: element.id}, 'Unable to resolve type for struct\'s '+type.id+' element '+element.id);
						}
						else
						{
							solved = solved + 1;
							type.type = tvalue;
						}
					}
				}

				for (var variableIndex in variables)
				{
					var variable = variables[variableIndex];
					var tv;
					if (variable.value)
					{
						tv = that.get_type (variable.value, err);
					}
					if (variable.type === '')
					{
						if (tv === '')
						{
							if (err) err (variable.line, err.TYPE_RESOLUTION, {variable: variableIndex}, 'Unable to resolve type variable '+variableIndex);
						}
						else
						{
							solved = solved + 1;
							variable.type = tv;
						}
					}
					else
					if (err && variable.type !== 'int' && variable.type !== 'character' && variable.type !== 'real' && variable.type !== 'string' && variable.type !== 'logic' && variable.type !== 'none')
					{
						tv = that.symbol.search_type_symbol (index, variable.type);
						if (!tv)
						{
							if (err) err (variable.line, err.UNDEFINED_TYPE, {variable: variable.title, type: variable.type}, 'Type '+variable.type+' is not defined');
						}
					}
					else
					{
						if (variable.value && tv !== variable.type)
						{
							if (err) err (variable.line, err.TYPE_EXPRESSION, {to: variable.type, from:tv, op: ':='}, 'Type expression '+variable.type+' := '+tv);
						}
					}
				}

				for (var functionIndex in functions)
				{
					var fn = functions[functionIndex];
					var tf;
					for (var parameterIndex in fn.parameters)
					{
						var parameter = fn.parameters[parameterIndex];
						if (parameter.type === '')
						{
							tf = that.get_type (parameter.value, err);
							if (tf === '')
							{
								if (err) err (parameter.line, err.TYPE_RESOLUTION, {variable: parameter.title}, 'Unable to resolve type variable '+parameter.title);
							}
							else
							{
								solved = solved + 1;
								parameter.type = tf;
							}
						}
						else
						if (err && parameter.type !== 'int' && parameter.type !== 'character' && parameter.type !== 'real' && parameter.type !== 'string' && parameter.type !== 'logic' && parameter.type !== 'none')
						{
							tf = that.symbol.search_type_symbol (index, parameter.type);
							if (!tf)
							{
								if (err) err (parameter.line, err.UNDEFINED_TYPE, {variable: parameter.title, type: parameter.type}, 'Type '+parameter.type+' is not defined');
							}
						}
					}
				}
			}
			return solved;
		}
		var s;
		do
		{
			s = solve ();
		} while (s !== 0);

		solve (error);

	};
}

// type function

function select_type (t1, o, t2)
{
	var t = '';
	var typeIndex = 0;
	var typestr = t1+'.'+o+'.'+t2;
	// console.log (typestr);
	do
	{
		// console.log (TYPE_RULES[typeIndex]);
		if (typestr.match (TYPE_RULES[typeIndex].regex)) t = TYPE_RULES[typeIndex].value;
		typeIndex = typeIndex + 1;
	} while (t=== '' && typeIndex < TYPE_RULES.length);
	return t;
}

module.exports = Type;
module.exports.select_type = select_type;
