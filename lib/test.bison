%token <int> NUMBER
%token <int> DIGIT
%type  <int> item

%%

item
          : NUMBER { $$ = 10000000; }
          | DIGIT         { $$ = $1; }
          | '-' DIGIT     { $$ = -$2; }
;
%%
