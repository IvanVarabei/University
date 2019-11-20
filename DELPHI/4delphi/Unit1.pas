unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, StdCtrls;

type
  TForm1 = class(TForm)
    strngrd1: TStringGrid;
    edt1: TEdit;
    lbl1: TLabel;
    lbl2: TLabel;
    edt2: TEdit;
    btn1: TButton;
    btn2: TButton;
    lbl3: TLabel;
    lbl4: TLabel;
    lbl5: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure btn1Click(Sender: TObject);
    procedure btn2Click(Sender: TObject);
    procedure strngrd1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
  private
    { Private declarations }
  public
    { Public declarations }
  end;
const
  Nmax = 6; // Максимальная размерность массива
type
  //Mas2 = array[1..Nmax, 1..Nmax] of Extended; // Объявление типа двумерного массива
  Mas2 = array of array of extended;


var
  Form1: TForm1;
  //A : Mas2;     // Объявление двумерного массива
  A : array of array of Extended;
  n_r,n_c, i, j : integer;


implementation

{$R *.dfm}

function look_to_max(u: integer):Extended;
var
  Max : Extended;
  ii : Integer;
begin
  Max := a[u,1];
     For ii := 1 to n_c do
          if a[u,ii]>Max then Max := a[u,ii];
  look_to_max:=Max;
end;

procedure TForm1.FormCreate(Sender: TObject);
var rand: Integer;
begin
  n_r := 3; // Размерность массива
  n_c :=2;
  Edt1.Text := FloatToStr(n_r);
  Edt2.Text := FloatToStr(N_c);
  strngrd1.RowCount := n_r + 1;
  strngrd1.ColCount := n_c + 1;
  for i:=1 to N_r do
    for j:=1 to N_c do
    begin
      //rand:=Random(15);
      strngrd1.Cells[j, i]:=IntToStr(0);
    end;

end;

procedure TForm1.btn1Click(Sender: TObject);
begin
  n_r := StrToInt(Edt1.Text);
  n_c := StrToInt(Edt2.Text);
  strngrd1.RowCount := n_r + 1;
  strngrd1.ColCount := n_c + 1;
  for i:=1 to N_r do
  begin
    strngrd1.Cells[0, i] := 'i=' + IntToStr(i);
  end;
  for i:=1 to N_c do
  begin
    strngrd1.Cells[i, 0] := 'j=' + IntToStr(i);
  end;
    for i:=1 to N_r do
    for j:=1 to N_c do
      strngrd1.Cells[j, i]:=IntToStr(0);
end;

procedure TForm1.btn2Click(Sender: TObject);
var
  s : extended;
  it,k,je : Integer;
begin
// Заполнение массива A элементами из тавлицы StringGrid1
  SetLength(A,n_r+1,n_c+1);
  for i:=1 to N_r do
    for j:=1 to N_c do
      A[i, j] := StrToFloat(strngrd1.Cells[j, i]);

  for it := 1 to n_r-1 do
    for je := 1 to n_r-it do
      if look_to_max(je) >= look_to_max(je+1) then
      begin
             for k:=1 to N_c do
              begin
                 s:= a[je,k];
                 a[je, k] := a[je+1, k] ;
                 a[je+1,k]:=s;
              end;

               end;

      for i:=1 to N_r do
        for j:= 1 to n_c  do
             strngrd1.Cells[j,i] := FloatToStrF(a[i,j], ffFixed,6,0);
      A:=NIL;
end;

procedure TForm1.strngrd1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var ACol,Arow:Integer;
begin
  strngrd1.MouseToCell(X,Y,ACol,ARow);
  strngrd1.Col:=ACol;
  strngrd1.Row:=Arow;
  lbl5.Caption := '['+IntToStr(Arow)+','+IntToStr(Acol)+']';
  lbl4.Caption := strngrd1.Cells[Acol, Arow];
end;
end.



