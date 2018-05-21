// jshint node: true, loopfunc: true, esnext: true

"use strict";

var _ = require ('lodash');

var error = require ('./error.js');

function semantic (sourceStr)
{
	var ast = null;

	try
	{
		var SymbolAST = require ('./symbol.js');
		var Type = require ('./type.js');
		var s;
		var t;
		var output;
		
		if (_.isString (sourceStr))
		{
			var parser = require ('./grammar.js').parser;
			ast = parser.parse (sourceStr);

			var symbol_table = {};

			if (ast)
			{
				s = new SymbolAST (ast);

				// console.log (s);

				t = new Type (s);

				t.symbol_type ();

				// console.log (JSON.stringify (s.symbol_table (), null, 3));

				t.get_type (ast, error);

				s.replace_define (ast);

				symbol_table = s.symbol_table ();
			}
			else
			{
				ast = {};
			}

			output = {
				symbol: s,
				type: t,
				ast: ast,
				error_list: error.error_list ()
			};

			return output;
		}
		else
		{
			s = new SymbolAST (sourceStr.ast, sourceStr.symbol);
			output = {
				symbol: s,
				type: t,
				ast: sourceStr.ast,
				error_list: sourceStr.error_list
			};
			return output;
		}
	}
	catch (e)
	{
		console.log (e);
		// console.log (JSON.stringify(e, null, 4));
		// var parsererror = {};
		// if (!e.hash.token)
		// {
		// 	parsererror.error = 'lexical';
		// 	parsererror.line = (e.hash.line+1);
		// 	parsererror.text = e.message;
		// }
		// else
		// {
		// 	parsererror.error = 'syntax';
		// 	parsererror.line = (e.hash.line+1);
		// 	parsererror.text = e.hash.text;
		// 	parsererror.token = e.hash.token;
		// 	parsererror.expected = e.hash.expected;
		// }
		// // console.log (JSON.stringify (error, null, 4));
		// // fs.writeFileSync (foutname, JSON.stringify (error, null, 2));
		// var errortype = error.LEXICAL;
		// if (parsererror.error === 'syntax') errortype = error.SYNTAX;
		// error (parsererror.line, errortype, parsererror, parsererror.text);
	}
}

module.exports = semantic;
