object FormMidiDevices: TFormMidiDevices
  Left = 219
  Top = 153
  Caption = 'Midi Demo'
  ClientHeight = 326
  ClientWidth = 449
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  DesignSize = (
    449
    326)
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 69
    Height = 13
    Caption = 'Input Devices:'
  end
  object Label2: TLabel
    Left = 224
    Top = 8
    Width = 74
    Height = 13
    Caption = 'Ouput Devices:'
  end
  object Label3: TLabel
    Left = 8
    Top = 144
    Width = 21
    Height = 13
    Caption = 'Log:'
  end
  object Label4: TLabel
    Left = 8
    Top = 316
    Width = 32
    Height = 13
    Anchors = [akLeft, akBottom]
    Caption = 'SysEx:'
  end
  object memLog: TMemo
    Left = 8
    Top = 160
    Width = 441
    Height = 145
    Anchors = [akLeft, akTop, akRight, akBottom]
    ScrollBars = ssVertical
    TabOrder = 0
    WordWrap = False
  end
  object lbxInputDevices: TCheckListBox
    Left = 8
    Top = 27
    Width = 209
    Height = 113
    OnClickCheck = lbxInputDevicesClickCheck
    ItemHeight = 13
    TabOrder = 1
  end
  object lbxOutputDevices: TCheckListBox
    Left = 224
    Top = 24
    Width = 225
    Height = 113
    OnClickCheck = lbxOutputDevicesClickCheck
    Anchors = [akLeft, akTop, akRight]
    ItemHeight = 13
    TabOrder = 2
  end
  object edtSysExData: TEdit
    Left = 48
    Top = 312
    Width = 321
    Height = 21
    Anchors = [akLeft, akRight, akBottom]
    TabOrder = 3
  end
  object btnSendSysEx: TButton
    Left = 376
    Top = 311
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'Send'
    TabOrder = 4
    OnClick = btnSendSysExClick
  end
end
