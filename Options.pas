unit Options;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TOptionsForm = class(TForm)
    Button1: TButton;
    Button2: TButton;
    cbInputDevices: TComboBox;
    Label1: TLabel;
    cbOutputDevices: TComboBox;
    Label2: TLabel;
    DevicePropsLabel: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure cbOutputDevicesChange(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    Procedure CreateDeviceLists(sender:TObject) ;
  end;

var
  OptionsForm: TOptionsForm;

implementation
uses MIDI,MMSystem;
{$R *.dfm}


procedure TOptionsForm.FormCreate(Sender: TObject);
begin
   CreateDeviceLists(Sender);
end;

procedure TOptionsForm.Button1Click(Sender: TObject);
begin
  Self.Close;
end;

procedure TOptionsForm.cbOutputDevicesChange(Sender: TObject);
begin
  DevicePropsLabel.Caption:= MidiOutput_DeviceProps(cbOutputDevices.ItemIndex);
  MidiOut_Open (cbOutputDevices.ItemIndex);
end;

procedure TOptionsForm.CreateDeviceLists(sender:TObject) ;
var NumOfMIDIOutDevs:UINT;
    OutCaps:TMidiOutCaps;
    lpOutCaps:PMidiOutCaps;

    NumOfMIDIInDevs:UINT;
    InCaps:TMidiInCaps;
    lpInCaps:PMidiInCaps;

    i:integer;
begin
 //MIDI Output devices
 lpOutCaps:=PMidiOutCaps(Addr(OutCaps));
 NumOfMIDIOutDevs:=midiOutGetNumDevs;
 if NumOfMIDIOutDevs <1 then exit;
 For i:=0 to NumOfMIDIOutDevs-1 do
 begin
  midiOutGetDevCaps(UINT(i),lpOutCaps,SizeOf(TMidiOutCaps));
  cbOutputDevices.Items.Insert(i,OutCaps.szPname);
 end;
 //MIDI Input devices
 lpInCaps:=PMidiInCaps(Addr(InCaps));
 NumOfMIDIInDevs:=midiInGetNumDevs;
 if NumOfMIDIInDevs <1 then exit;

 For i:=0 to NumOfMIDIInDevs-1 do
 begin
  midiInGetDevCaps(UINT(i),lpInCaps,SizeOf(TMidiInCaps));
  cbInputDevices.Items.Insert(i,InCaps.szPname);
 end;

end;









end.
