unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, jpeg, StdCtrls, ExtDlgs, Menus;

type
  TForm1 = class(TForm)
    btn1: TButton;
    dlgOpenPic1: TOpenPictureDialog;
    pnl1: TPanel;
    img1: TImage;
    shp1: TShape;
    procedure btn1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses Unit2, Unit3, Unit4;

{$R *.dfm}

procedure TForm1.btn1Click(Sender: TObject);
begin
  if dlgOpenPic1.execute then
  begin

    img1.Picture.LoadFromFile(dlgOpenPic1.Filename);
    img1.Stretch := true;

  end;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
   Form2:=TForm2.Create(Self);
   Form3:=TForm3.Create(Self);
   Form4:=TForm4.Create(Self);
   Form4.show;
end;

end.
