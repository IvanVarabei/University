unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls;

type
  TForm1 = class(TForm)
    edt1: TEdit;
    edt2: TEdit;
    lbl1: TLabel;
    lbl2: TLabel;
    lbl4: TLabel;
    mmo1: TMemo;
    btn1: TButton;
    rg1: TRadioGroup;
    chk1: TCheckBox;
  
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
mmo1.Clear;
rg1.ItemIndex:=0;
mmo1.Lines.Add('Labolatory project.N1. St.gr. 10701118 Воробей И.А.')
end;

procedure TForm1.btn1Click(Sender: TObject);
var
  x,p,u,e,l,ma: extended;

begin
x :=StrToFloat(Edt1.Text);
mmo1.Lines.Add('Х = '+Edt1.Text);
p :=StrToFloat(Edt2.Text);
mmo1.Lines.Add('P = '+Edt2.Text);
e:=exp(1);
u:=0;
case rg1.ItemIndex of
     0: u := (exp((x)*ln(e))-exp((-x)*ln(e)))/2;
     1: u := Exp(e*ln(x));
     2: u := x*x;
end;

if x>p then  l:=2*e*e*e+3*p*p;
if (3<x) and (x<Abs(p)) then l:=Abs(u-p);
if x=p  then l:=Exp(2*ln(u-p));

if chk1.Checked then
   begin
     x := abs(x);
     p := abs(p);
     u:= Abs(u);
   end;

if x>p then ma := x else ma := p;
if u>ma then ma := u;
if chk1.checked then
Mmo1.Lines.Add('maxabs='+FloatToStrF(ma,ffFixed,8,2));
Mmo1.Lines.Add('Результат l = '+FloatToStrF(l,fffixed,8,2));
//Mmo1.Lines.Add('Number of u(x) = '+FloatToStrF(rg1.ItemIndex,fffixed,8,0));

Mmo1.Lines.Add(rg1.Items[rg1.ItemIndex]+'='+ FloatToStr(u));
     //1: Mmo1.Lines.Add('U(x) = e^x = '+ FloatToStr(u));
     //2: Mmo1.Lines.Add('U(x) = x^2 = '+ FloatToStr(u));
//end;


end;
end.
