program lab33;

uses
  Forms,
  lab3 in 'lab3.pas' {Form1},
  moduleforlab7 in 'moduleforlab7.pas',
  lab9 in 'lab9.pas' {Form2};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
