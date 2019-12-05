unit lab3;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Math, moduleforlab7;

type
  TForm1 = class(TForm)
    mmo1: TMemo;
    btn1: TButton;
    btn2: TButton;
    lbl5: TLabel;
    lbl1: TLabel;
    edt1: TEdit;
    edt2: TEdit;
    rg1: TRadioGroup;
    lbl2: TLabel;
    btn3: TButton;
    procedure FormCreate(Sender: TObject);
    procedure btn2Click(Sender: TObject);
    procedure btn1Click(Sender: TObject);
    procedure btn3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  I : TStudent;

implementation

uses lab9;

{$R *.dfm}


procedure TForm1.FormCreate(Sender: TObject);

begin
  with I do
  begin
    FIO := 'Varabei ';
    Group := 10701118;
  end;  
  edt2.Text := '1,0';
  edt1.Text := '1,0';
  rg1.ItemIndex := 0;
  mmo1.Clear;
end;

procedure TForm1.btn2Click(Sender: TObject);
begin
  mmo1.Clear;
  with I do
  begin
    mmo1.Lines.Add(FIO + IntToStr(Group));
  end;
end;

procedure TForm1.btn1Click(Sender: TObject);

var
    x,y,fx,result :Extended;


begin
   x := StrToFloat(edt2.Text);
   y := StrToFloat(edt1.Text);
   case rg1.ItemIndex of
     0: fx := Sh(x);
     1: fx := x2(x);
     2: fx := ex(x,exponent);
   end;
   if (x * y > 0) then
   begin
    result := Power((fx + y),2) - Sqrt(fx * y);
   end
   else if  (x * y < 0) then
   begin
    result := Power((fx + y),2) - Sqrt(Abs(fx * y));
   end
   else
   begin
    result := Power((fx + y),2) + 1;
   end;
   mmo1.Lines.Add('X = ' + edt2.Text + #13 + #10 + 'Y = ' + edt1.Text + #13 + #10 + 'f(x) = ' + rg1.Items[rg1.itemindex] + #13 + #10 + 'A = ' + FloatToStr(result) + #13 + #10 );
end;
procedure TForm1.btn3Click(Sender: TObject);
begin
  if (not Assigned(Form2)) then
       Form2:=TForm2.Create(Self);
   //Form2.Visible:=true;
   Form2.ShowModal();
end;

end.
