unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TForm1 = class(TForm)
    edt1: TEdit;
    lbl1: TLabel;
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

Mmo1.Clear;
mmo1.Lines.Add('Lab 3, Ivan Varabei.');
mmo1.Lines.Add('Дано натуральное число n. Найти сумму его цифр.');
btn1Click(Sender);
//btn1.Click
end;

procedure TForm1.btn1Click(Sender: TObject);
var
  n, s: integer;
begin
  N := StrToInt(Edt1.Text);
 Mmo1.Lines.Add('N = ' + Edt1.Text);
  s := 0;
  while n > 0 do
  begin
    s := s + n mod 10;
    n := n div 10;
  end;
  Mmo1.Lines.Add('Sum of digits = ' + FloatToStrF(s, ffFixed, 6, 0) );
  mmo1.Lines.Add('');

 end;
end.
