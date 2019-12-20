unit lab8;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, TeEngine, Series, Buttons, StdCtrls, ExtCtrls, TeeProcs, Chart, Math,
  Menus, ComCtrls, ToolWin, ImgList, IniFiles;

type
  TForm1 = class(TForm)
    cht1: TChart;
    sinxSeries1: TLineSeries;
    il1: TImageList;
    pgc1: TPageControl;
    ts2: TTabSheet;
    lbl1: TLabel;
    lbl2: TLabel;
    lbl3: TLabel;
    lbl4: TLabel;
    lbl7: TLabel;
    lbl6: TLabel;
    lbl5: TLabel;
    edt1: TEdit;
    edt2: TEdit;
    edt3: TEdit;
    edt4: TEdit;
    edt7: TEdit;
    edt6: TEdit;
    edt5: TEdit;
    ts3: TTabSheet;
    rg1: TRadioGroup;
    mm1: TMainMenu;
    N3: TMenuItem;
    N4: TMenuItem;
    N5: TMenuItem;
    N6: TMenuItem;
    N1: TMenuItem;
    N2: TMenuItem;
    tlb1: TToolBar;
    btn1: TToolButton;
    btn2: TToolButton;
    btn3: TToolButton;
    btn4: TToolButton;
    pb1: TPaintBox;
    tmr1: TTimer;
    N7: TMenuItem;
    procedure N3Click(Sender: TObject);
    procedure btn1Click(Sender: TObject);
    procedure btn2Click(Sender: TObject);
    procedure btn3Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure edt1Enter(Sender: TObject);
    procedure edt2Enter(Sender: TObject);
    procedure edt3Enter(Sender: TObject);
    procedure edt4Enter(Sender: TObject);
    procedure edt7Enter(Sender: TObject);
    procedure edt6Enter(Sender: TObject);
    procedure edt5Enter(Sender: TObject);
    procedure rg1Click(Sender: TObject);
    procedure N1Click(Sender: TObject);
    procedure N2Click(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure N5Click(Sender: TObject);
    procedure N6Click(Sender: TObject);
    procedure btn4Click(Sender: TObject);
    procedure pb1Paint(Sender: TObject);
    procedure tmr1Timer(Sender: TObject);
    procedure N7Click(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  Xmin, Xmax, Ymin, Ymax, Hx, Hy, h : extended;
  Ini : TIniFile;
  choice : Integer;
  colorofanimation : Integer;

implementation

{$R *.dfm}

uses lab9   ;

procedure TForm1.N3Click(Sender: TObject);

begin
  Close;
end;

procedure TForm1.btn1Click(Sender: TObject);
begin
  N1.OnClick(Sender);
end;

procedure TForm1.btn2Click(Sender: TObject);
begin
  N2.Click;
end;

procedure TForm1.btn3Click(Sender: TObject);
begin
  Close;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin

  choice := 0;
  Ini:=TiniFile.Create(extractfilepath(paramstr(0))+'Lab10.ini');
  Form1.Width:=Ini.ReadInteger('Size','Width',100);
  Form1.Height:=Ini.ReadInteger('Size','Height',100);
  Form1.Left:=Ini.ReadInteger('Position','X',10);
  Form1.Top:=Ini.ReadInteger('Position','Y',10);
  Form1.Color := Ini.ReadInteger('Form settings','color',0);
  cht1.Color := Ini.ReadInteger('Form settings','colorofcht',0);
  Form1.Font.Size := Ini.readInteger('Font','formfontsize',0);
  Form1.Font.Color := Ini.readInteger('Font','formfontcolor',0);
  Form1.Font.Name := Ini.ReadString('Font','formfontname','0');
  pgc1.Font.Size := Ini.readInteger('Font','pgcfontsize',0);
  pgc1.Font.Color := Ini.readInteger('Font','pgcfontcolor',0);
  pgc1.Font.Name := Ini.ReadString('Font','pgcontname','0');
  colorofanimation := Ini.ReadInteger('Animation','color',clBlue);
  tmr1.Interval := Ini.ReadInteger('Animation','speed',500);
  edt1.Text := '-3,14';
  edt2.Text := '3,14';
  edt3.Text := '-1,0';
  edt4.Text := '1,0';
  edt5.Text := '0,5';
  edt6.Text := '0,5';
  edt7.Text := '0,1';
  N2.Click;
  N1.Click;
end;

procedure TForm1.edt1Enter(Sender: TObject);
begin
   N2.Click;
   N1.Click;
end;

procedure TForm1.edt2Enter(Sender: TObject);
begin
  N2.Click;
   N1.Click;
end;

procedure TForm1.edt3Enter(Sender: TObject);
begin
  N2.Click;
   N1.Click;
end;

procedure TForm1.edt4Enter(Sender: TObject);
begin
N2.Click;
   N1.Click;
end;

procedure TForm1.edt7Enter(Sender: TObject);
begin
N2.Click;
   N1.Click;
end;

procedure TForm1.edt6Enter(Sender: TObject);
begin
N2.Click;
   N1.Click;
end;

procedure TForm1.edt5Enter(Sender: TObject);
begin
N2.Click;
   N1.Click;
end;

procedure TForm1.rg1Click(Sender: TObject);
begin
  N1.Click;
end;

procedure TForm1.N1Click(Sender: TObject);
  Var
    x, y2: extended;
begin
begin
  h := StrToFloat(edt7.Text);
  x := Strtofloat(edt1.Text);
  sinxSeries1.Clear;
  Repeat
    case rg1.ItemIndex of
     0: y2 := Cos(x);
     1: y2 := Sin(x);
     2: y2 := Tan(x);
     3: y2 := Cotan(x);
     4: y2 := 2 * Cos(x - Pi / 6) / ( 0.5 + Power(Sin(x),2)) * (1 + (Power(x,2)/(3 - (Power(x,2)/5))))
    end;

    sinxSeries1.AddXY(x, y2, '');
    x := x + h;
  Until (x > Xmax);
end;
end;

procedure TForm1.N2Click(Sender: TObject);
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

procedure TForm1.FormDestroy(Sender: TObject);
begin
  Ini := TIniFile.Create(ExtractFilePath(ParamStr(0))+'Lab10.ini');
  Ini.WriteInteger('Size','Width',form1.Width);
  Ini.WriteInteger('Size','Height',Form1.Height);
  Ini.WriteInteger('Position','X',form1.Left);
  Ini.WriteInteger('Position','Y',Form1.Top);
  Ini.WriteInteger('Form settings','color',Form1.Color);
  Ini.WriteInteger('Form settings','colorofcht',cht1.Color);
  Ini.WriteInteger('Font','formfontsize',Form1.Font.Size);
  Ini.WriteInteger('Font','formfontcolor',Form1.Font.Color);
  Ini.WriteString('Font','formfontname',Form1.Font.Name);
  Ini.WriteInteger('Font','pgcfontsize',pgc1.Font.Size);
  Ini.WriteInteger('Font','pgcfontcolor',pgc1.Font.Color);
  Ini.WriteString('Font','pgcfontname',pgc1.Font.Name);
  Ini.WriteInteger('Animation','speed',tmr1.Interval);
  Ini.WriteInteger('Animation','color',colorofanimation);

  Ini.Free;
end;

procedure TForm1.N5Click(Sender: TObject);
begin
  if (not Assigned(Form2)) then
   Form2:=TForm2.Create(Self);
   Form2.pgc1.TabIndex := 0;
   Form2.ShowModal;
end;

procedure TForm1.N6Click(Sender: TObject);
begin
   if (not Assigned(Form2)) then
   Form2:=TForm2.Create(Self);
   Form2.pgc1.TabIndex := 1;
   Form2.ShowModal;
end;

procedure TForm1.btn4Click(Sender: TObject);
begin
  if (not Assigned(Form2)) then
   Form2:=TForm2.Create(Self);
   Form2.ShowModal;
end;

procedure ClearPaintBox(Sender:TObject);
begin
  with Form1.pb1.Canvas do
  begin
      Form1.pb1.Canvas.Brush.Color:=Form1.Color;
      Form1.pb1.Canvas.FillRect(Rect(0,0,Form1.pb1.Width,Form1.pb1.Height));
  end;
end;

procedure TForm1.pb1Paint(Sender: TObject);
var
  x1,y1,x2,y2 : Integer;

begin
  x1 := 0;
  y1 := 0;
  x2 := 40;
  y2 := 40;
  with Form1.pb1, canvas do
    begin
      Brush.Color := colorofanimation;
      if choice = 0 then
      begin
        Pie(x1,y1,x2,y2,40,20,20,0);
      end;
      if choice = 1 then
      begin
        Pie(x1,y1,x2,y2,40,40,40,0);
      end;
      if choice = 2 then
      begin
        Pie(x1,y1,x2,y2,20,40,40,20);
      end;
      if choice = 3 then
      begin
        Pie(x1,y1,x2,y2,0,40,40,40);
      end;
      if choice = 4 then
      begin
        Pie(x1,y1,x2,y2,0,20,20,40);
      end;
      if choice = 5 then
      begin
        Pie(x1,y1,x2,y2,0,0,0,40);
      end;
      if choice = 6 then
      begin;
        Pie(x1,y1,x2,y2,20,0,0,20);
      end;
      if choice = 7 then
      begin
        Pie(x1,y1,x2,y2,40,0,0,0);
      end;
    end;
end;

procedure TForm1.tmr1Timer(Sender: TObject);
begin
   ClearPaintBox(Sender);
   pb1Paint(Sender);
   choice := choice + 1;
   if choice > 7 then
   begin
      choice := 0;
   end;
end;

procedure TForm1.N7Click(Sender: TObject);
begin
  if (not Assigned(Form2)) then
   Form2:=TForm2.Create(Self);
   Form2.pgc1.TabIndex := 2;
   Form2.ShowModal;
end;

end.
