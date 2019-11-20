unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TForm1 = class(TForm)
    edt1: TEdit;
    edt2: TEdit;
    edt3: TEdit;
    lbl1: TLabel;
    lbl2: TLabel;
    lbl3: TLabel;
    lbl4: TLabel;
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
edt1.Text := '3,4';
edt2.Text := '3,7';
edt3.Text := '4,4';

mmo1.Clear;
mmo1.Lines.Add('Лa6.раб.N1. Ст.гр. 10801118 Воробей И.А.')
end;

procedure TForm1.btn1Click(Sender: TObject);
var
  x,y,z,u, a ,b: extended;

begin
x :=StrToFloat(Edt1.Text);
mmo1.Lines.Add('Х = '+Edt1.Text);
y :=StrToFloat(Edt2.Text);
mmo1.Lines.Add('Y = '+Edt2.Text);
z :=StrToFloat(Edt3.Text);
mmo1.Lines.Add('Z = '+Edt3.Text);
a:=Abs(Exp((y/x)*ln(x))-exp((1/3)*ln(y/x)));
b:=(y-x)*(Cos(y)-(z/(y-x)))/(1+(y-x)*(y-x));
u:=a+b;
Mmo1.Lines.Add('Результат U:= '+FloatToStrF(u,fffixed,8,3));


end;

end.
