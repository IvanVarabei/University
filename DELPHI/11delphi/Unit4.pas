unit Unit4;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls;

type
  TForm4 = class(TForm)
    rg1: TRadioGroup;
    btn1: TButton;
    procedure rg1Click(Sender: TObject);
    procedure btn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form4: TForm4;

implementation

uses Unit1, Unit2, Unit3;

{$R *.dfm}

procedure TForm4.rg1Click(Sender: TObject);
begin
  Form1.hide;
  Form2.hide;
  Form3.hide;
  case rg1.ItemIndex of
    0:Form1.show;
    1:Form2.show;
    2:Form3.show;
  end;
end;

procedure TForm4.btn1Click(Sender: TObject);
begin
  Form1.Close;
  Form2.Close;
  Form3.Close;
  Form4.Close;
end;

end.
