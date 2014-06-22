// Jison parser grammar
//
// This file, along with tokens.jisonlex, is compiled to parser.js.
//
// Jison doc: http://zaach.github.io/jison/docs/#specifying-a-language
// Jison is a port of Bison (in C). The format grammar is the same.
// Bison doc: http://dinosaur.compilertools.net/bison/bison_6.html#SEC34
//
// Based on http://www.w3.org/TR/CSS21/syndata.html#syntax

%{
  import nodes._
%}

DIGIT                 [0-9]
NUMBER                {DIGIT}+(\.{DIGIT}+)? // matches: 10 and 3.14
NAME                  [a-zA-Z][\w\-]*       // matches: body, background-color and myClassName
SELECTOR              (\.|\#|\:\:|\:){NAME} // matches: #id, .class, :hover and ::before

%%

//// Rules
\s+           // ignore spaces, line breaks

// Numbers
{NUMBER}{px|em|\%}    return 'DIMENSION' // 10 px, 1em, 50%
{NUMBER}        return 'NUMBER' // 0
\#[0-9A-Fa-f]{3-6}    return 'COLOR' // #fff, #f0f0f0

// Selectors
{SELECTION}       return 'SELECTOR' // .class, #id
{NAME}{SELECTOR}    return 'SELECTOR' // div.class, body#id

{NAME}          return 'IDENTIFIER' // body, font-size

.           return yytext // {, }, +, :, ;

<<EOF>>               return 'EOF'


%%

// Parsing starts here.
stylesheet:
  rules EOF                   { return new nodes.StyleSheet($1) }
;

rules:
  rule                        { $$ = [ $1 ] }
| rules rule                  { $$ = $1.concat($2)}
;

rule:
  selector '{' properties '}' { $$ = new nodes.Rules($1, $3)}
;

selector:
  IDENTIFIER
| SELECTOR
;

properties:
  /* empty */                 { $$ = [] }
  property                    { $$ = [ $1 ] }
| properties ';' property     { $$ = $1.concat($3)}
| properties ';'		      { $$ = $1 }
;

property:
  IDENTIFIER ':' values       { $$ = new nodes.Property($1, $3)}
;

values:
  value                       { $$ = [ $1 ] }
| values value                { $$ = $1.concat($2)}
;

value:
  IDENTIFIER
| COLOR
| NUMBER
| DIMENSION
;