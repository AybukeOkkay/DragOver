unit Unit1;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Layouts, FMX.Ani, FMX.Objects;

type
 TButton=class(FMX.StdCtrls.TButton)
  private
    FIsOk: Boolean;
    function GetData: Integer;
    procedure SetData(const Value: Integer);
    procedure SetIsOk(const Value: Boolean);
   published
   property IsOk:Boolean Read FIsOk Write SetIsOk;
   property Data:Integer Read GetData Write SetData;


 end;



  TForm1 = class(TForm)
    Layout1: TLayout;
    GridLayout1: TGridLayout;
    Layout2: TLayout;
    Layout3: TLayout;
    Layout4: TLayout;
    Label1: TLabel;
    LabelBestScore: TLabel;
    Label2: TLabel;
    LabelScore: TLabel;
    Button1: TButton;
    Rectangle1: TRectangle;
    Label3: TLabel;
    ButtonTrayAgain: TButton;
    FloatAnimationGameOver: TFloatAnimation;
    FloatAnimation2: TFloatAnimation;
    RectAnimation1: TRectAnimation;
    Button2: TButton;
    FloatAnimation3: TFloatAnimation;
    RectAnimation2: TRectAnimation;
    Button3: TButton;
    FloatAnimation4: TFloatAnimation;
    RectAnimation3: TRectAnimation;
    Button4: TButton;
    FloatAnimation5: TFloatAnimation;
    RectAnimation4: TRectAnimation;
    Button5: TButton;
    FloatAnimation6: TFloatAnimation;
    RectAnimation5: TRectAnimation;
    Button6: TButton;
    FloatAnimation7: TFloatAnimation;
    RectAnimation6: TRectAnimation;
    Button7: TButton;
    FloatAnimation8: TFloatAnimation;
    RectAnimation7: TRectAnimation;
    Button8: TButton;
    FloatAnimation9: TFloatAnimation;
    RectAnimation8: TRectAnimation;
    Button9: TButton;
    FloatAnimation10: TFloatAnimation;
    RectAnimation9: TRectAnimation;
    Button10: TButton;
    FloatAnimation11: TFloatAnimation;
    RectAnimation10: TRectAnimation;
    Button11: TButton;
    FloatAnimation12: TFloatAnimation;
    RectAnimation11: TRectAnimation;
    Button12: TButton;
    FloatAnimation13: TFloatAnimation;
    RectAnimation12: TRectAnimation;
    Button13: TButton;
    FloatAnimation14: TFloatAnimation;
    RectAnimation13: TRectAnimation;
    Button14: TButton;
    FloatAnimation15: TFloatAnimation;
    RectAnimation14: TRectAnimation;
    Button15: TButton;
    FloatAnimation16: TFloatAnimation;
    RectAnimation15: TRectAnimation;
    Button16: TButton;
    FloatAnimation17: TFloatAnimation;
    RectAnimation16: TRectAnimation;
    Button17: TButton;
    FloatAnimation18: TFloatAnimation;
    RectAnimation17: TRectAnimation;
    Button18: TButton;
    FloatAnimation19: TFloatAnimation;
    RectAnimation18: TRectAnimation;
    Button19: TButton;
    FloatAnimation20: TFloatAnimation;
    RectAnimation19: TRectAnimation;
    Button20: TButton;
    FloatAnimation21: TFloatAnimation;
    RectAnimation20: TRectAnimation;
    Text1: TText;
    FloatAnimationPing: TFloatAnimation;
    FloatAnimationOpa: TFloatAnimation;
    FloatAnimationRun: TFloatAnimation;
    procedure ButtonTrayAgainClick(Sender: TObject);
    procedure Button1DragOver(Sender: TObject; const Data: TDragObject;
      const Point: TPointF; var Operation: TDragOperation);
    procedure Button1DragDrop(Sender: TObject; const Data: TDragObject;
      const Point: TPointF);
    procedure RectAnimation1Finish(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FloatAnimationRunFinish(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
       procedure Score (aPoints:Integer);
       procedure DataLoad;
       procedure DataSave;

  end;

var
  Form1: TForm1;

implementation

{$R *.fmx}

procedure TForm1.Button1DragDrop(Sender: TObject; const Data: TDragObject;
  const Point: TPointF);
  var T,D:TButton;
begin
T:=TButton(Sender);
D:=TButton(Data.Source);
T.Data:=T.Data+T.Data; //2+2
Score (T.Data);      //Update
D.Data:=0;
T.IsOk:=True;
end;

procedure TForm1.Button1DragOver(Sender: TObject; const Data: TDragObject;
  const Point: TPointF; var Operation: TDragOperation);
begin
if (Sender is TButton) and (Data.Source is TButton)
and Not(Sender=Data.Source)
and (TButton(Sender).Text=TButton(Data.Source).Text)
and (TButton(Data.Source).Text<>'')
then Operation:=TDragOperation.Move
else Operation:=TDragOperation.None;


end;

procedure TForm1.ButtonTrayAgainClick(Sender: TObject);
var I:Integer;
begin
LabelScore.Text:='0';
for I := GridLayout1.ChildrenCount-1 DownTo 0
 do TButton(GridLayout1.Children[I]).Data:=0;
Rectangle1.Visible:=False;
FloatAnimationRun.Start;   //Start Game Animation

end;

procedure TForm1.DataLoad;
var M:TMemoryStream;
I:Integer;
begin
  M:=TMemoryStream.Create;
  try
  M.LoadFromFile(ExtractFilePath(ParamStr(0))+'DragOverQuark.xcx');
  M.Read(I,SizeOf(I));
  LabelBestScore.Text:=IntToStr(I);
  Except
   LabelBestScore.Text:='0';
  end;
  M.Free;
end;

procedure TForm1.DataSave;
var M:TMemoryStream;
I:Integer;
begin
     M:=TMemoryStream.Create;
     try
     I:=LabelBestScore.Text.ToInteger ;
     M.Write(I,SizeOf(I));
     M.SaveToFile(ExtractFilePath(ParamStr(0))+'DragOverQuark.xcx');

     Except
       ON E:Exception do ShowMessage(E.Message);
     end;
     M.Free;
end;

procedure TForm1.FloatAnimationRunFinish(Sender: TObject);
var I,Z:Integer;
  A: Array of Integer;
begin
  Z:=0;
 for I:=GridLayout1.ChildrenCount-1 DownTo 0
  do
    if TButton(GridLayout1.Children[I]).Data=0 then
     begin
       Z:=Z+1;
       SetLength(A,High(A)+2);
       A[High(A)]:=I;
     end;
  if Z>0
  then begin
    I:=Random(High(A));
    TButton(GridLayout1.Children[A[I]]).Data:=Trunc(Exp(ln(2)*(1+Random(3)))); //2,4,8,16
    SetLength(A,0);
    FloatAnimationRun.Start;

  end
  else begin
    Rectangle1.Visible:=True;   //Game over!!
    FloatAnimationGameOver.Start;
  end;

end;

procedure TForm1.FormCreate(Sender: TObject);
begin

RandSeed:=3827643;
DataLoad;
ButtonTrayAgainClick(Nil);
end;

procedure TForm1.RectAnimation1Finish(Sender: TObject);
begin         //button
Tbutton(TFmxObject(Sender).Parent).Margins.Rect:=RectF(2,2,2,2);
end;

procedure TForm1.Score(aPoints: Integer);
var I,B:Integer;
begin
B:=LabelBestScore.Text.ToInteger; //High Score
I:=LabelScore.Text.ToInteger;     //Score
I:=I+aPoints;

Text1.Text:='+'+IntToStr(aPoints);
FloatAnimationping.Start;
FloatanimationOpa.Start;


LabelScore.Text:=IntToStr(I);
if I>B then
begin
  LabelBestScore.Text:=IntToStr(I);   //High Score Update
  DataSave;
end;

end;

{ TButton }

function TButton.GetData: Integer;
begin
    if Text=''
    then Result:=0
    else Result:=StrToInt(Text);

end;

procedure TButton.SetData(const Value: Integer);
begin
  if Value>0
  then Text:=IntToStr(Value)
  else Text:='' ;

end;

procedure TButton.SetIsOk(const Value: Boolean);
begin
  FIsOk := Value;
  StartTriggerAnimation(Self,'IsOk=True');
end;

end.
