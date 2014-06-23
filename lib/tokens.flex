%{
    using namespace std;    
    #define YY_DECL extern "C" int yylex()
}


DIGIT                 [0-9]
NUMBERS               {DIGIT}+(\.{DIGIT}+)?
[a-zA-Z][\w\-]*       NAME
(\.|\#|\:\:|\:){NAME} SELECTOR

%%

[ \s+ ]

NUMBER[px|em|\%]      { return 'DIMENSION'; }
{NUMBER}              { return 'NUMBER'; }
\#[0-9A-Fa-f]{3-6}    { return 'COLOR'; }

{SELECTOR}            { return 'SELECTOR'; }
{NAME}{SELECTOR}      { return 'SELECTOR'; }

{NAME}                { return 'IDENTIFIER'; }

.                     { return yytext; }

<<EOF>>               { return 'EOF'; }

%%