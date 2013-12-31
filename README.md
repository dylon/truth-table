truth-table
===========

Parses boolean arithmetic expressions and generates corresponding truth tables.

Usage
-----

```html
<script type="text/javascript"
	src="http://dylon.github.com/truth-table/javascripts/v1.0/truth-table.js">
</script>
```

```javascript
var data = truthTable.parse('x !y + z (x y)');
var params = data.params; // distinct parameters of expression, e.g. ['x', 'y', 'z']
var expression = data.expression; // contains the parsed expression in various forms
var js = expression.js; // JavaScript expression, e.g. 'x && !y || z && (x && y)'
var tex = expression.tex; // LaTeX expression, e.g. 'x \\land \\lnot y \\lor z \\land \\left(x \\land y\\right)'
var fn = data.fn; // function having an arity of the number of parameters,
                  // where the parameters are specified in the order of params.

var truth = fn(true, false, true); //-> true
```
