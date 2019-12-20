unit lab3;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Math, moduleforlab7;

type
  TForm1 = class(TForm)
    lbl1: TLabel;
    edt1: TEdit;
    edt2: TEdit;
    rg1: TRadioGroup;
    lbl2: TLabel;
    procedure edt2Enter(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation



{$R *.dfm}


procedure TForm1.edt2Enter(Sender: TObject);
  var
    x,result :Extended;

begin
   x := StrToFloat(edt2.Text);
   case rg1.ItemIndex of
     0: result := (2 * Cos(x - Pi / 6) / ( 0.5 + Power(Sin(x),2)) * (1 + (Power(x,2)/(3 - (Power(x,2)/5)))));
     1: result := Sin(x);
     2: result := Cos(x);
     3: result := Tan(x);
     4: result := Cotan(x);
   end;
   edt1.Text := FloatToStr(result);

end;

end.
