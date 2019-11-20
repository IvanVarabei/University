unit shifr;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ActnList, Menus;

type
  TForm1 = class(TForm)
    edt1: TEdit;
    edt2: TEdit;
    edt4: TEdit;
    btn1: TButton;
    btn2: TButton;
    lbl1: TLabel;
    lbl2: TLabel;
    lbl3: TLabel;
    lbl4: TLabel;
    edt3: TEdit;
    edt5: TEdit;
    lbl5: TLabel;
    chk1: TCheckBox;
    chk2: TCheckBox;
    lbl8: TLabel;
    procedure btn1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btn2Click(Sender: TObject);
    procedure btn3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses shifr2,shifr3;

{$R *.dfm}

var
  alphabet: array[0..25] of Char = ('A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z');
  t,dt,raz,mistakes: string;
  k,m,f,i,j,y,x,a,z : Integer;
  mis : Boolean;

procedure NOK(a:Integer;b:Integer);
begin
  while a<>b do
    if a > b then a := a - b
    else b := b - a;
    if a = 1 then Form1.chk1.Checked := True
    else Form1.chk1.Checked := False;
end;

procedure TForm1.btn1Click(Sender: TObject);
begin
   k := StrToInt(edt5.Text);
   f := 0;
   NOK(k,26);
   dt := '';
   t := edt1.Text;
   t := AnsiUpperCase(t);
   if (chk1.Checked = True) or (chk2.Checked = True) then
   begin
     for i := 0 to Length(t) do
       begin
          for j := 0 to 25 do
            begin
              if alphabet[j] = t[i] then
                begin
                    x := (j * k + f) mod m;
                    dt := dt + alphabet[x];
                end;
            end;
          if t[i] = ' ' then dt := dt + ' ';
       end;
     edt2.Text := dt;
     chk2.Checked := False;
   end
   else form2.Show;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  m := 26;
  //lbl7.Caption := 'm = ' + IntToStr(m);
  lbl8.Caption := 'Ek(i) = (i * ko) mod n; n =26'
end;

procedure TForm1.btn2Click(Sender: TObject);
begin
  k := StrToInt(edt5.Text);
  f := 0;
  raz := '';
  t := edt3.Text;
  mistakes := '';
  for i := 0 to Length(t) do
  begin
    mis := False;
    for z:= 0 to 25 do
    begin
      y := (z * k + f) mod m;
      if alphabet[y] = t[i]  then
      begin
         if mis then
         begin
           mistakes := mistakes + IntToStr(i) + ' ';
           Break;
         end
         else
         begin
           raz := raz + alphabet[z];
           mis := True;
         end;
      end;
    end;
  end;
    if t[i] = ' ' then raz := raz + ' ';
  if mistakes <> '' then
  begin
    form3.lbl1.Caption := 'Errors are possible in decription letters nuber ' + #13 + #10 + mistakes;
    form3.Show;
  end;
  edt4.Text := raz;
end;
procedure TForm1.btn3Click(Sender: TObject);
begin
   Form2.show();
end;

end.

