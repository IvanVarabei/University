unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons,Matfu;

type
  TForm1 = class(TForm)
    btn1: TBitBtn;
    cbb1: TComboBox;
    lbl1: TLabel;
    lbl2: TLabel;
    lbl3: TLabel;
    edt1: TEdit;
    lbl4: TLabel;
    lbl5: TLabel;
    lbl6: TLabel;
    procedure FormActivate(Sender: TObject);
    procedure cbb1KeyPress(Sender: TObject; var Key: Char);
    procedure cbb1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  fl: Integer;
implementation

{$R *.dfm}

procedure TForm1.FormActivate(Sender: TObject);
begin
cbb1.SetFocus;
cbb1.Items.Add('Default 12345 67891 end');
  cbb1.Items.Add('desireble desireble desireble desireble');
  Edt1.Text := 'desireble';
end;

procedure TForm1.cbb1KeyPress(Sender: TObject; var Key: Char);
begin
begin
  if Key =#13 then //Если нажата клавиша Enter то...
  begin
    cbb1.Items.Add(cbb1.Text);
    cbb1.Text := ''; //Очистка окна редактирования
  end;
end;
  end;
procedure TForm1.cbb1Click(Sender: TObject);
Var
  St ,t2: string;
  n, nst, cn2: integer;
begin
  nSt := cbb1.ItemIndex;//Занесение выбранной строки в переменную st
  St := cbb1.Items[nst];
  n:=countWords(St);
  t2 := Edt1.Text;
  cn2:=countSubstring(St,t2);
  lbl3.Caption := IntToStr(n);
  lbl6.Caption := IntToStr(cn2);
end;
end.
