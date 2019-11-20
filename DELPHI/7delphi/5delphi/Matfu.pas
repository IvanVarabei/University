unit Matfu;

interface
Function countWords(St: string) : Integer;
Function countSubstring(St: string; t2: string) : Integer;
implementation

Function countWords;
Var
  St1: string;
  n, i, ind, my ,j: integer;
begin
   n   := 0; //Содержит число слов выбранной строки                                                          //Содержит число слов
  ind := 0;
  for i := 1 to Length(St) do
  begin
    Case ind of
      0: if St[i] <>' ' then
         begin
            j:=i;
            my:=0;
            while (St[j]<>' ') and (j<=Length(St)) do
            begin
              my:=my+1;
              j:=j+1;
            end;
            if my=5 then
                n := n+1;
           ind := 1;
         end;
// Если встретился пробел после символов
      1: if St[i] =' ' then ind := 0;
     end;
   end;
   Result:=n;
end;

Function countSubstring;
Var
  St1: string;
  i, cn2: integer;
begin
  St1:=' '+St+' ';
  cn2:=0;
   for i := 1 to Length(St1) do
      begin
        if  pos(t2,St1)>0 then
        begin
         Delete(St1,1,pos(t2,St1)+Length(t2));
         cn2:=cn2+1;
               end;
       end;
Result:=cn2;
end;
end.
