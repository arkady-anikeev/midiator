unit MidiDevices;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, MidiClasses, StdCtrls, SyncObjs, CheckLst;

type
  TFormMidiDevices = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    memLog: TMemo;
    Label3: TLabel;
    lbxInputDevices: TCheckListBox;
    lbxOutputDevices: TCheckListBox;
    Label4: TLabel;
    edtSysExData: TEdit;
    btnSendSysEx: TButton;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure lbxInputDevicesClickCheck(Sender: TObject);
    procedure lbxOutputDevicesClickCheck(Sender: TObject);
    procedure btnSendSysExClick(Sender: TObject);
  private
    fCriticalSection: TCriticalSection;
  public
    procedure DoMidiInData( const aDeviceIndex: integer; const aStatus, aData1, aData2: byte );
    procedure DoSysExData( const aDeviceIndex: integer; const aStream: TMemoryStream );
  end;

var
  FormMidiDevices: TFormMidiDevices;

implementation

{$R *.dfm}

procedure TFormMidiDevices.DoMidiInData(const aDeviceIndex: integer; const aStatus,
  aData1, aData2: byte);
var
  i: integer;
begin
  // skip active sensing signals from keyboard
  if aStatus = $FE then Exit;

  fCriticalSection.Acquire;
  memLog.Lines.BeginUpdate;
  try

    // send the messages on to the selected output devices
    for i:=MidiOutput.Devices.COunt - 1 downto 0 do
      if lbxOUtputDevices.Checked[i] then
      begin
        MidiOutput.Send( i, aStatus, aData1, aData2 );
        memLog.Lines.Insert( 0, ' -->' + MidiOutput.Devices[i] );
      end;

    // print the message log
    memLog.Lines.Insert( 0, Format( '[%s] %s: <Status> %.2x, <Data 1> %.2x <Data 2> %.2x',
      [ FormatDateTime( 'HH:NN:SS.ZZZ', now ),
        MidiInput.Devices[aDeviceIndex],
        aStatus,
        aData1,
        aData2 ] ));
  finally
    memLog.Lines.EndUpdate;
    fCriticalSection.Leave;
  end;
end;

procedure TFormMidiDevices.FormCreate(Sender: TObject);
begin
  fCriticalSection := TCriticalSection.Create;
  lbxInputDevices.Items.Assign( MidiInput.Devices );
  lbxOutputDevices.Items.Assign( MidiOutput.Devices );

  MidiInput.OnMidiData := DoMidiInData;
  MidiInput.OnSysExData := DoSysExData;
end;

procedure TFormMidiDevices.FormDestroy(Sender: TObject);
begin
  FreeAndNil( fCriticalSection );
end;

procedure TFormMidiDevices.lbxInputDevicesClickCheck(Sender: TObject);
begin
  if lbxINputDevices.Checked[ lbxInputDevices.ItemIndex ] then
    MidiInput.Open( lbxInputDevices.ItemIndex )
  else
    MidiInput.Close( lbxInputDevices.ItemIndex )
end;

procedure TFormMidiDevices.lbxOutputDevicesClickCheck(Sender: TObject);
begin
  if lbxOutputDevices.Checked[ lbxOutputDevices.ItemIndex ] then
    MidiOutput.Open( lbxOutputDevices.ItemIndex )
  else
    MidiOutput.Close( lbxOutputDevices.ItemIndex )
end;

procedure TFormMidiDevices.DoSysExData(const aDeviceIndex: integer;
  const aStream: TMemoryStream);
begin
  fCriticalSection.Acquire;
  memLog.Lines.BeginUpdate;
  try
    // print the message log
    memLog.Lines.Insert( 0, Format( '[%s] %s: <Bytes> %d <SysEx> %s',
      [ FormatDateTime( 'HH:NN:SS.ZZZ', now ),
        MidiInput.Devices[aDeviceIndex],
        aStream.Size,
        SysExStreamToStr( aStream ) ] ));
  finally
    memLog.Lines.EndUpdate;
    fCriticalSection.Leave;
  end;
end;

procedure TFormMidiDevices.btnSendSysExClick(Sender: TObject);
var
  i: integer;
begin
  for i:=MidiOutput.Devices.COunt - 1 downto 0 do
    if lbxOUtputDevices.Checked[i] then
    begin
      MidiOutput.SendSysEx( i, edtSysExData.Text );
      memLog.Lines.Insert( 0, ' --> ' + MidiOutput.Devices[i] + ' ' + edtSysExData.Text );
    end;
end;

end.
