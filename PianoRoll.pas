unit PianoRoll;

interface
uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,PianoKeyBoard, Vcl.ExtCtrls,
  Vcl.StdCtrls, Vcl.Samples.Spin;

type
  TFramePianoRoll = class(TFrame)
    ScrollBarVertical: TScrollBar;
    Panel3: TPanel;
    PaintBox: TPaintBox;
    PanelControls: TPanel;
    Splitter1: TSplitter;
    PanelKeys: TPanel;
    PaintBoxKeys: TPaintBox;
    PaintBoxMarkers: TPaintBox;
    Panel1: TPanel;
    ScrollBarHorizontal: TScrollBar;
    Button1: TButton;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    SpinEditScaleX: TSpinEdit;
    SpinEditScaleY: TSpinEdit;
    Label4: TLabel;
    Label5: TLabel;
    procedure PaintBoxPaint(Sender: TObject);
    procedure ScrollBarVerticalChange(Sender: TObject);
    procedure PaintBoxKeysPaint(Sender: TObject);
    procedure PaintBoxMarkersPaint(Sender: TObject);
    procedure PaintBoxMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ScrollBarHorizontalChange(Sender: TObject);
    procedure FrameResize(Sender: TObject);
    procedure SpinEditScaleChange(Sender: TObject);

  private
    { Private declarations }

  procedure WMMOUSEWHEEL(var Msg: TMessage); message WM_MOUSEWHEEL;



  public
    { Public declarations }
    PianoKeyBoard:TPianoKeyBoard;
    function ScaleFactorV:integer;
    function ScaleFactorH:integer;
    function DY:integer;
    function DX:integer;

  end;

implementation
uses NotesData;
{$R *.dfm}
const
    //local const



      PianoKeyLength =100;
      PianoKeyHight = 80;  // on sacale 1
      BeatWidth:integer=80; // on sacale 1

      BeatResolution:integer =4 ;

      //global const
      TempoNumerator:integer =3;
      TempoDenominator:integer =4;


      //DX = 20;
      //DY = 15;
      //PianoKeyHight= DY;



        MK_LBUTTON  =$0001 ;//The left mouse button is down.
        MK_RBUTTON  =$0002 ;//The right mouse button is down.
        MK_SHIFT    =$0004 ;//The SHIFT key is down.
        MK_CONTROL  =$0008 ;//The CTRL key is down.
        MK_MBUTTON  =$0010 ;//The middle mouse button is down.
        MK_XBUTTON1 =$0020 ; //The first X button is down.
        MK_XBUTTON2 =$0040 ;//The second X button is down.



procedure TFramePianoRoll.FrameResize(Sender: TObject);
var NumOfKeysVisible:integer;
    NumOfCellsVisible:integer;
begin
  NumOfKeysVisible:=PaintBoxKeys.Height div DY;
  ScrollBarVertical.Max:=NumOfKeys-NumOfKeysVisible;
  NumOfCellsVisible:=PaintBoxKeys.Width div DX;
  ScrollBarHorizontal.Max:=NumOfKeys-NumOfKeysVisible;

  invalidate;
end;

procedure TFramePianoRoll.PaintBoxKeysPaint(Sender: TObject);
 var C:TCanvas;
      SaveBrush:Tbrush;

    BY,
    SX,SY,
    i,N:integer;
    TextShiftY:integer;
    s:string;
    R:TRect;
    iNote   :integer;
    iOctave :integer;


begin
     C:=PaintBoxKeys.Canvas;
     //Фон
     C.Pen.Color:=clBlack;
     C.Brush.Color:=clWhite;
     C.Rectangle(0,0,PaintBox.Width,PaintBox.Height);

     BY:=-ScrollBarVertical.Position*DY;
     SX:=(DX*NumOfMeasures+1);  SY:=DY*(NumOfKeys+1);

     C.Pen.Color:=clBlack;

     For N:=0 to NumOfKeys do
     begin
       iNote  :=N mod 12 +1;
       iOctave:=N div 12;

       C.Pen.Color:=clBlack;
       C.Brush.Color:=clWhite;

       //Контроль
       R.Left  :=0     ;
       R.Top   :=BY+SY-(N+1)*DY;
       R.Right :=PianoKeyLength ;
       R.Bottom:=BY+SY-(N)*DY ;



       Case iNote of
         {1,6:begin
           C.Brush.Color:=clWhite;
           C.Brush.Style:=bsClear;
           C.Pen.Color:= clBlack;
           R.Left  :=0     ;
           R.Top   :=BY+SY-(N+1)*DY -(DY div 2)     ;
           R.Right :=PianoKeyLength ;
           R.Bottom:=BY+SY-(N)*DY ;
           C.Rectangle(R.Left,R.Top   ,R.Right ,R.Bottom);

           end;//
          }
          1,6:begin
          // C.Brush.Color:=clWhite;
          // C.Brush.Style:=bsClear;
           C.Pen.Color:= clBlack;
           C.Pen.Color:= clBlack;
           C.MoveTo  (0, R.Top);
           C.LineTo  (PianoKeyLength ,R.Top   );

           R.Left  :=0     ;
           R.Top   :=BY+SY-(N+1)*DY -(DY div 2)     ;
           R.Right :=PianoKeyLength ;
           R.Bottom:=BY+SY-(N)*DY ;
           C.Rectangle(R.Left,R.Top   ,R.Right ,R.Bottom);

           end;

          {

         3,8,10:begin
               C.Brush.Color:=clWhite;
               C.Brush.Style:=bsClear;
               C.Pen.Color:= clBlack;
               R.Left  :=0     ;
               R.Top   :=BY+SY-(N+1)*DY -(DY div 2) ;
               R.Right :=PianoKeyLength ;
               R.Bottom:=BY+SY-(N)*DY+(DY div 2) ;
               C.Rectangle(R.Left,R.Top   ,R.Right ,R.Bottom);

             end;//
         5,12:begin
               C.Brush.Color:=clWhite;
               C.Brush.Style:=bsClear;
               C.Pen.Color:= clBlack;
               R.Left  :=0     ;
               R.Top   :=BY+SY-(N+1)*DY ;
               R.Right :=PianoKeyLength ;
               R.Bottom:=BY+SY-(N)*DY+(DY div 2) ;
               C.Rectangle(R.Left,R.Top   ,R.Right ,R.Bottom);

             end;}
         2,4,7,9,11:begin
           C.Brush.Color:=clBlack;
           C.Pen.Color:= clBlack;
           R.Left  :=0     ;
           R.Top   :=BY+SY-(N+1)*DY ;
           R.Right :=(PianoKeyLength*2) div 3 ;
           R.Bottom:=BY+SY-(N)*DY ;
           C.FillRect(R);

           C.Pen.Color:= clBlack;
           C.MoveTo  (R.Right, (R.Top +R.Bottom) div 2    );
           C.LineTo  (PianoKeyLength ,(R.Top +R.Bottom) div 2    );



           C.Pen.Color:= clLtGray;
           C.MoveTo  (R.Right, R.Top    );
           C.LineTo  (R.Left , R.Top    );
           C.MoveTo  (R.Right, R.Top    );
           C.LineTo  (R.Right, R.Bottom );

           C.Pen.Color:= clWhite;
           C.MoveTo  (R.Right-1, R.Top    +1);
           C.LineTo  (R.Left +1, R.Top    +1);
           C.MoveTo  (R.Right-1, R.Top    +1);
           C.LineTo  (R.Right-1, R.Bottom -1);
           end;//


        end;
       if iNote in BlackKeys then
        begin
          C.Brush.Color:=clWhite;
          C.Pen.Color:= clRed;
        end
        else
        begin
          C.Brush.Color:=clWhite;
          C.Pen.Color:= clRed;
        end;
        //c.TextHeight('A1');
        //C.MoveTo(0 ,BY+SY-(N)*DY);
        //C.LineTo(0+PaintBox.Width,BY+SY-(N)*DY);
        ;

        //Key names
         C.font.Name:='ARIAL';
         C.font.color:=clRed;

        TextShiftY:= (DY -c.TextHeight('A1')) div 2;
        R.Left  :=0     ;
        //R.Top   :=BY+SY-(N+1)*DY -(DY div 2);
        R.Top   :=BY+SY-(N+1)*DY+ TextShiftY ;
        R.Right :=100 ;//PianoKeyLength ;
        R.Bottom:=BY+SY-(N)*DY  - TextShiftY    ;

        //C.Rectangle(R.Left,R.Top   ,R.Right ,R.Bottom);
        SaveBrush:= C.brush;
        C.brush.style:=bsClear;
        C.TextOut  (R.Left+1,R.Top ,IntToStr(N)+' :'+KeyNames[iNote]+' '+IntToStr(iOctave));
        C.brush:=SaveBrush;

     end;


end;

procedure TFramePianoRoll.PaintBoxMarkersPaint(Sender: TObject);
Var s:string;
    C:TCanvas;
    N:integer;
    MaxNumOfBeats, NumOfBeatsInMeasure,BeatNum:integer;
    bx:integer;

begin

    MaxNumOfBeats:= NumOfMeasures*TempoNumerator;
    NumOfBeatsInMeasure:=TempoNumerator;
    BeatNum:=NumOfBeatsInMeasure*BeatResolution ;

    BX:= ScrollBarHorizontal.Position*NumOfBeatsInMeasure*BeatResolution*DX; //one measure to min change

    C:=PaintBoxMarkers.Canvas;

     For N:=0 to MaxNumOfBeats*BeatResolution do
     begin

        if (N mod 4) =0 then
        begin
        S:= ''+IntToStr(N div (BeatNum)+1); // measure
        S:=S +':'+IntToStr((N mod (BeatNum)+1)div 4+1);
        end
        else s:='.';
       //TextX:=
       C.TextOut(N*DX -BX +(DX div 2)- (C.TextWidth(S) div 2),10+C.TextHeight(S)-2,S);
     end;
end;

procedure TFramePianoRoll.PaintBoxPaint(Sender: TObject);
var C:TCanvas;
    BX,BY,//DX,
    SX,SY,
    i,N:integer;
    s:string;
    R:TRect;
    iNote   :integer;
    iOctave :integer;

    хShift:integer;

    MaxNumOfBeats, NumOfBeatsInMeasure:integer;

begin

    MaxNumOfBeats:= NumOfMeasures*TempoNumerator;
    NumOfBeatsInMeasure:=TempoNumerator;

     BY:=-ScrollBarVertical.Position*DY;
     SX:=DX*(NumOfMeasures+1);  SY:=DY*(NumOfKeys+1);

     C:=PaintBox.Canvas;
     //Фон
     C.Brush.Color:=clWhite;
     C.Rectangle(0,0,PaintBox.Width,PaintBox.Height);

     //C.Rectangle(0,BY,PianoKeyLength+SX,BY+SX);
     C.Pen.Color:=clBlack;

     For N:=0 to NumOfKeys do
     begin
       iNote  :=N mod 12 +1;
       iOctave:=N div 12;

       C.Pen.Color:=clBlack;
       C.Brush.Color:=clWhite;

       //Горизонтальные линии
       C.Brush.Color:=clWhite;
       C.Pen.Style:= psSolid ;
       if iNote =1 then C.Pen.Color:= clRed  else C.Pen.Color:= clGray;

       C.MoveTo(0 ,BY+SY-(N)*DY);
       C.LineTo(0+PaintBox.Width,BY+SY-(N)*DY);

     end;

     //Вертикальные линии

     //FirstCellNo
     BX:= ScrollBarHorizontal.Position*NumOfBeatsInMeasure*BeatResolution*DX; //one measure to min change

     For N:=0 to MaxNumOfBeats*BeatResolution do
     begin


       C.Pen.Color:= clLtGray;                                          // base grid
       if (N mod BeatResolution)=0 then C.Pen.Color:= clGray;           //each bit
       if (N mod (NumOfBeatsInMeasure*BeatResolution))=0 then C.Pen.Color:= clBlack; //each measure

       C.MoveTo(0+N*DX -BX,BY);
       C.LineTo(0+N*DX-BX,BY+SY);
       C.TextOut (0+N*DX-BX,BY, inttostr(N))

     end;

     PaintBoxMarkersPaint(Sender);

    {
    //Ноты
     C.Pen.Style:= psSolid ;
     C.Brush.Color:=clFuchsia;
     For i:=0 to NY-1 do
     For N:=0 to NX-1 do
     begin
         if Notes[i,N]<>0 then
         begin
           C.Pen.Color:= clBlack ;
           R.Left  :=PianoKeyLength+i*DX+1      ;
           R.Top   :=BY+SY-(N+1)*DY ;
           R.Right :=PianoKeyLength+(i+1)*DX    ;
           R.Bottom:=BY+SY-(N)*DY   ;
           C.Rectangle(R.Left,R.Top   ,R.Right ,R.Bottom);
           C.Pen.Color:= clWhite ;
           C.MoveTo  (R.Left +1, R.Top    +1);
           C.LineTo  (R.Right-1, R.Top    +1);
           C.MoveTo  (R.Left +1, R.Top    +1);
           C.LineTo  (R.Left +1, R.Bottom -1);
         end;
     end;
     }
    end;

procedure TFramePianoRoll.PaintBoxMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);

var sx,sy,
  BY, BX,
  NoteNo,
 NumOfBeatsInMeasure,TimeInPixels ,TimeInTicks:integer;

 BeatSize,
 MeasureSize,
 MeasureNo,
 BeatNo,
 TickNo:integer;
begin

      Label1.Caption:='x:'+inttostr(x)+' y:'+inttostr(y);
      BY:=-ScrollBarVertical.Position*DY;
      SX:=BeatWidth*(NumOfMeasures+1);

      SY:=DY*(NumOfKeys+1);
      NoteNo:=(by+sy-y)div DY;

      NumOfBeatsInMeasure:=TempoNumerator;
      BX:= ScrollBarHorizontal.Position*NumOfBeatsInMeasure*BeatResolution*DX; //
      TimeInPixels:=(x+BX);//div DX ;// 1 "tick" =1/4 of beat
      //-----
      BeatSize:=BeatResolution*DX; //in pixels
      MeasureSize:=BeatSize*TempoNumerator;

      TimeInTicks :=((x+BX)*TicksPerBit) div BeatSize;


      MeasureNo:= TimeInPixels div MeasureSize; //(+1)
      BeatNo:=(TimeInPixels - MeasureNo* MeasureSize) div  BeatSize; //(+1)
      TickNo:= ((TimeInPixels -  MeasureNo* MeasureSize - BeatNo*BeatSize )*TicksPerBit) div BeatSize;

      Label2.Caption:= 'No:'+inttostr(NoteNo)
                    +' Pix:'+intTostr(TimeInPixels)
                    +' Tick:'+intTostr(TimeInTicks)
                    +' M:'+intTostr(MeasureNo+1)
                    +' B:'+intTostr(BeatNo+1)
                    +' T:'+intTostr(TickNo);



end;


procedure TFramePianoRoll.WMMOUSEWHEEL(var Msg: TMessage);
var
iStep : Integer;
ud: SmallInt; //Up or Down
mk:WORD;
mouseX,MouseY:integer;
p:Tpoint;

begin
//
  ud := HiWord(Msg.wParam);
  mk := LoWord(Msg.wParam);
    if ud <= 0 then iStep := -1// Msg.wParam := VK_UP
               else iStep := 1; //Msg.wParam := VK_DOWN;
  mouseX:= loWord(Msg.lParam) ;              ;
  mouseY:= hiWord(Msg.lParam);

  p:=ClientToScreen(Point(PaintBox.Left, PaintBox.Top));

  mouseX:=mouseX-p.X;
  mouseY:=mouseY-p.y-panel1.Height;

  Label2.Caption:= 'x:'+inttostr(p.X)+' y:'+inttostr(p.y);
  Label3.Caption:= 'x:'+inttostr(mouseX)+' y:'+inttostr(mouseY);

//  if mk AND MK_CONTROL>0   then //The CTRL key is down.
  if mouseX<0 then
    SpinEditScaleY.Value:=SpinEditScaleY.Value+iStep
   else

  //if mk AND MK_SHIFT>0   then //The SHIFT key is down.
  if mouseY<0 then
     SpinEditScaleX.Value:=SpinEditScaleX.Value+iStep
    else
  if mk AND MK_SHIFT>0   then //The SHIFT key is down.
    ScrollBarHorizontal.Position := ScrollBarHorizontal.Position - iStep*ScrollBarHorizontal.LargeChange
  else
  ScrollBarVertical.Position := ScrollBarVertical.Position - iStep*ScrollBarVertical.LargeChange;
 inherited;
end;



function TFramePianoRoll.ScaleFactorH: integer;
begin
  ScaleFactorH:=SpinEditScaleX.Value ;
end;

function TFramePianoRoll.ScaleFactorV: integer;
begin
 ScaleFactorV :=SpinEditScaleY.Value ;
end;

function TFramePianoRoll.DX: integer;
begin
  DX:=BeatWidth div ScaleFactorH;
end;

function TFramePianoRoll.DY: integer;
begin
  DY:=PianoKeyHight div ScaleFactorV//15;
end;

procedure TFramePianoRoll.ScrollBarHorizontalChange(Sender: TObject);
begin
  PaintBoxPaint (Sender);
   PaintBoxKeysPaint(Sender);
end;

procedure TFramePianoRoll.ScrollBarVerticalChange(Sender: TObject);
begin
  PaintBoxPaint (Sender);
  PaintBoxKeysPaint(Sender);

end;

procedure TFramePianoRoll.SpinEditScaleChange(Sender: TObject);
begin
  FrameResize(Sender)
end;

end.
