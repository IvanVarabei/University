unit Unit2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls;

type
  TForm2 = class(TForm)
    shp1: TShape;
    rg1: TRadioGroup;
    btn1: TButton;
    procedure btn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

{$R *.dfm}

procedure TForm2.btn1Click(Sender: TObject);
begin
case rg1.ItemIndex of
  0: begin
      shp1.shape := stCircle;
      shp1.Brush.Color := clRed;
      end;
  1: begin
      shp1.shape := stSquare;
      shp1.Brush.Color := clWhite;
      end;
  2: begin
      shp1.shape := stRectangle;
      shp1.Brush.Color := clGreen;
      end;
  3: begin
      shp1.shape := stRoundSquare;
      shp1.Brush.Color := clGray;
      end;
end;
end;

end.
