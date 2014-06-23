%{
  import nodes._
%}

%union {
  int ival;
  float fval;
  char *sval;
}

%token <sval> IDENTIFIER
%token <sval> SELECTOR
%token <sval> COLOR
%token <sval> NUMBER
%token <sval> DIMENSION
%token        EOF

%type  <sval> value values property properties selector rules rule stylesheet IDENTIFIER SELECTOR COLOR NUMBER DIMENSION

%%

  stylesheet:
    rules EOF                   { return new nodes.StyleSheet($1); }
  ;

  rules:
    rule                        { $$ = [ $1 ]; }
  | rules rule                  { $$ = $1.concat($2);}
  ;

  rule:
    selector '{' properties '}' { $$ = new nodes.Rules($1, $3);}
  ;

  selector:
    IDENTIFIER
  | SELECTOR
  ;

  properties:
    /* empty */                 { $$ = []; }
    property                    { $$ = [ $1 ]; }
  | properties ';' property     { $$ = $1.concat($3);}
  | properties ';'              { $$ = $1; }
  ;

  property:
    IDENTIFIER ':' values       { $$ = new nodes.Property($1, $3);}
  ;

  values:
    value                       { $$ = [ $1 ]; }
  | values value                { $$ = $1.concat($2);}
  ;

  value:
    IDENTIFIER
  | COLOR
  | NUMBER
  | DIMENSION
;

%%