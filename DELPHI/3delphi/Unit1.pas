unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TForm1 = class(TForm)
    lbl1: TLabel;
    lbl2: TLabel;
    lbl3: TLabel;
    edt1: TEdit;
    edt2: TEdit;
    edt3: TEdit;
    mmo1: TMemo;
    btn1: TButton;
    procedure FormCreate(Sender: TObject);
    procedure btn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}


procedure TForm1.FormCreate(Sender: TObject);
begin
  mmo1.Clear;
  mmo1.Lines.Add('Results, option 9, Ivan Varabei 10701118');
end;

procedure TForm1.btn1Click(Sender: TObject);
Var
    x1, x2, x, h, a, s  : extended;
    N, k, c  ,i=0               : integer;

begin
x1 := StrToFloat(Edt1.Text);
   mmo1.Lines.Add('x1 = ' + edt1.Text);
   x2 := StrToFloat(edt2.Text);
Mmo1.Lines.Add('x2 = ' + Edt2.Text);
   N := StrToInt(Edt3.Text);
 Mmo1.Lines.Add('N = ' + edt3.Text);
 While i<=N do
begin
    x= Exp((2*n+1)*ln(x))
    n++;
end;


end;

end.
