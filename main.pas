unit main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, Vcl.ImgList, Vcl.ComCtrls,
  System.Actions, Vcl.ActnList, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.StdActns,
  Vcl.ToolWin, Vcl.Tabs,MidiClasses, Vcl.Grids, Vcl.XPMan, PianoRoll;

type
  TFormMain = class(TForm)
    PanelTree: TPanel;
    PanelMemo: TPanel;
    SplitterTreeToWork: TSplitter;
    SplitterTabsToDebug: TSplitter;
    PanelWork: TPanel;
    MemoDebug: TMemo;
    MainMenu: TMainMenu;
    ActionList: TActionList;
    TreeViewMain: TTreeView;
    ImageListTree: TImageList;
    ImageListSelected: TImageList;
    ImageListEnabled: TImageList;
    File1: TMenuItem;
    New1: TMenuItem;
    miOpen: TMenuItem;
    Save1: TMenuItem;
    SaveAs1: TMenuItem;
    Print1: TMenuItem;
    PrintSetup1: TMenuItem;
    Exit1: TMenuItem;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    Edit1: TMenuItem;
    Undo1: TMenuItem;
    Cut1: TMenuItem;
    Copy1: TMenuItem;
    Paste1: TMenuItem;
    GoTo1: TMenuItem;
    N5: TMenuItem;
    N6: TMenuItem;
    EditCut1: TEditCut;
    EditCopy1: TEditCopy;
    EditSelectAll1: TEditSelectAll;
    FileOpen1: TFileOpen;
    FileSaveAs1: TFileSaveAs;
    FileExit1: TFileExit;
    ToolBarMain: TToolBar;
    ToolButton1: TToolButton;
    acPlay: TAction;
    ImageListDisabled: TImageList;
    ToolButton2: TToolButton;
    acPause: TAction;
    Play1: TMenuItem;
    acPause1: TMenuItem;
    acRewind: TAction;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    Rewind1: TMenuItem;
    acRecord: TAction;
    Record1: TMenuItem;
    acOptions: TAction;
    ToolButton5: TToolButton;
    ToolButton6: TToolButton;
    PanelTabs: TPanel;
    EditPaste1: TEditPaste;
    ImageListSmall: TImageList;
    PageControlMain: TPageControl;
    TabSheetStructure: TTabSheet;
    TabSheetTracks: TTabSheet;
    TabSheetPianoRoll: TTabSheet;
    TabSheetDrumMachine: TTabSheet;
    DrawGrid1: TDrawGrid;
    StringGridDrums: TStringGrid;
    FramePianoRoll1: TFramePianoRoll;
    XPManifest: TXPManifest;
    procedure acPlayExecute(Sender: TObject);
    procedure acOptionsExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FramePianoRoll1PaintBoxKeysPaint(Sender: TObject);
  private
    { Private declarations }

  public
    { Public declarations }
    CurrentMidiDeviceNo:integer;
    MidiOut:TMidiOutput;
    procedure InitMIDIDevice(DeviceNo:integer);
    procedure InitGrids(Sender: TObject);

  end;

const
    DEFAULT_MIDI_DEVICE_NO=0;
var
  FormMain: TFormMain;

implementation
uses MIDI, Options, MidiDevices,NotesData,mmsystem;
{$R *.dfm}

procedure TFormMain.InitMIDIDevice(DeviceNo:integer);
var result:integer;
    s:string;
begin

  result:=MidiOut_Open(DeviceNo);
  if result = MMSYSERR_NOERROR then
  begin
     CurrentMidiDeviceNo:=DeviceNo;
     MemoDebug.Lines.Add('Opened device No:'+inttostr(DeviceNo));
     s:=MidiOutput_DeviceProps(CurrentMidiDeviceNo);
  end
  else
  begin
    case  result of

    MIDIERR_NODEVICE    : s:='No MIDI port was found. This error occurs only when the mapper is opened.';
    MMSYSERR_ALLOCATED  : s:='The specified resource is already allocated.';
    MMSYSERR_BADDEVICEID: s:='The specified device identifier is out of range.';
    MMSYSERR_INVALPARAM : s:='The specified pointer or structure is invalid.';
    MMSYSERR_NOMEM      : s:='The system is unable to allocate or lock memory.';

    end;
  end;
  MemoDebug.Lines.Add(s);

  // MidiOut.Open(CurrentMidiDeviceNo);
   //MidiOut.Send (CurrentMidiDeviceNo, MSB_NOTE_ON, 0, 0: byte)
end;
procedure TFormMain.InitGrids (Sender: TObject) ;
  var Col,Row: Integer;
   s:string;
begin
  FramePianoRoll1.SpinEditScaleX.Value:=4;
  FramePianoRoll1.SpinEditScaleY.Value:=4;
  FramePianoRoll1.ScrollBarHorizontal.Max :=NumOfMeasures;//1000;

  if StringGridDrums.ColWidths[0]<>200 then StringGridDrums.ColWidths[0]:=200;
  StringGridDrums.Colcount:=17;
  StringGridDrums.RowCount:= MIDI_DRUMS_COUNT;
  for Row:=0 to MIDI_DRUMS_COUNT-1 do
  begin
    s:=MIDIDrums[Row].Name;
    StringGridDrums.Cells[0,Row]:=S;
  end;
end;

procedure TFormMain.acOptionsExecute(Sender: TObject);
begin
  OptionsForm.ShowModal;
end;

procedure TFormMain.acPlayExecute(Sender: TObject);
begin
  midiOut_test();
end;


procedure TFormMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  midiOut_Close();
end;

procedure TFormMain.FormCreate(Sender: TObject);
var r:integer;
begin
  InitMIDIDevice(DEFAULT_MIDI_DEVICE_NO);
  InitGrids(Sender);
end;

procedure TFormMain.FramePianoRoll1PaintBoxKeysPaint(Sender: TObject);
begin
  FramePianoRoll1.PaintBoxKeysPaint(Sender);
end;

end.
