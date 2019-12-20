unit lab8;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, TeEngine, Series, Buttons, StdCtrls, ExtCtrls, TeeProcs, Chart, Math;

type
  TForm1 = class(TForm)
    edt1: TEdit;
    edt2: TEdit;
    edt3: TEdit;
    edt4: TEdit;
    edt5: TEdit;
    edt6: TEdit;
    lbl1: TLabel;
    lbl2: TLabel;
    lbl3: TLabel;
    lbl4: TLabel;
    lbl5: TLabel;
    lbl6: TLabel;
    cht1: TChart;
    btn1: TButton;
    btn2: TButton;
    btn3: TBitBtn;
    sinxSeries1: TLineSeries;
    edt7: TEdit;
    lbl7: TLabel;
    cosxSeries1: TLineSeries;
    procedure btn2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  Xmin, Xmax, Ymin, Ymax, Hx, Hy, h : extended;

implementation

{$R *.dfm}



procedure TForm1.FormCreate(Sender: TObject);
begin

  edt1.Text := '0,0';
  edt2.Text := '0,0';
  edt3.Text := '-1,0';
  edt4.Text := '1,0';
  edt5.Text := '0,5';
  edt6.Text := '0,5';
  edt7.Text := '0,01';

end;

procedure TForm1.btn1Click(Sender: TObject);
begin

  Xmin := StrToFloat(edt1.Text);
  Xmax := StrToFloat(edt2.Text);
  Ymin := StrToFloat(edt3.Text);
  Ymax := StrToFloat(edt4.Text);
  Hx := StrToFloat(edt5.Text);
  Hy := StrToFloat(edt6.Text);
  h := StrToFloat(edt7.Text);

  cht1.BottomAxis.Automatic := False;
  cht1.BottomAxis.Minimum := Xmin;
  cht1.BottomAxis.Maximum := Xmax;

  cht1.LeftAxis.Automatic := False;
  cht1.LeftAxis.Minimum   := Ymin;
  cht1.LeftAxis.Maximum   := Ymax;

  cht1.BottomAxis.Increment := Hx;
  cht1.LeftAxis.Increment   := Hy;
end;

procedure TForm1.btn2Click(Sender: TObject);
var
  x, y1, y2: extended;
begin
  h := StrToFloat(edt7.Text);
  x := Strtofloat(edt1.Text);
  sinxSeries1.Clear;
  cosxSeries1.Clear;
  Repeat
    y2 := Cos(x);
    y1 := 2 * Cos(x - Pi / 6) / ( 0.5 + Power(Sin(x),2)) * (1 + (Power(x,2)/(3 - (Power(x,2)/5))));
    sinxSeries1.AddXY(x, y1, '');
    cosxSeries1.AddXY(x, y2, '');
    x := x + h;
  Until (x > Xmax);
end;


end.
