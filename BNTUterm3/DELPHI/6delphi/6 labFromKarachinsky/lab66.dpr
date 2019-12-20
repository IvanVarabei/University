program lab66;

uses
  Forms,
  lab6 in 'lab6.pas' {Form1};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
