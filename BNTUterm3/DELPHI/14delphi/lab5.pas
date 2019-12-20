unit lab5;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, IniFiles, lab9;

type
  TForm1 = class(TForm)
    cbb1: TComboBox;
    mmo1: TMemo;
    btn1: TButton;
    lbl1: TLabel;
    btn2: TBitBtn;
    edt1: TEdit;
    btn3: TButton;
    btn4: TButton;
    procedure cbb1KeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure btn1Click(Sender: TObject);
    procedure btn3Click(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btn4Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  

implementation

{$R *.dfm}

procedure TForm1.cbb1KeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    cbb1.Items.Add(cbb1.Text);
    cbb1.Text := '';
  end;
end;

procedure TForm1.FormCreate(Sender: TObject);
var
  Ini: Tinifile;
begin
  Ini:=TiniFile.Create(extractfilepath(paramstr(0))+'MyIni.ini');
  Form1.Width:=Ini.ReadInteger('Size','Width',100);
  Form1.Height:=Ini.ReadInteger('Size','Height',100);
  Form1.Left:=Ini.ReadInteger('Position','X',10);
  Form1.Top:=Ini.ReadInteger('Position','Y',10);
  Form1.Color := Ini.ReadInteger('Form settings','color',0);
  mmo1.Color := Ini.ReadInteger('Form settings','colorofmemo',0);
  Form1.Font.Size := Ini.readInteger('Font','formfontsize',0);
  Form1.Font.Color := Ini.readInteger('Font','formfontcolor',0);
  Form1.Font.Name := Ini.ReadString('Font','formfontname','0');
  mmo1.Font.Size := Ini.readInteger('Font','memofontsize',0);
  mmo1.Font.Color := Ini.readInteger('Font','memofontcolor',0);
  mmo1.Font.Name := Ini.ReadString('Font','memofontname','0');

  cbb1.Items.Add('Delphi project');
  cbb1.Items.Add('Приветсвую вас');
  cbb1.Items.Add('советую юутевос');
  cbb1.Items.Add('строка');
  cbb1.Items.Add('схс');
  mmo1.Clear;
end;

procedure TForm1.btn1Click(Sender: TObject);
var
  s:string;
  i,j:Integer;
  check:Boolean;

begin
  s := cbb1.Text;
  if s = '' then mmo1.Lines.Add('Введите текст')
  else
  begin
  s := AnsiLowerCase(s);
  s := Trim(s);
  j := Length(s);
  check := True;
  for i:=1 to Length(s) do
  begin
    if AnsiCompareStr(s[i],s[j]) <> 0 then
    begin
      check := False;
      Break;
    end;
    j := j - 1;
  end;
  if check then
  begin
    mmo1.Lines.Add('Строка "' + cbb1.Text + '" является полиндромом');
  end
  else mmo1.Lines.Add('Строка "' + cbb1.Text + '" не является полиндромом');
  end;
  end;

var
  find,str,stri : string;
  ind,counter : Integer;
procedure TForm1.btn3Click(Sender: TObject);
begin
  counter := 0;
  ind := -1;
  find := edt1.Text;
  if find = '' then mmo1.Lines.Add('Введите подстроку')
  else
  begin
    find := AnsiLowerCase(find);
    str := AnsiLowerCase(cbb1.Text);
    str := Trim(str);
    while ind <> 0 do
    begin
      ind := 0;
      ind := Pos(find,str);
      Delete(str,1,ind + Length(find) - 1);
      if ind <> 0 then counter := counter + 1
      else Break;
    end;
  mmo1.Lines.Add('Данная строка встречается в тексте ' + IntToStr(counter) + ' раз');
  end;
  end;
procedure TForm1.FormDestroy(Sender: TObject);
var
  Ini: TIniFile;
begin
  Ini := TIniFile.Create(ExtractFilePath(ParamStr(0))+'MyIni.ini');
  Ini.WriteInteger('Size','Width',form1.Width);
  Ini.WriteInteger('Size','Height',Form1.Height);
  Ini.WriteInteger('Position','X',form1.Left);
  Ini.WriteInteger('Position','Y',Form1.Top);
  Ini.WriteInteger('Form settings','color',Form1.Color);
  Ini.WriteInteger('Form settings','colorofmemo',mmo1.Color);
  Ini.WriteInteger('Font','formfontsize',Form1.Font.Size);
  Ini.WriteInteger('Font','formfontcolor',Form1.Font.Color);
  Ini.WriteString('Font','formfontname',Form1.Font.Name);
  Ini.WriteInteger('Font','memofontsize',mmo1.Font.Size);
  Ini.WriteInteger('Font','memofontcolor',mmo1.Font.Color);
  Ini.WriteString('Font','memofontname',mmo1.Font.Name);

  Ini.Free;
end;

procedure TForm1.btn4Click(Sender: TObject);
begin
if (not Assigned(Form2)) then
   Form2:=TForm2.Create(Self);
   Form2.ShowModal;
end;

end.
