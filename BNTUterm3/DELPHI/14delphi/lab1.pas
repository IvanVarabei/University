unit lab1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Math;

type
  TForm1 = class(TForm)
    lbl1: TLabel;
    lbl2: TLabel;
    lbl3: TLabel;
    btn1: TButton;
    mmo1: TMemo;
    edt1: TEdit;
    edt2: TEdit;
    edt3: TEdit;
    lbl4: TLabel;
    btn2: TButton;
    procedure btn1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btn2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.btn1Click(Sender: TObject);
var X:Double; Y:Double; Z:Double; T:Double;
begin
    X := StrToFloat(edt1.Text);
    Y := StrToFloat(edt2.Text);
    Z := StrToFloat(edt3.Text);
    T := (2 * Cos(X - Pi/6)) / (0.5 + Power(Sin(Y),2)) * (1 + ((Power(Z,2) / (3 - Power(Z,2) / 5))));
    mmo1.Lines.Add('Лабораторная Работа 1 Карачинский А.А.' +#13 + #10 + 'X = ' + FloatToStr(X) + #13 + #10 + 'Y = ' + FloatToStr(Y) + #13 + #10+ 'Z = ' + FloatToStr(Z) + #13 + #10+ 'Результат равен ' + FloatToStrF(T,fffixed,8,4) + #13 + #10);
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
    mmo1.Text := Form1.Caption + #13 + #10;
end;

procedure TForm1.btn2Click(Sender: TObject);
begin
    mmo1.Clear;
end;

end.
