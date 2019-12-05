unit moduleforlab7;

interface
  function Sh(x:Extended) : Extended;
  function x2(x:Extended) : Extended;
  function ex(x,e:Extended) : Extended;

type
  TStudent = record
  FIO : string[40];
  Group : Integer;
  end;

const
  exponent = 2.7;

implementation
uses
  Math;
  function Sh;
  begin
    Result :=  (Exp(x) - Exp(-x)) / 2;
  end;

  function x2;
  begin
    Result := x * x;
  end;

  function ex;
  begin
    Result := Power(e,x);
  end;      
end.
