program shifrovanie;

uses
  Forms,
  shifr in 'shifr.pas' {Form1},
  shifr2 in 'shifr2.pas' {Form2},
  shifr3 in 'shifr3.pas' {Form3};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TForm2, Form2);
  Application.CreateForm(TForm3, Form3);
  Application.Run;
end.
