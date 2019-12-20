unit Main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, StdCtrls;

type
  TForm1 = class(TForm)
    StringGrid1: TStringGrid;
    StringGrid2: TStringGrid;
    Edit1: TEdit;
    Edit2: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Button1: TButton;
    Button2: TButton;
    Memo1: TMemo;
    lbl1: TLabel;
    lbl2: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure StringGrid1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  mas: array of integer;
  N, M : integer;

implementation

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
var
i, j : integer;

begin
  Memo1.Clear;
  Edit1.Text := '1';
  Edit2.Text := '1';

  StringGrid1.ColCount := 2;
  StringGrid1.RowCount := 2;

  StringGrid2.ColCount := 2;
  StringGrid2.RowCount := 2;

  for i:=1 to (StrToInt(Edit1.Text) + 1) do
  begin
    StringGrid1.Cells[0, i] := 'i='+ IntToStr(i);
    StringGrid2.Cells[0, i] := 'i='+ IntToStr(i);
  end;

  for i:=1 to (StrToInt(Edit2.Text) + 1) do
  begin
    StringGrid1.Cells[i, 0] := 'j='+ IntToStr(i);
    StringGrid2.Cells[i, 0] := 'j='+ IntToStr(i);
  end;

      StringGrid1.Cells[1, 1] := '0';
      StringGrid2.Cells[1, 1] := '0';
end;

procedure TForm1.Button1Click(Sender: TObject);

var
i, j : integer;
begin

  //Матрица 1
  StringGrid1.ColCount := StrToInt(Edit2.Text) + 1;
  StringGrid1.RowCount := StrToInt(Edit1.Text) + 1;
  //Матрица 2
  StringGrid2.ColCount := StrToInt(Edit2.Text) + 1;
  StringGrid2.RowCount := StrToInt(Edit1.Text) + 1;

  //индекс строк
  for i:=1 to (StrToInt(Edit1.Text) + 1) do
  begin
    StringGrid1.Cells[0, i] := 'i='+ IntToStr(i);
    StringGrid2.Cells[0, i] := 'i='+ IntToStr(i);
  end;
  //индекс столбцов
  for i:=1 to (StrToInt(Edit2.Text) + 1) do
  begin
    StringGrid1.Cells[i, 0] := 'j='+ IntToStr(i);
    StringGrid2.Cells[i, 0] := 'j='+ IntToStr(i);
  end;

  for i:= 1 to (StrToInt(Edit1.Text) + 1)  do
  begin
    for j:=1 to (StrToInt(Edit1.Text) + 1)  do
    begin
      StringGrid1.Cells[i, j] := '0';
      StringGrid2.Cells[i, j] := '0';
    end;
  end;

end;

procedure TForm1.Button2Click(Sender: TObject);
var
sum, max: integer;
i, j, z : integer;
temp : string;


begin
  N := StrToInt(Edit1.Text);
  M := StrToInt(Edit2.Text);
  SetLength(mas,N+1);

  //Перенос одной таблицы в другую
  for i:= 1 to N  do
  begin
    for j := 1 to M do
    begin
      StringGrid2.Cells[j,i] := StringGrid1.Cells[j,i];
    end;
  end;

  for i:=1 to N do
  begin
    max := StrToInt(StringGrid1.Cells[1,i]);
    for j:=1 to M do
    begin
      if  max < StrToInt(StringGrid1.Cells[j,i]) then
          max:= StrToInt(StringGrid1.Cells[j,i]);

    end;
      mas[i] := max ;
  end;

  for z:= 1 to N-1 do
      for i:=1 to N-z do
          if mas[i] >= mas[i+1] then
            begin
              for j:= 1 to M  do
                begin
                  temp := StringGrid2.Cells[j,i+1];
                  StringGrid2.Cells[j,i+1] := StringGrid2.Cells[j,i];
                  StringGrid2.Cells[j,i] := temp;
                end;
                temp := IntToStr(mas[i+1]);
                mas[i+1] := mas[i];
                mas[i] := StrToInt(temp);
          end;

  end;


procedure TForm1.StringGrid1MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  _col, _row: Integer;
begin
  StringGrid1.MouseToCell(X, Y, _col, _row);
  Memo1.Clear;
  Memo1.Lines.Add('Amount : ' + StringGrid1.Cells[_col,_row]
  +',  [' + IntToStr(_row) + ',' + IntToStr(_col)+']' );
end;

end.
