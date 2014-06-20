// Jison lexer grammar
//
// http://zaach.github.io/jison/docs/#lexical-analysis
// http://dinosaur.compilertools.net/flex/flex_6.html#SEC6
//
// Order is important. Rules are matches from top to bottom.

//// Macros
DIGIT                 [0-9]
NUMBER                {DIGIT}+(\.{DIGIT}+)? // matches: 10 and 3.14
NAME                  [a-zA-Z][\w\-]*       // matches: body, background-color and myClassName
SELECTOR              (\.|\#|\:\:|\:){NAME} // matches: #id, .class, :hover and ::before

%%

//// Rules
\s+					  // ignore spaces, line breaks

// Numbers
{NUMBER}{px|em|\%}	  return 'DIMENSION' // 10 px, 1em, 50%
{NUMBER}			  return 'NUMBER' // 0
\#[0-9A-Fa-f]{3-6}	  return 'COLOR' // #fff, #f0f0f0

// Selectors
{SELECTION}			  return 'SELECTOR' // .class, #id
{NAME}{SELECTOR}	  return 'SELECTOR' // div.class, body#id

{NAME}				  return 'IDENTIFIER' // body, font-size

.					  return yytext // {, }, +, :, ;

<<EOF>>               return 'EOF'
