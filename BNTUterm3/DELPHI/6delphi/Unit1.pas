unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons;

type
  TForm1 = class(TForm)
    dlgOpen1: TOpenDialog;
    dlgSave1: TSaveDialog;
    edt1: TEdit;
    edt2: TEdit;
    edt3: TEdit;
    mmo1: TMemo;
    lbl1: TLabel;
    lbl2: TLabel;
    lbl3: TLabel;
    btn2: TButton;
    btn3: TButton;
    btn4: TButton;
    btn1: TButton;
    btn5: TButton;
    btn6: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure btn1Click(Sender: TObject);
    procedure btn2Click(Sender: TObject);
    procedure btn3Click(Sender: TObject);
    procedure btn4Click(Sender: TObject);
    procedure btn5Click(Sender: TObject);
    procedure btn6Click(Sender: TObject);
    Procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  Type
  TStudent = record
    FIO  : string[40];          //���� �.�.�.
    otc  : array[1..3] of Integer; //���� ������� ������
    sball  : extended;          //���� �������� �����
  end;
var
  Fz   : file of Tstudent;      //���� ���� ������
  Ft   : TextFile;              //��������� ����
  Stud : array[1..100] of Tstudent; //������ �������
  Nzap : integer;                //����� ������
  FileNameZ, FileNameT : string; //��� �����


var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
begin
Edt1.Text := '';
  Edt2.Text := '';
  Edt3.Text := '';
  Mmo1.Clear;
  Btn1.Hide; //������� ��������� ������ "������ ������"
  Nzap := 0;
end;

procedure TForm1.btn1Click(Sender: TObject);
begin
nzap := nzap + 1;
  with stud[nzap] do
  begin
    FIO    := Edt1.Text;
    otc[1] := StrToInt(Edt2.Text);
    otc[2] := StrToInt(Edt3.Text);
    sball  := (otc[1] + otc[2] )/2;
    Mmo1.Lines.Add(fio + ' , Amount=' + IntToStr(otc[2]) +
    ', Workshop �' + IntToStr(otc[1 ]));
  end;

  Write(fz, Stud[nzap]);   //������ � ����
  Edt1.Text := '';
  Edt2.Text := '';
  Edt3.Text := '';

end;

procedure TForm1.btn2Click(Sender: TObject);
begin
    dlgOpen1.Title := '������� ����� ����';
// ��������� ��������� ���� �������
   if dlgOpen1.Execute then
// ���������� ������������ ������� ������ ����� �����
  begin
    FileNameZ := dlgOpen1.FileName;
//  ����������� ����� ��������� �����
    AssignFile(Fz, FileNameZ);
//  ���������� �������� ���������� Fz � ������ �����
    Rewrite(Fz);  //�������� ������ �����
    Btn1.Show; //������� ������� ������ "������ ������"
  end;

end;

procedure TForm1.btn3Click(Sender: TObject);
begin
    if dlgOpen1.Execute then
//���������� ������������ ������� ������ ����� �����
  begin
    FileNameZ := dlgOpen1.FileName;
//  ����������� ����� ��������� �����
    AssignFile(Fz, FileNameZ);
//  ���������� �������� ���������� Fz � ������ �����
    Reset(Fz); //�������� ������������� �����
  end;

  While not EOF(fz) do
  begin
    nzap := nzap + 1;
    Read(fz, stud[nzap]);  //������ ������ �� �����
    with stud[nzap] do
      Mmo1.Lines.Add(fio + ' , Amount=' + IntToStr(otc[2]) +
    ', Workshop �' + IntToStr(otc[1 ]));
    end;
    Btn1.Show; //������� ������� ������ "������ ������"

end;

procedure TForm1.btn4Click(Sender: TObject);
// ���������� �������
var
  i, j : word;
  st   : Tstudent;
begin
  for i := 1 to nzap-1 do
  for j := i + 1 to nzap do
  if Stud[i].sball < Stud[j].sball then
  begin
    st := Stud[i];
    Stud[i] := Stud[j];
    Stud[j] := st;
  end;

  Mmo1.Clear;
  for i := 1 to nzap do
// ����� � ���� Memo1 ��������������� �������
  with stud[i] do
    Mmo1.Lines.Add(fio + ' , Amount=' + IntToStr(otc[2]) +
    ', Workshop �' + IntToStr(otc[1 ]));


end;

procedure TForm1.btn5Click(Sender: TObject);
// ����������� ����������� ���������� � ��������� �����
var
  i : word;
begin
  if dlgSave1.Execute then
// ���������� ������������ ������� ������ ����� �����
  begin
    FileNameT := dlgSave1.FileName;
//  ����������� ����� ��������� �����
    AssignFile(Ft, FileNameT);
//  ���������� �������� ���������� Ft � ������ �����
    Rewrite(Ft); //�������� ������ ���������� �����
    for i:=1 to nzap do
  with stud[i] do
    //Writeln(Ft, i:4, '.', fio, sball:8:2);
    Writeln(Ft, i:4, '  ', fio, sball:8:2,'  ',otc[1 ]);
//  ������ � ��������� ����
    CloseFile(Ft); //�������� ���������� �����

   end;
end;

procedure TForm1.btn6Click(Sender: TObject);
begin
 CloseFile(fz);
// �������� ����� ������� ��� ������� �� ������ "Close"


end;

Procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  CloseFile(fz);
// �������� ����� ������� ��� ������� �� ������
end;


end.
