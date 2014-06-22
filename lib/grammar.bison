%{
  import nodes._
%}

%%

//// Rules
\s+                   // ignore spaces, line breaks

[0-9]                 return 'DIGIT';
{DIGIT}+(\.{DIGIT}+)? return 'NUMBER';    //matches: 10 and 3.14
[a-zA-Z][\w\-]*       return 'NAME';      //matches: body, back-color and myClassName
(\.|\#|\:\:|\:){NAME} return 'SELECTOR';  // matches: #id, .class, :hover and ::before

// Numbers
{NUMBER}{px|em|\%}    return 'DIMENSION'; // 10 px, 1em, 50%
{NUMBER}              return 'NUMBER';    // 0
\#[0-9A-Fa-f]{3-6}    return 'COLOR';     // #fff, #f0f0f0

// Selectors
{SELECTION}           return 'SELECTOR';  // .class, #id
{NAME}{SELECTOR}      return 'SELECTOR';  // div.class, body#id

{NAME}                return 'IDENTIFIER';// body, font-size

.                     return yytext;      // {, }, +, :, ;

<<EOF>>               return 'EOF'; 


%%

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
