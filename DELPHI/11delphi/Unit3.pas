unit Unit3;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls;

type
  TForm3 = class(TForm)
    pb1: TPaintBox;
    tmr1: TTimer;
    rg1: TRadioGroup;
    procedure tmr1Timer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure rg1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form3: TForm3;
  choice: Integer;

implementation

uses Unit1;

{$R *.dfm}
procedure TForm3.FormCreate(Sender: TObject);
begin
  choice := 0;
end;

procedure ClearPaintBox(Sender:TObject);
begin
  with Form3.pb1.Canvas do
  begin
      Form3.pb1.Canvas.Brush.Color:=Form3.Color;
      Form3.pb1.Canvas.FillRect(Rect(0,0,Form3.pb1.Width,Form3.pb1.Height));
  end;
end;

procedure pb1Paint(Sender: TObject);
begin
  with Form3.pb1, canvas do
    begin
      if choice = 0 then
      begin
      Brush.Color := clBlue;
      Polygon([Point(50,50),Point(100,50),Point(75,100)]);
      end;
      if choice = 1 then
      begin
      Brush.Color := clGreen;
      Polygon([Point(100,50),Point(125,100),Point(75,100)]);
      end;
      if choice = 2 then
      begin
      Brush.Color := clRed;
      Polygon([Point(100,50),Point(150,50),Point(125,100)]);
      end;
      if choice = 3 then
      begin
        Brush.Color := clYellow;
        Polygon([Point(125,100),Point(175,100),Point(150,50)]);
      end;
      if choice = 4 then
      begin
        Brush.Color := clPurple;
        Polygon([Point(175,100),Point(150,50),Point(200,50)]);
      end;
      if choice = 5 then
      begin
        Brush.Color := clNavy;
        Polygon([Point(200,50),Point(175,100),Point(225,100)]);
      end;
        Brush.color := clGreen;
        Pie(30,100,60,130,60,100,40,90);
        Brush.color := clRed;
        Pie(30,100,60,130,30,100,60,100);
    end;

end;

procedure TForm3.tmr1Timer(Sender: TObject);
begin
   pb1Paint(Sender);
   choice := choice + 1;
   if choice > 6 then
   begin
      choice := 0;
      ClearPaintBox(Sender);
   end;
end;



procedure TForm3.rg1Click(Sender: TObject);
begin
  case rg1.ItemIndex of
    0:tmr1.Interval := 200;
    1:tmr1.Interval := 500;
    2:tmr1.Interval := 1000;
  end;
end;

end.
