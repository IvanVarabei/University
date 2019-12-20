unit lab4;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, StdCtrls;

type
  TForm1 = class(TForm)
    lbl1: TLabel;
    edt1: TEdit;
    btn1: TButton;
    strngrd1: TStringGrid;
    btn2: TButton;
    mmo1: TMemo;
    btn3: TButton;
    edt2: TEdit;
    edt3: TEdit;
    lbl3: TLabel;
    lbl4: TLabel;
    lbl5: TLabel;
    edt4: TEdit;
    lbl2: TLabel;
    procedure btn1Click(Sender: TObject);
    procedure btn2Click(Sender: TObject);
    procedure btn3Click(Sender: TObject);
    procedure strngrd1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  N, M, i, j, k, rand : Integer;
  issim : Boolean;

implementation

{$R *.dfm}

procedure TForm1.btn1Click(Sender: TObject);
begin
   N := StrToInt(edt1.Text);
   M := StrToInt(edt4.Text);
   mmo1.Clear;
   strngrd1.ColCount := N + 1;
   strngrd1.RowCount := M + 1;
   for i:=1 to strngrd1.ColCount do
   begin
     strngrd1.Cells[i, 0] := IntToStr(i);
   end;
   for i:=1 to strngrd1.RowCount do
   begin
     strngrd1.Cells[0, i] := IntToStr(i);
   end;  
end;

procedure TForm1.btn2Click(Sender: TObject);

var
  A:array of array of Integer;
  incorrect: Boolean;

begin
  incorrect := False;
  N := StrToInt(edt1.Text);
  M := StrToInt(edt4.Text);
  SetLength(A,N,M);
  for j:= 1 to M do
  begin
    for i:= 1 to N do
    begin
       if strngrd1.Cells[i,j] = '' then
       incorrect := True;
    end;
  end;
  if incorrect then
  begin
    mmo1.Lines.Add('Заполните массив!');
  end
  else
  begin
    for k:= 1 to M do
    begin
    for i:= 1 to N do
    begin
      A[i-1][k - 1] := StrToInt(strngrd1.Cells[i,k]);
    end;
    end;
    for k := 0 to M - 1 do
    begin
    j := N - 1;
    for i:= 0 to N - 1 do
    begin
      if A[i][k] <> A[j][k] then
      begin
        issim := False;
        Break;
      end
      else issim := True;
      j := j - 1;
    end;
    if issim then mmo1.Lines.Add('строка ' + IntToStr(k + 1) + ' симметрична')
    else mmo1.Lines.Add('строка ' + IntToStr(k + 1) + ' не симметрична');
    end;
    end;

end;

procedure TForm1.btn3Click(Sender: TObject);
begin
  for j:=1 to strngrd1.RowCount - 1 do
  begin
  for i:=1 to strngrd1.ColCount - 1 do
  begin
    rand := StrToInt(edt2.Text) + Random(StrToInt(edt3.Text)-StrToInt(edt2.Text));
    strngrd1.Cells[i, j] := IntToStr(rand);
  end;
  end;
end;

procedure TForm1.strngrd1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
   lbl5.Caption := 'Выделенная строка: [' + IntToStr(strngrd1.Row) + ']';
   strngrd1.Selection := tgridrect(Rect(strngrd1.Row,strngrd1.Col,strngrd1.Row + 1,strngrd1.Col + 1));
end;

end.
