unit lab9;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls;

type
  TForm2 = class(TForm)
    scrlbr1: TScrollBar;
    scrlbr2: TScrollBar;
    scrlbr3: TScrollBar;
    rg1: TRadioGroup;
    lbl1: TLabel;
    lbl2: TLabel;
    lbl3: TLabel;
    btn1: TButton;
    lbl4: TLabel;
    lbl5: TLabel;
    lbl6: TLabel;
    pgc1: TPageControl;
    ts1: TTabSheet;
    ts2: TTabSheet;
    btn2: TButton;
    dlgFont1: TFontDialog;
    rg2: TRadioGroup;
    ts3: TTabSheet;
    lbl7: TLabel;
    edt1: TEdit;
    dlgColor1: TColorDialog;
    btn3: TButton;
    procedure scrlbr1Change(Sender: TObject);
    procedure btn1Click(Sender: TObject);
    procedure scrlbr2Change(Sender: TObject);
    procedure scrlbr3Change(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btn2Click(Sender: TObject);
    procedure btn3Click(Sender: TObject);
    procedure edt1Exit(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

uses lab8;

{$R *.dfm}

procedure TForm2.scrlbr1Change(Sender: TObject);
begin
  lbl4.Caption := IntToStr(scrlbr1.Position);
  case rg1.ItemIndex of
     0: Form1.color := RGB(scrlbr1.Position,scrlbr2.Position,scrlbr3.Position) ;
     1: Form1.cht1.Color := RGB(scrlbr1.Position,scrlbr2.Position,scrlbr3.Position);
   end;
  lbl1.Font.Color := RGB(scrlbr1.Position,0,0) ;
end;

procedure TForm2.btn1Click(Sender: TObject);
begin
  case rg1.ItemIndex of
     0: Form1.color := RGB(scrlbr1.Position,scrlbr2.Position,scrlbr3.Position) ;
     1: Form1.cht1.Color := RGB(scrlbr1.Position,scrlbr2.Position,scrlbr3.Position);

   end;

end;

procedure TForm2.scrlbr2Change(Sender: TObject);
begin
  lbl5.Caption := IntToStr(scrlbr2.Position);
  case rg1.ItemIndex of
     0: Form1.color := RGB(scrlbr1.Position,scrlbr2.Position,scrlbr3.Position) ;
     1: Form1.cht1.Color := RGB(scrlbr1.Position,scrlbr2.Position,scrlbr3.Position);
   end;
  lbl2.Font.Color := RGB(0,scrlbr2.Position,0) ;
end;

procedure TForm2.scrlbr3Change(Sender: TObject);
begin
  lbl6.Caption := IntToStr(scrlbr3.Position);
  case Form2.rg1.ItemIndex of
     0: Form1.color := RGB(scrlbr1.Position,scrlbr2.Position,scrlbr3.Position) ;
     1: Form1.cht1.Color := RGB(scrlbr1.Position,scrlbr2.Position,scrlbr3.Position);
   end;
   lbl3.Font.Color := RGB(0,0,scrlbr3.Position) ;
end;

procedure TForm2.FormCreate(Sender: TObject);
begin
  edt1.Text := '100';
  lbl1.Font.Color := RGB(scrlbr1.Position,0,0) ;
  lbl2.Font.Color := RGB(0,scrlbr2.Position,0);
  lbl3.Font.Color := RGB(0,0,scrlbr3.Position);
end;

procedure TForm2.btn2Click(Sender: TObject);
begin
  if dlgFont1.Execute then
  begin

    case rg2.ItemIndex of
    0: Form1.pgc1.Font := dlgFont1.Font;
    1: Form1.Font := dlgFont1.Font;
    end;
  end;
end;

procedure TForm2.btn3Click(Sender: TObject);
begin
  if dlgColor1.Execute then
  begin
    colorofanimation := dlgColor1.Color;
  end;
end;

procedure TForm2.edt1Exit(Sender: TObject);
begin
  Form1.tmr1.Interval := StrtoInt(edt1.Text);
end;

end.
