program lab55;

uses
  Forms,
  lab5 in 'lab5.pas' {Form1},
  moduleforlab7 in 'moduleforlab7.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
