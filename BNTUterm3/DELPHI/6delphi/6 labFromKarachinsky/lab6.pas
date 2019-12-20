unit lab6;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons;

type
  TForm1 = class(TForm)
    cbb1: TComboBox;
    cbb2: TComboBox;
    cbb3: TComboBox;
    edt1: TEdit;
    edt2: TEdit;
    edt3: TEdit;
    lbl1: TLabel;
    lbl2: TLabel;
    lbl3: TLabel;
    lbl4: TLabel;
    btn1: TButton;
    btn2: TButton;
    mmo1: TMemo;
    btn3: TButton;
    dlgOpen1: TOpenDialog;
    dlgSave1: TSaveDialog;
    btn4: TButton;
    btn5: TButton;
    btn6: TBitBtn;
    mmo2: TMemo;
    lbl5: TLabel;
    lbl6: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure btn1Click(Sender: TObject);
    procedure btn3Click(Sender: TObject);
    procedure btn4Click(Sender: TObject);
    procedure btn5Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btn2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;
Type
  TList = record
  FIO : string[40];
  Otdel : Integer;
  dolshnost : string[30];
  date : array[1..3] of Integer;
  end;


var
  Form1: TForm1;
  Filezap : file of TList;
  Filetext : TextFile;
  Workers : array[1..100] of TList;
  Nzap : Integer;
  FileNameZ, FileNameT : string;

implementation

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
begin
  cbb1.Text := '';
  cbb2.Text := '';
  cbb3.Text := '';
  edt1.Text := '08';
  edt2.Text := '11';
  edt3.Text := '2019';
  cbb1.Items.Add('Robert Brown');
  cbb1.Items.Add('Bob Canadian');
  cbb1.Items.Add('Prince Ea');
  cbb1.Items.Add('Liz White');
  cbb2.Items.Add('1');
  cbb2.Items.Add('2');
  cbb2.Items.Add('3');
  cbb3.Items.Add('Developer');
  cbb3.Items.Add('Manager');
  cbb3.Items.Add('Artist');
  cbb3.Items.Add('Designer');
  mmo1.Clear;
  mmo2.Clear;
  Nzap := 0;
  btn1.Hide;
end;

procedure TForm1.btn1Click(Sender: TObject);
begin
  Nzap := Nzap + 1;
  with Workers[Nzap] do
  begin
    FIO := cbb1.Text;
    Otdel := StrToInt(cbb2.Text);
    dolshnost := cbb3.Text;
    date[1] := StrToInt(edt1.Text);
    date[2] := StrToInt(edt2.Text);
    date[3] := StrToInt(edt3.Text);
    mmo2.Lines.Add(IntToStr(Nzap) + '. ' + FIO + '  ' + IntToStr(Otdel) + '  ' + dolshnost + '  ' + IntToStr(Date[1]) + '.' + IntToStr(Date[2]) + '.' + IntToStr(Date[3]));
  end;
  write(FileZap, Workers[Nzap]);
  cbb1.Text := '';
  cbb2.Text := '';
  cbb3.Text := '';
end;

procedure TForm1.btn3Click(Sender: TObject);
begin
  dlgOpen1.Title := 'Create new file';
  if dlgOpen1.Execute then
  begin
    FileNameZ := dlgOpen1.FileName;
    AssignFile(Filezap, FileNameZ);
    Rewrite(Filezap);
    btn1.Show;
  end;
end;

procedure TForm1.btn4Click(Sender: TObject);
var
  i:Integer;
begin
  if dlgOpen1.Execute then
  begin
    Nzap := 0;
    FileNameZ := dlgOpen1.FileName;
    AssignFile(Filezap,FileNameZ);
    Reset(Filezap);
  end;
  while not Eof(Filezap) do
  begin
    Nzap := Nzap + 1;
    Read(filezap, workers[nzap]);
    btn1.Show;
  end;
  btn1.Show;
  mmo2.Clear;
  mmo1.Clear;
  for i := 1 to Nzap do
  begin
    with Workers[i] do
    mmo2.Lines.Add(IntToStr(i) + '. ' + FIO + '  ' + IntToStr(Otdel) + '  ' + dolshnost + '  ' + IntToStr(Date[1]) + '.' + IntToStr(Date[2]) + '.' + IntToStr(Date[3]));
  end;


end;

procedure TForm1.btn5Click(Sender: TObject);
var
   i: word;
begin
   if dlgOpen1.Execute then
   begin
     FileNameT := dlgSave1.FileName;
     AssignFile(Filetext, FileNameT);
     Rewrite(Filetext);
   end;
   for i := 1 to Nzap do
   with Workers[i] do
   writeln(Filetext, i:4, '.', FIO,'.', Otdel,'.', dolshnost,'.',Date[1],'.',Date[2],'.',Date[3]);
   CloseFile(Filetext);
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  CloseFile(Filezap);
end;

procedure TForm1.btn2Click(Sender: TObject);
var
  i, j :Integer;
  st : Tlist;
begin
  for i := 1 to Nzap-1 do
  begin
    for j := i + 1 to Nzap do
    begin
      if Workers[i].Otdel > Workers[j].Otdel then
      begin
        st := Workers[i];
        Workers[i] := Workers[j];
        Workers[j] := st;
      end;  
    end;
  end;

  mmo1.Clear;
  for i := 1 to Nzap do
  begin
    with Workers[i] do
    mmo1.Lines.Add(IntToStr(i) + '. ' + FIO + '  ' + IntToStr(Otdel) + '  ' + dolshnost + '  ' + IntToStr(Date[1]) + '.' + IntToStr(Date[2]) + '.' + IntToStr(Date[3]))
  end;
end;

end.
