%%
[0-9]             {return DIGIT;}
DIGIT+(\.DIGIT+)? {return NUMBER;}
%%
