unit shifr2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TForm2 = class(TForm)
    btn1: TButton;
    btn2: TButton;
    lbl1: TLabel;
    lbl2: TLabel;
    procedure btn1Click(Sender: TObject);
    procedure btn2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

uses shifr;

{$R *.dfm}

procedure TForm2.btn1Click(Sender: TObject);
begin
  Form1.chk2.Checked := True;
  Form2.Close();
end;

procedure TForm2.btn2Click(Sender: TObject);
begin
  Form1.chk2.Checked := False;
  Form2.Close;
end;

end.
