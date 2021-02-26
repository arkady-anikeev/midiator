program midiator;

uses
  Vcl.Forms,
  main in 'main.pas' {FormMain},
  MidiClasses in 'MidiClasses.pas',
  MidiDevices in 'MidiDevices.pas' {FormMidiDevices},
  Options in 'Options.pas' {OptionsForm},
  MIDI in 'MIDI.pas',
  PianoRoll in 'PianoRoll.pas' {FramePianoRoll: TFrame},
  PianoKeyBoard in 'PianoKeyBoard.pas',
  NotesData in 'NotesData.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFormMain, FormMain);
  Application.CreateForm(TFormMidiDevices, FormMidiDevices);
  Application.CreateForm(TOptionsForm, OptionsForm);
  Application.Run;
end.
