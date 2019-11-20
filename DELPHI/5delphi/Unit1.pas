unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons;

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
  St ,St1,t2: string;
  n, i, nst, ind, my ,j,flag,k, counter2,cn2: integer;

begin
   n   := 0; //Содержит число слов выбранной строки                                                          //Содержит число слов
  ind := 0;
  flag:=0;
//Определение номера выбранной строки
  nSt := cbb1.ItemIndex;
//Занесение выбранной строки в переменную st
  St := cbb1.Items[nst];
//Просмотр всех символов строки st
  for i := 1 to Length(St) do
  begin
    Case ind of
      0: if St[i] <>' ' then
         begin
            j:=i;
            my:=0;
            while (St[j]<>' ') and (j<=Length(St)) do
            begin
              my:=my+1;
              j:=j+1;
            end;
            if my=5 then
                n := n+1;
           ind := 1;
         end;
// Если встретился пробел после символов
      1: if St[i] =' ' then ind := 0;
     end;
   end;
   lbl3.Caption := IntToStr(n); //Вывод числа слов в Label3
   cn2:=0;
   t2 := Edt1.Text;

   St1:=' '+St+' ';
   for i := 1 to Length(St1) do
      begin
        if  pos(t2,St1)>0 then
        begin
         Delete(St1,1,pos(t2,St1)+Length(t2));
         cn2:=cn2+1;
               end;
       end;
   {St1:=' '+St+' ';
   for i := 1 to Length(St) do
      begin

         if (St1[i]=' ') and (St1[i+1]=t2[1]) then
            begin
               j:=i+1;
               k:=1;
               counter2:=0;
               while St1[j]=t2[k] do
               begin
                counter2:=counter2+1;
                j:=j+1;
                k:=k+1;
                end;
             if counter2=Length(t2) then
                cn2:=cn2+1;
          end;
       end;    }

       lbl6.Caption := IntToStr(cn2);
       end;
end.
