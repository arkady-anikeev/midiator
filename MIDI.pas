unit MIDI;

interface
uses System.Types, mmsystem;

type
  TMIDIInstrument = (midiAcousticGrandPiano, midiBrightAcousticPiano,
                     midiElectricGrandPiano, midiHonkyTonkPiano,
                     midiRhodesPiano, midiChorusedPiano, midiHarpsichord,
                     midiClavinet, midiCelesta, midiGlockenspiel,
                     midiMusicBox, midiVibraphone, midiMarimba, midiXylophone,
                     midiTubularBells, midiDulcimer, midiHammondOrgan,
                     midiPercussiveOrgan, midiRockOrgan, midiChurchOrgan,
                     midiReedOrgan, midiAccordion, midiHarmonica,
                     midiTangoAccordion, midiAcousticGuitarNylon,
                     midiAcousticGuitarSteel, midiElectricGuitarJazz,
                     midiElectricGuitarClean, midiElectricGuitarMuted,
                     midiOverdrivenGuitar, midiDistortionGuitar,
                     midiGuitarHarmonics, midiAcousticBass, midiElectricBassFinger,
                     midiElectricBassPick, midiFretlessBass, midiSlapBass1,
                     midiSlapBass2, midiSynthBass1, midiSynthBass2, midiViolin,
                     midiViola, midiCello, midiContrabass, midiTremoloStrings,
                     midiPizzicatoStrings, midiOrchestralHarp, midiTimpani,
                     midiStringEnsemble1, midiStringEnsemble2, midiSynthStrings1,
                     midiSynthStrings2, midiChoirAahs, midiVoiceOohs,
                     midiSynthVoice, midiOrchestraHit, midiTrumpet, midiTrombone,
                     midiTuba, midiMutedTrumpet, midiFrenchHorn, midiBrassSection,
                     midiSynthBrass1, midiSynthBrass2, midiSopranoSax, midiAltoSax,
                     midiTenorSax, midiBaritoneSax, midiOboe, midiEnglishHorn,
                     midiBassoon, midiClarinet, midiPiccolo, midiFlute,
                     midiRecorder, midiPanFlute, midiBottleBlow, midiShakuhachi,
                     midiWhistle, midiOcarina, midiLead1Square,
                     midiLead2Sawtooth, midiLead3CalliopeLead, midiLead4ChiffLead,
                     midiLead5Charang, midiLead6Voice, midiLead7Fifths,
                     midiLead8BrassLead, midiPad1NewAge, midiPad2Warm,
                     midiPad3Polysynth, midiPad4Choir, midiPad5Bowed,
                     midiPad6Metallic, midiPad7Halo, midiPad8Sweep, midiEmpty0,
                     midiEmpty1, midiEmpty2, midiEmpty3, midiEmpty4, midiEmpty5,
                     midiEmpty6, midiEmpty7, midiEmpty8, midiEmpty9, midiEmpty10,
                     midiEmpty11, midiEmpty12, midiEmpty13, midiEmpty14,
                     midiEmpty15, midiEmpty16, midiEmpty17, midiEmpty18,
                     midiEmpty19, midiEmpty20, midiEmpty21, midiEmpty22,
                     midiEmpty23, midiGuitarFretNoise, midiBreathNoise,
                     midiSeashore, midiBirdTweet, midiTelephoneRing,
                     midiHelicopter, midiApplause, midiGunshot);

const MIDI_DRUMS_COUNT =27;

Type  TMIDIMessage=integer; //DWORD
      TMIDIDrum =Record
          name:string;
          note:byte;
      end;

      TMIDIDrums =Array[0..MIDI_DRUMS_COUNT-1] of TMIDIDrum ;

var
    hDevMidiOut     :HMIDIOUT;
    MIDIDrums:TMIDIDrums= (
 (name:'Bass Drum'; note:35)   //1
,(name:'Kick Drum'; note:36)   //2
,(name:'Snare Cross Stick'; note:37)   //3
,(name:'Snare Drum'; note:38)   //4
,(name:'Hand Clap'; note:39)   //5
,(name:'Electric Snare Drum'; note:40)   //6
,(name:'Floor Tom 2'; note:41)   //7
,(name:'Hi-Hat Closed'; note:42)   //8
,(name:'Floor Tom 1'; note:43)   //9
,(name:'Hi-Hat Foot'; note:44)   //10
,(name:'Low Tom'; note:45)   //11
,(name:'Hi-Hat Open'; note:46)   //12
,(name:'Low-Mid Tom'; note:47)   //13
,(name:'High-Mid Tom'; note:48)   //14
,(name:'Crash Cymbal'; note:49)   //15
,(name:'High Tom'; note:50)   //16
,(name:'Ride Cymbal'; note:51)   //17
,(name:'China Cymbal'; note:52)   //18
,(name:'Ride Bell'; note:53)   //19
,(name:'Tambourine'; note:54)   //20
,(name:'Splash cymbal'; note:55)   //21
,(name:'Cowbell'; note:56)   //22
,(name:'Crash Cymbal 2'; note:57)   //23
,(name:'Vibraslap'; note:58)   //24
,(name:'Ride Cymbal 2'; note:59)   //25
,(name:'High Bongo'; note:60)   //26
,(name:'Low Bongo'; note:61)   //27

);
const
  MIDI_NOTE_ON = $90;
  MIDI_NOTE_OFF = $80;
  MIDI_CHANGE_INSTRUMENT = $C0;
  MIDI_DEVICE = 0;
  MIDI_VEL = 108;


    function MidiOutput_DeviceProps(DeviceID: integer):string;
    function MidiOut_Open(DeviceID: integer):integer;
    function MidiOut_Close():integer;


    function  MIDIEncodeMessage(Msg, Param1, Param2: integer): integer;
    procedure SetCurrentInstrument(CurrentInstrument: TMIDIInstrument);
    procedure NoteOn(NewNote, NewIntensity: byte);
    procedure NoteOff(NewNote, NewIntensity: byte);
    procedure SetPlaybackVolume(PlaybackVolume: cardinal);


    function MidiOut_Test():integer;

implementation
uses SysUtils;




function MIDIEncodeMessage(Msg, Param1, Param2: integer): integer;
begin
  result := Msg + (Param1 shl 8) + (Param2 shl 16);
end;

procedure SetCurrentInstrument(CurrentInstrument: TMIDIInstrument);
begin
  midiOutShortMsg(hDevMidiOut, MIDIEncodeMessage(MIDI_CHANGE_INSTRUMENT, ord(CurrentInstrument), 0));
end;

procedure NoteOn(NewNote, NewIntensity: byte);
var  midimsg: TMIDIMessage;

begin
  midimsg:= MIDIEncodeMessage(MIDI_NOTE_ON, NewNote, NewIntensity);
  midiOutShortMsg(hDevMidiOut,midimsg);
end;

procedure NoteOff(NewNote, NewIntensity: byte);
var  midimsg: TMIDIMessage;
begin
  midimsg := MIDIEncodeMessage(MIDI_NOTE_OFF, NewNote, NewIntensity);
  midiOutShortMsg(hDevMidiOut, midimsg);
end;

procedure SetPlaybackVolume(PlaybackVolume: cardinal);
begin
  midiOutSetVolume(hDevMidiOut, PlaybackVolume);
end;



Function GetManufacturerName(ID:WORD):String;
Var s :string;
begin
 Case ID of
  0:S:='Unknown manufacturer';
  1:S:='Microsoft Corp.'     ;
 34:S:='Advanced Gravis'     ;
 else
  S:= 'Unknown manufacturer'
 end;
GetManufacturerName:=S;
end;

function MidiOutput_DeviceProps(DeviceID: integer):string;
var OutCaps:TMidiOutCaps;
    S:String;
begin

 midiOutGetDevCaps(DeviceID,PMidiOutCaps(Addr(OutCaps)),SizeOf(TMidiOutCaps));
 {Manufacturer ID}
  S:='Device ID: '+IntToStr(DeviceID);
  S:=S+#10#13+'Manufacturer ID: '+GetManufacturerName(OutCaps.wMid) +'('+IntToStr(OutCaps.wMid)+')';
  S:=S+#10#13+'Product ID: '+IntToStr(OutCaps.wPid);  {product ID}
  S:=S+#10#13+'Driver version: '+IntToStr(Hi(OutCaps.vDriverVersion))+'.'+IntToStr(Lo(OutCaps.vDriverVersion)); { version of the driver }
  S:=S+#10#13+'Product name: '+OutCaps.szPname; { product name (NULL terminated string) }
 { type of device }

 Case OutCaps.wTechnology of
  MOD_MIDIPORT : S:= S+#10#13+'Device type:Output port';
  MOD_SYNTH    : S:= S+#10#13+'Device type:Generic internal synth';
  MOD_SQSYNTH  : S:= S+#10#13+'Device type:Square wave internal synth';
  MOD_FMSYNTH  : S:= S+#10#13+'Device type:FM internal synth';
  MOD_MAPPER   : S:= S+#10#13+'Device type:MIDI mapper';
  else           S:= S+#10#13+'Device type:UNKNOWN'
 End;


 S:=S+#10#13+'No of voices: '   +IntToStr(OutCaps.wVoices); { # of voices (internal synth only) }
 S:=S+#10#13+'Max No of notes: '+IntToStr(OutCaps.wNotes);  { max # of notes (internal synth only) }
 S:=S+#10#13+'Channels used: '  +IntToStr(OutCaps.wChannelMask);  { channels used (internal synth only) }
 S:=S+#10#13+'Supports:'; { functionality supported by driver }
 if (OutCaps.dwSupport and MIDICAPS_CACHE   )<>0 then s:=S+#10#13+ ' Patch caching'  ;
 if (OutCaps.dwSupport and MIDICAPS_VOLUME  )<>0 then s:=S+#10#13+ ' Volume control ' ;
 if (OutCaps.dwSupport and MIDICAPS_LRVOLUME)<>0 then s:=S+#10#13+ ' Separate left and right volume control';
 if (OutCaps.dwSupport and MIDICAPS_STREAM  )<>0 then s:=S+#10#13+ ' midiStreamOut function ';
 Result:=s;


end;

function MidiOut_Open(DeviceID: integer):integer;
begin

  MidiOut_Open :=midiOutOpen(@hDevMidiOut, DeviceID, 0, 0, CALLBACK_NULL);
  //  Return value
//Returns MMSYSERR_NOERROR if successful or an error otherwise. Possible error values include the following.

//  MIDIERR_NODEVICE //--No MIDI port was found. This error occurs only when the mapper is opened.
//  MMSYSERR_ALLOCATED   The specified resource is already allocated.
//  MMSYSERR_BADDEVICEID The specified device identifier is out of range.
//  MMSYSERR_INVALPARAM  The specified pointer or structure is invalid.
//  MMSYSERR_NOMEM       The system is unable to allocate or lock memory.

  //SetPlaybackVolume($FFFFFFFF);

end;


function MidiOut_Close():integer;
begin
    midiOutClose(hDevMidiOut);
end;

function MidiOut_Test():integer;
begin
  NoteOn ($3C,$7F);
  sleep(50);
  NoteOff ($3C,$0);

  NoteOn ($3E,$7F);
  sleep(50);
  NoteOff ($3E,$0);

  NoteOn ($40,$7F);
  sleep(50);
  NoteOff ($40,$0);

  //midiOutShortMsg(hDevMidiOut, $007F3C90);
  sleep(500);
  //midiOutShortMsg(hDevMidiOut, $007F3C80);

end;

end.
