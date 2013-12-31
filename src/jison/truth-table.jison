%lex

%%

\s+ /* Ignore White Space */

[a-zA-Z_][a-zA-Z0-9_]*\b return "IDENTIFIER";
"!"                      return "!";
"("                      return "(";
")"                      return ")";
"*"                      return "*";
"+"                      return "+";
<<EOF>>                  return "EOF";

/lex

%left identifier
%right "!"
%left "*"
%left "+"

%start statement

%%

statement: expression EOF %{
  var params = record.params();
  var expression = $1;
  var fn = new Function(params, "return " + expression + ";");
  return {
    params: params,
    expression: $1,
    fn: fn
  };
%};

expression:
  "(" expression ")" "(" expression ")"    { $$ = "(" + $2 + ") && (" + $5 + ")"; }
  | "(" expression ")" identifier          { $$ = "(" + $2 + ") && " + $4; }
  | "(" expression ")"                     { $$ = "(" + $2 + ")"; }
  | expression "+" expression              { $$ = $1 + " || " + $3; }
  | expression "*" expression              { $$ = $1 + " && " + $3; }
  | "!" expression                         { $$ = "!" + $2; }
  | identifier expression                  { $$ = $1 + " && " + $2; }
  | identifier                             { $$ = $1; }
  ;

identifier: IDENTIFIER %{
  $$ = record.param($1);
%};

%%

var record = {
  _params: {},
  param: function (x) {
    this._params[x] = true;
    return x;
  },
  params: function () {
    var param, params = [];
    for (param in this._params) {
      if (this._params.hasOwnProperty(param)) {
        params.push(param);
      }
    }
    return params;
  }
};

/* vim: set et sw=2 ts=2 sta ft=lex: */
