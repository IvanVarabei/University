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
    FIO  : string[40];          //Поле ф.и.о.
    otc  : array[1..3] of Integer; //Поле массива оценок
    sball  : extended;          //Поле среднего балла
  end;
var
  Fz   : file of Tstudent;      //Файл типа запись
  Ft   : TextFile;              //Текстовой файл
  Stud : array[1..100] of Tstudent; //Массив записей
  Nzap : integer;                //Номер записи
  FileNameZ, FileNameT : string; //Имя файла


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
  Btn1.Hide; //Сделать невидимой кнопку "Ввести запись"
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
    ', Workshop №' + IntToStr(otc[1 ]));
  end;

  Write(fz, Stud[nzap]);   //Запись в файл
  Edt1.Text := '';
  Edt2.Text := '';
  Edt3.Text := '';

end;

procedure TForm1.btn2Click(Sender: TObject);
begin
    dlgOpen1.Title := 'Создать новый файл';
// Изменение заголовка окна диалога
   if dlgOpen1.Execute then
// Выполнение стандартного диалога выбора имени файла
  begin
    FileNameZ := dlgOpen1.FileName;
//  Возвращение имени дискового файла
    AssignFile(Fz, FileNameZ);
//  Связывание файловой переменной Fz с именем файла
    Rewrite(Fz);  //Создание нового файла
    Btn1.Show; //Сделать видимой кнопку "Ввести запись"
  end;

end;

procedure TForm1.btn3Click(Sender: TObject);
begin
    if dlgOpen1.Execute then
//Выполнение стандартного диалога выбора имени файла
  begin
    FileNameZ := dlgOpen1.FileName;
//  Возвращение имени дискового файла
    AssignFile(Fz, FileNameZ);
//  Связывание файловой переменной Fz с именем файла
    Reset(Fz); //Открытие существующего файла
  end;

  While not EOF(fz) do
  begin
    nzap := nzap + 1;
    Read(fz, stud[nzap]);  //Чтение записи из файла
    with stud[nzap] do
      Mmo1.Lines.Add(fio + ' , Amount=' + IntToStr(otc[2]) +
    ', Workshop №' + IntToStr(otc[1 ]));
    end;
    Btn1.Show; //Сделать видимой кнопку "Ввести запись"

end;

procedure TForm1.btn4Click(Sender: TObject);
// Сортировка записей
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
// Вывод в окно Memo1 отсортированных записей
  with stud[i] do
    Mmo1.Lines.Add(fio + ' , Amount=' + IntToStr(otc[2]) +
    ', Workshop №' + IntToStr(otc[1 ]));


end;

procedure TForm1.btn5Click(Sender: TObject);
// Сохраниение результатов сортировки в текстовом файле
var
  i : word;
begin
  if dlgSave1.Execute then
// Выполнение стандартного диалога выбора имени файла
  begin
    FileNameT := dlgSave1.FileName;
//  Возвращение имени дискового файла
    AssignFile(Ft, FileNameT);
//  Связывание файловой переменной Ft с именем файла
    Rewrite(Ft); //Открытие нового текстового файла
    for i:=1 to nzap do
  with stud[i] do
    //Writeln(Ft, i:4, '.', fio, sball:8:2);
    Writeln(Ft, i:4, '  ', fio, sball:8:2,'  ',otc[1 ]);
//  Запись в текстовой файл
    CloseFile(Ft); //Закрытие текстового файла

   end;
end;

procedure TForm1.btn6Click(Sender: TObject);
begin
 CloseFile(fz);
// Закрытие файла записей при нажатии на кнопку "Close"


end;

Procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  CloseFile(fz);
// Закрытие файла записей при нажатии на кнопку
end;


end.
